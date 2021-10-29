
/// Log Util.
class LogUtil {
  static const String _TAG_DEF = "###common_utils###";

  static bool _debuggable = true; //是否是debug模式,true: log v 不输出.
  static String TAG = _TAG_DEF;

  static void init({bool isDebug = false, String tag = _TAG_DEF}) {
    _debuggable = isDebug;
    TAG = tag;
  }

  static void err(Object object, {String tag}) {
    _printLog(tag, '  err  ', object);
  }

  static void debug(Object object, {String tag}) {
    if (_debuggable) {
      _printLog(tag, '  debug  ', object);
    }
  }


  static void httpClient(Object object) {
    debug(object,tag: "HTTP请求日志");
  }


  static void _printLog(String tag, String stag, Object object) {
    String da = object.toString();
    String _tag = (tag == null || tag.isEmpty) ? TAG : tag;
    while (da.isNotEmpty) {
      if (da.length > 512) {
        print("$_tag $stag ${da.substring(0, 512)}");
        da = da.substring(512, da.length);
      } else {
        print("$_tag $stag $da");
        da = "";
      }
    }
  }

}
