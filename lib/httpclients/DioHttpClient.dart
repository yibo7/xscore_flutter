import 'dart:convert';
import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:xscore/settings/global.dart';
import 'package:xscore/utils/WatchTime.dart';
import 'package:xscore/utils/log_util.dart';
import 'ApiResult.dart';
import 'JsonEntity.dart';
import 'JsonListEntity.dart';
import '../settings/error_hander.dart';


class DioHttpClient {
  static const String GET = 'get';
  static const String POST = 'post';
  static const String PUT = 'put';
  static const String PATCH = 'patch';
  static const String DELETE = 'delete';
//  static final DioHttpClient _shared = DioHttpClient._init(ApiUrls.baseApi);
//  factory DioHttpClient() => _shared;

  Dio _dio;

  //region Dio初始化配置
  //,[Map<String, dynamic> header]

  DioHttpClient(String apiBaseUrl,bool isPrintLog,[Map<String, dynamic> header]) {
    BaseOptions options = BaseOptions(
      baseUrl: apiBaseUrl,headers: header,
      contentType: Headers.jsonContentType,
      responseType: ResponseType.json,
      receiveDataWhenStatusError: false,
      connectTimeout: 6000,
      receiveTimeout: 3000,
    );

    _dio = Dio(options)
      ..httpClientAdapter = _getHttpClientAdapter()
      ..interceptors.add(getCacheManager(apiBaseUrl).interceptor)
      ..interceptors.add(LogInterceptor(responseBody: isPrintLog));

  }

  // set proxy
  DefaultHttpClientAdapter _getHttpClientAdapter() {
    DefaultHttpClientAdapter httpClientAdapter = DefaultHttpClientAdapter();
    httpClientAdapter.onHttpClientCreate = (HttpClient client) {
//      client.findProxy = (uri) {  //如果使用代理请求这样设置
//        return 'PROXY 10.0.0.103:6152';
//      };
      client.badCertificateCallback =(X509Certificate cert, String host, int port) {
        return true;  //调试的情况下直接返回真，真正发布时要使用正确验证
      };
    };
    return httpClientAdapter;
  }

  //endregion

  // region 缓存处理
  DioCacheManager _dioCache;
  DioCacheManager getCacheManager(String baseApi) {
    if (null == _dioCache) {
      _dioCache =DioCacheManager(CacheConfig(baseUrl: baseApi));

    }
    return _dioCache;
  }
  //清除过期的缓存，默认会自动调用，所以这个方法一般不建议手动调用
  void clearExpiredCache(){
    _dioCache.clearExpired();
  }
  //清除所有缓存
  void clearAllCache(){
    _dioCache.clearAll();
  }

  void deleteCache(String primaryKey, {String sMethod, String subKey}){
    _dioCache.delete(primaryKey,requestMethod:sMethod,subKey:subKey);
  }
  //endregion

  //region get请求

  //get调用api并返回字符串
  Future<String> getStr(String path, {Map<String, dynamic> params,Duration cacheTime}) async {

    try {
      WatchTime wt = WatchTime();
      Options opt;
      if(cacheTime==null){
        opt = Options();
      }else{
        opt = buildCacheOptions(cacheTime);
      }
      Response<String> response = await _dio.get(path,queryParameters: params,options: opt);
      wt.endToPrint(path);
      if (response != null) {
        return response.toString();
      } else {
        return "未知错误";
      }
    } on DioError catch(e) {
      return e.toString();
    }
  }
  //get调用并返回一个实体
  Future<T> getEntity<T>(String url,{Map<String, dynamic> params,Duration cacheTime}) async{
    return request(GET,url,param:params,cacheT: cacheTime);
  }
  //get调用并返回一个列表
  Future<List<T>> getEntityList<T>(String url,{Map<String, dynamic> params,Duration cacheTime}) async{
    return requestList(GET,url,param:params,cacheT: cacheTime);
  }
  //endregion

  //region post请求
  Future<ApiResult> post(String url, {Map<String, dynamic> params,Duration cacheTime}) async {

    try {
      WatchTime wt = WatchTime();
      Options opt;
      if(cacheTime==null){
        opt = Options();
      }else{
        opt = buildCacheOptions(cacheTime);
      }
      Response<String> response = await _dio.post(url,queryParameters: params,options: opt);
      wt.endToPrint(url);
      if (response != null) {
        Map<String, dynamic> map = json.decode(response.toString());
        return ApiResult(map["code"],map["msg"].toString(),map["data"]);
      } else {
        ErrHander.DioErr(-1,"未知错误",url);
        return ApiResult(-1,"未知错误",url);
      }
    } on DioError catch(e) {
      ErrorEntity err = createErrorEntity(e);
      ErrHander.DioErr(err.code,err.message,url);
      return  ApiResult(err.code,err.message,url);
    }
  }

  //post调用并返回字符串
  Future<String> postStr(String url, {Map<String, dynamic> params,Duration cacheTime}) async {

    try {
      WatchTime wt = WatchTime();
      Options opt;
      if(cacheTime==null){
        opt = Options();
      }else{
        opt = buildCacheOptions(cacheTime);
      }
      Response<String> response = await _dio.post(url,queryParameters: params,options: opt);
      wt.endToPrint(url);
      if (response != null) {
        return response.toString();
      } else {
        return "未知错误";
      }
    } on DioError catch(e) {
      return e.toString();
    }
  }

  //post调用并返回一个对象
  Future<T> postEntity<T>(String url,{Map<String, dynamic> params,Duration cacheTime}) async{
    return   request(POST,url,param:params,cacheT: cacheTime);
  }
  //post调用并返回一个列表
  Future<List<T>> postEntityList<T>(String url,{Map<String, dynamic> params,Duration cacheTime}) async{
    return   requestList(POST,url,param:params,cacheT:cacheTime);
  }
  //endregion

  //region 通用请求并返回一个实体,支持get,post,put,patch,delete
  Future<T> request<T>(String sMethod, String url, {Map<String, dynamic> param,Duration cacheT}) async {

    try {
      var wt = WatchTime();
      Options opt;
      if(cacheT==null){
        opt =  Options(method: sMethod);
      }
      else{
        opt =  buildCacheOptions(cacheT,options: Options(method: sMethod));
      }
      Response response = await _dio.request(url, queryParameters: param, options: opt);
      wt.endToPrint(url);
      if (response != null) {
        JsonEntity entity = JsonEntity<T>.fromJson(response.data);

        if (entity.code == 0) {
          return entity.data;
        } else {
          ErrHander.DioErr(entity.code,entity.message,url);
        }
      } else {
        ErrHander.DioErr(-1,"未知错误",url);
      }
    } on DioError catch(e) {
      ErrorEntity err = createErrorEntity(e);
      ErrHander.DioErr(err.code,err.message,url);
    }

    return null;
  }

  //endregion

  //region 通用请求返回一个列表,支持支持get,post,put,patch,delete
  Future<List<T>> requestList<T>(String sMethod, String url, {Map<String, dynamic> param,Duration cacheT}) async {

    try {
      WatchTime wt = WatchTime();
      Options opt;
      if(cacheT==null){
        opt =  Options(method: sMethod);
      }
      else{
        opt =  buildCacheOptions(cacheT,options: Options(method: sMethod));
      }

      Response response = await _dio.request(url, queryParameters: param, options: opt);
      wt.endToPrint(url);
      if (response != null) {
        JsonListEntity entity = JsonListEntity<T>.fromJson(response.data);

        if (entity.code == 0) {
          return entity.data;
        } else {
          ErrHander.DioErr(entity.code,entity.message,url);
        }
      } else {
        ErrHander.DioErr(-1,"未知错误",url);
      }
    } on DioError catch(e) {
      ErrorEntity err = createErrorEntity(e);
      if(err.code==101){
        // Global.isLogin = false;
        Global.userId = 0;
        // LogUtil.debug("用户登录状态过期或丢失:${err.message}");
        // ApplicationEvent.event.fire(LoginCheckingEvent(false));
      }
      else{
        //showToast(err.message);
        LogUtil.debug("远程请求出错了:${err.message}");
      }

      // ErrHander.DioErr(err.code,err.message,url);
    }
    return null;
  }

  //endregion

  //以流的形式提交二进制数据
  postStream(String url,Map data,{onProgress} ) async {
    //var stream = new Stream.fromIterable(addrFormBlue);
    // 二进制数据
    String strData = json.encode(data);
    List<int> postData = utf8.encode(strData);

    try {
      Response<String> response = await _dio.post(
        url,
        data: Stream.fromIterable(postData.map((e) => [e])), //创建一个Stream<List<int>>
        options: Options(
          headers: {
            Headers.contentLengthHeader: postData.length, // 设置content-length
          },
        ),
        onSendProgress: (int sent, int total) {
          onProgress(sent,total);
        },
      );
      if (response != null) {
        Map<String, dynamic> map = json.decode(response.toString());
        return ApiResult(map["code"],map["msg"].toString(),map["data"]);
      } else {
        ErrHander.DioErr(-1,"未知错误",url);
        return ApiResult(-1,"未知错误",url);
      }
    } on DioError catch(e) {
      ErrorEntity err = createErrorEntity(e);
      ErrHander.DioErr(err.code,err.message,url);
      return  ApiResult(err.code,err.message,url);
    }
  }

  // region Dio错误处理

  ErrorEntity createErrorEntity(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:{
        return ErrorEntity(code: -1, message: "请求取消");
      }
      break;
      case DioErrorType.CONNECT_TIMEOUT:{
        return ErrorEntity(code: -1, message: "连接超时");
      }
      break;
      case DioErrorType.SEND_TIMEOUT:{
        return ErrorEntity(code: -1, message: "请求超时");
      }
      break;
      case DioErrorType.RECEIVE_TIMEOUT:{
        return ErrorEntity(code: -1, message: "响应超时");
      }
      break;
      case DioErrorType.RESPONSE:{
        try {
          int errCode = error.response.statusCode;
          String errMsg = error.response.statusMessage;
          return ErrorEntity(code: errCode, message: errMsg);
//          switch (errCode) {
//            case 400: {
//              return ErrorEntity(code: errCode, message: "请求语法错误");
//            }
//            break;
//            case 403: {
//              return ErrorEntity(code: errCode, message: "服务器拒绝执行");
//            }
//            break;
//            case 404: {
//              return ErrorEntity(code: errCode, message: "无法连接服务器");
//            }
//            break;
//            case 405: {
//              return ErrorEntity(code: errCode, message: "请求方法被禁止");
//            }
//            break;
//            case 500: {
//              return ErrorEntity(code: errCode, message: "服务器内部错误");
//            }
//            break;
//            case 502: {
//              return ErrorEntity(code: errCode, message: "无效的请求");
//            }
//            break;
//            case 503: {
//              return ErrorEntity(code: errCode, message: "服务器挂了");
//            }
//            break;
//            case 505: {
//              return ErrorEntity(code: errCode, message: "不支持HTTP协议请求");
//            }
//            break;
//            default: {
//              return ErrorEntity(code: errCode, message: "未知错误");
//            }
//          }
        } on Exception catch(_) {
          return ErrorEntity(code: -1, message: "未知错误");
        }
      }
      break;
      default: {
        return ErrorEntity(code: -1, message: error.message);
      }
    }
  }

//endregion

  // void printTime(Stopwatch stopWatch,String url){
  //   // var elapsedString = stopWatch.elapsed.toString();
  //   var millisecond = stopWatch.elapsed.inMilliseconds;
  //   var seconds = stopWatch.elapsed.inSeconds;
  //   LogUtil.debug("$url 执行时间: 毫秒$millisecond 秒:$seconds");
  // }

}



