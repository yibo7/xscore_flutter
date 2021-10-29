import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
class NavigatorUtil {
  static void pushPage(BuildContext context,Widget page) {
    if (context == null || page == null) return;
    Navigator.push(context, new CupertinoPageRoute<void>(builder: (ctx) => page));
  }
  /*
  url 的值
  打开浏览器 :http://flutter.dev
  发送Email:mailto:$email?subject=$subject&body=$body
  打电话: tel:+12345678901
  发短信: sms:15956568989
  * */
  static void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showToast("错误的地址:$url");
    }
  }

  static void pushNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushNamed(pageName);
  }
  //把当前页面在栈中的位置替换成跳转的页面（替换导航器的当前路由，通过推送路由[routeName]），当新的页面进入后，之前的页面将执行dispose方法。
  static void pushReplacementNamed(BuildContext context, String pageName) {
    Navigator.of(context).pushReplacementNamed(pageName);
  }

  static void pushNamedArg( context,  pageName,arguments) {
    Navigator.of(context).pushNamed(pageName,arguments:arguments );
  }

}
