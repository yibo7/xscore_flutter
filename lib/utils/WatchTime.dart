import 'package:xscore/settings/global.dart';
import 'log_util.dart';
class WatchTime{
  Stopwatch _st;
    WatchTime(){
      if(Global.isDebug){
        _st = Stopwatch();
        _st.start();
      }
    }
    void endToPrint(String name){
      if(_st!=null){
        var millisecond = _st.elapsed.inMilliseconds;
        var seconds = _st.elapsed.inSeconds;
        LogUtil.debug("$name 执行时间: 毫秒$millisecond 秒:$seconds");
      }
    }
}