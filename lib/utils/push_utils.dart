
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:jpush_flutter/jpush_flutter.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:xscore/settings/error_hander.dart';

import 'log_util.dart';

class PushUtils {
  // static String _debugLable = 'Unknown';   /*错误信息*/
  static JPush _jpush ;
  static bool isHaveNew = false;
  static void init(bool isdebug,BuildContext context){
    _jpush = new JPush();
    /// 配置jpush(不要省略）
    ///debug就填debug:true，我这是生产环境所以production:true
    _jpush.setup(appKey: 'd866c9ab8648a583db7afd4c' ,channel: 'developer-default',production: true,debug: isdebug);
    /// 监听jpush
    _jpush.applyPushAuthority(new NotificationSettingsIOS(sound: true, alert: true, badge: true));

    try {
      _jpush.addEventHandler(
          onReceiveNotification: (Map<String, dynamic> message) async {
            isHaveNew = true;
            LogUtil.debug("onReceiveNotification:$message");
          },
          onOpenNotification: (Map<String, dynamic> message) async {
            // 点击通知栏消息，在此时通常可以做一些页面跳转等
             LogUtil.debug("点击通知栏消息:$message");
            // RouteMethods.goToPlatformMessage(context);
          },
          onReceiveMessage: (Map<String, dynamic> message) async {

            LogUtil.debug("执行了onReceiveMessage:$message");
          },
          onReceiveNotificationAuthorization:(Map<String, dynamic> message) async {
            LogUtil.debug("触发onReceiveNotificationAuthorization，通知授权是否通过:$message");
          });
    } on PlatformException {
      ErrHander.customErr("获取平台版本失败");
    }

  }
  static void setAlias(int userId){
    _jpush.setAlias("uid$userId").then((map){
      LogUtil.debug("设置了用户别名:$map");
    });
  }
  /*
   * 推送一个消息，fireTime 通知触发时间（毫秒） 默认3秒后发出
   */
  static void pushMsg(int dataId,String title,String content,String subtitle,{int fireTime=3000}){

    var fireDate = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch + fireTime);
    var localNotification = LocalNotification(
      id: dataId, //通知 id, 可用于取消通知
      title: title,//标题
      buildId: 1, //通知样式：1 为基础样式，2 为自定义样式（需先调用 `setStyleCustom` 设置自定义样式）
      content: content,//内容
      fireTime: fireDate,//通知触发时间（毫秒）
      subtitle: subtitle,//子标题
    );
    _jpush.sendLocalNotification(localNotification).then((res) {
      LogUtil.debug("消息发送完成:$res");
    });
    LogUtil.debug("推送了一个测试消息...............");
  }



  /// Checks the notification permission status
  static void checkNotificationPermStatus() {
      NotificationPermissions.getNotificationPermissionStatus().then((status) {
        switch (status) {
          case PermissionStatus.denied: //如果用户转到应用程序设置并关闭该应用程序的通知
            LogUtil.debug("权限未允许,在正请求开通");
            _requestNotiPermissions();
            break;
          case PermissionStatus.granted: //受权状态
            LogUtil.debug("通知受权状态");
            break;
          case PermissionStatus.unknown: //在iOS中，权限是unknown表示用户未接受或拒绝通知权限
            LogUtil.debug("户未接受或拒绝通知权限");
            break;
          case PermissionStatus.provisional:  //iOS Only  暂时允许
            LogUtil.debug("通知权限暂时允许");
            break;
          default:
            break;
        }
    });
  }

  static void _requestNotiPermissions(){
    // show the dialog/open settings screen
    NotificationPermissions
        .requestNotificationPermissions(
        iosSettings:
        const NotificationSettingsIos(sound: true,badge: true,alert: true)).then((_) {
          LogUtil.debug("用户设置通知权限结束");
        });
  }

}