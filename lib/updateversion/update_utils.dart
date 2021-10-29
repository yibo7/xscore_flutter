import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_file/open_file.dart';
import 'package:ota_update/ota_update.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:xscore/utils/StringUtil.dart';
import 'package:xscore/utils/navigator_util.dart';
import 'package:xscore/utils/num_util.dart';

import 'app_update_model.dart';
class UpdateUtils{
  static void checkVersion(AppUpdateModel appUpdateModel,BuildContext context) async {
    if(appUpdateModel!=null){
      //先获取本地版本号
      final PackageInfo info = await PackageInfo.fromPlatform();
      int versionCode = int.parse(info.buildNumber);
      //获取服务器版本号
      int serverVersion = appUpdateModel.version;
      if(serverVersion>versionCode){
        showUpdateAlertDialog(context,appUpdateModel);
      }

    }
  }
  /// App更新提示框
  static showUpdateAlertDialog(context, AppUpdateModel appUpdateInfo) async {
    var type = appUpdateInfo.type;
    var forceUpdate = type==0?false:true;
    return await showDialog(
        context: context,
        builder: (context) => WillPopScope(
          onWillPop: () async {
            return !forceUpdate;
          },
          child: AlertDialog(
            title: Text("有新版本啦!"),
            content: StringUtil.isEmpty(appUpdateInfo.content)
                ? Text(appUpdateInfo.content)
                : null,
            actions: <Widget>[
              if (!forceUpdate)
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("取消"),
                ),
              FlatButton(
                onPressed: () async {
                  if(Platform.isAndroid) {
                    downloadApp(context,appUpdateInfo);
                  }else{
                    NavigatorUtil.launchUrl(appUpdateInfo.url);
                  }
                  Navigator.of(context).pop();
                },
                child: Text(
                  "更新",
                  style: TextStyle(color: Theme.of(context).accentColor),
                ),
              ),
            ],
          ),
        ));
  }

  static Future downloadApp(BuildContext context, AppUpdateModel appUpdateInfo) async {
    var url = appUpdateInfo.url;
    var extDir = await getExternalStorageDirectory();
    String apkPath =  '${extDir.path}/cqsappupdatetem.apk';
    File file = File(apkPath);
    if (!file.existsSync()) {
      // 没有下载过
      if (await showDownloadDialog(context, url, apkPath) ?? false) {
        OpenFile.open(apkPath);
      }
    } else {
      var reDownload = await showReDownloadAlertDialog(context);
      //因为点击android的返回键,关闭dialog时的返回值为null
      if (reDownload != null) {
        if (reDownload) {
          bool ex =await  file.exists();
          if(ex) await file.delete();

          //重新下载
          if (await showDownloadDialog(context, url, apkPath) ?? false) {
            OpenFile.open(apkPath);
          }
        } else {
          //直接安装
          OpenFile.open(apkPath);
        }
      }
    }
  }

  static showDownloadDialog(context, url, path) async {
    DateTime lastBackPressed;
    bool downloading = false;
    return await showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async {
              if (lastBackPressed == null ||
                  DateTime.now().difference(lastBackPressed) >
                      Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                lastBackPressed = DateTime.now();
                showToast("再次点击返回键,取消下载",
                    position: ToastPosition.bottom);
                return false;
              }
              showToast("下载已取消",
                  position: ToastPosition.bottom);
              return true;
            },
            child: AlertDialog(
              title: Text("下载中,请稍后..."),
              content: Builder(
                builder: (context) {
                  ValueNotifier notifier = ValueNotifier(0.0);
                  if (!downloading) {
                    downloading = true;

                    if (Platform.isAndroid) {
                      try {
                        OtaUpdate().execute(url).listen(
                              (OtaEvent event) {
                            switch (event.status) {
                              case OtaStatus.DOWNLOADING: // 下载中
                                notifier.value = NumUtil.getDoubleByValueStr(event.value)/100;

                                break;
                              case OtaStatus.INSTALLING: //安装中
                                Navigator.pop(context, true);
                                /* // 打开安装文件
                              OpenFile.open("${"appDocPath"}/new.apk");*/
                                break;
                              case OtaStatus.PERMISSION_NOT_GRANTED_ERROR: // 权限错误
                                showToast('更新失败，请稍后再试');

                                break;
                              default: // 其他问题
                                break;
                            }
                          },
                        );
                      } catch (e) {
                        showToast('更新失败，请稍后再试');
                      }
                    }


                  }
                  return ValueListenableBuilder(
                    valueListenable: notifier,
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LinearProgressIndicator(
                          value: value,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  static showReDownloadAlertDialog(context) async {
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("检测到本地已下载过该版本,是否直接安装?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "取消",
              ),
            ),
            SizedBox(
              width: 20,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                "重新下载",
              ),
            ),
            FlatButton(
              onPressed: () async {
                Navigator.of(context).pop(false);
              },
              child: Text("直接安装"),
            ),
          ],
        ));
  }
}