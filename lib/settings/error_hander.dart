
import 'package:oktoast/oktoast.dart';
import 'package:xscore/eventbus/LoginCheckingEvent.dart';
import 'package:xscore/eventbus/bus_event.dart';
import 'package:xscore/utils/log_util.dart';

class ErrHander{

  static void DioErr(int code,String msg,String fromUrl){
    LogUtil.debug("来自$fromUrl的远程请求出错，错误码：$code,错误消息：$msg");
    if(code==101){
      ApplicationEvent.event.fire(LoginCheckingEvent(false));
    }
    else{
      // showToast(msg);
    }


  }
  static void customErr(String msg){
    showToast(msg);
    LogUtil.debug("发生错误：$msg");
  }
}
class ErrorEntity {
  int code;
  String message;
  ErrorEntity({this.code, this.message});
}