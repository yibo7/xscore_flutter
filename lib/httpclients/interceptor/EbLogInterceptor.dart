// import 'package:dio/dio.dart';
// import 'package:xscore/utils/log_util.dart';
// class EbLogInterceptor extends LogInterceptor{
//   EbLogInterceptor():super(responseBody: true,logPrint: LogUtil.httpClient);
//   final isOpenLog = false;
//   @override
//   Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
//     // logPrint('*** 开始请求时间 ***');
//     // logPrint(DateTime.now());
//     if(isOpenLog)
//       super.onRequest(options,handler);
//   }
//   @override
//   Future onResponse(Response response,ResponseInterceptorHandler handler) async {
//     // logPrint('*** 响应时间 ***');
//     // logPrint(DateTime.now());
//     if(isOpenLog)
//       super.onResponse(response,handler);
//   }
// }