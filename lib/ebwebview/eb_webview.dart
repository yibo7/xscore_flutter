import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:share/share.dart';
import 'package:xscore/langconfig/lang_utils.dart';
import 'package:xscore/settings/eb_colors.dart';
import 'package:xscore/settings/gaps.dart';
import '../widgets/likebtn/like_button.dart';
import 'navigatorweb.dart';
//对WebView的封装，可以指定title,url,并且可以返回上一页
class EbWebView extends StatefulWidget {
  const EbWebView({
    Key key,
    this.title,
    this.titleId,
    this.url,
  }) : super(key: key);

  final String title;
  final String titleId;
  final String url;

  @override
  State<StatefulWidget> createState() {
    return new EbWebViewState();
  }
}

class EbWebViewState extends State<EbWebView> {
//  WebViewController _webViewController;
//  bool _isShowFloatBtn = false;
  static TextStyle listContent = TextStyle(
    fontSize: Dimens.font_sp14,
    color: EbColors.text_normal,
  );
  void _onPopSelected(String value) {
    String _title = widget.title ?? LangUtils.getString(context, widget.titleId);
    switch (value) {
      case "browser":
        NavigatorWeb.launchInBrowser(widget.url, title: _title);
        break;
      case "collection":
        break;
      case "share":
        String _url = widget.url;
        Share.share('$_title : $_url');
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.url,
      withZoom: false,// 允许网页缩放
      withLocalStorage: true,// 本地缓存
      withJavascript: true,// 允许执行js代码
      appBar: AppBar(
        title: new Text(
          widget.title ?? LangUtils.getString(context, widget.titleId),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        actions: <Widget>[
          LikeButton(
            width: 56.0,
            duration: Duration(milliseconds: 500),
          ),
          PopupMenuButton(
              padding: const EdgeInsets.all(0.0),
              onSelected: _onPopSelected,
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                PopupMenuItem<String>(
                    value: "browser",
                    child: ListTile(
                        contentPadding: EdgeInsets.all(0.0),
                        dense: false,
                        title: new Container(
                          alignment: Alignment.center,
                          child: new Row(
                            children: <Widget>[
                              Icon(Icons.language,color: EbColors.gray_66,size: 22.0,),
                              Gaps.hGap10,
                              Text(
                                '浏览器打开',
                                style: listContent,
                              )
                            ],
                          ),
                        ))),
                PopupMenuItem<String>(
                    value: "share",
                    child: ListTile(
                        contentPadding: EdgeInsets.all(0.0),
                        dense: false,
                        title: new Container(
                          alignment: Alignment.center,
                          child: new Row(
                            children: <Widget>[
                              Icon(
                                Icons.share,
                                color: EbColors.gray_66,
                                size: 22.0,
                              ),
                              Gaps.hGap10,
                              Text(
                                '分享',
                                style: listContent,
                              )
                            ],
                          ),
                        ))),

              ])
        ],
      ),
    );
  }

}
