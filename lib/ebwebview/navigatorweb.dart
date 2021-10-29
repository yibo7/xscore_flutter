import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xscore/utils/object_util.dart';

import 'eb_webview.dart';

class NavigatorWeb{

  //用内部浏览器打开
  static void pushWeb(BuildContext context,
      {String title, String titleId, String url}) {
    if (context == null || ObjectUtil.isEmpty(url)) return;
    if (url.endsWith(".apk")) {
      launchInBrowser(url, title: title ?? titleId);
    } else {
      Navigator.push(
          context,
          new CupertinoPageRoute<void>(
              builder: (ctx) => new EbWebView(
                title: title,
                titleId: titleId,
                url: url,
              )));
    }
  }

  //用浏览器打开地址
  static Future<Null> launchInBrowser(String url, {String title}) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false, forceWebView: false);
    } else {
      throw 'Could not launch $url';
    }
  }
}