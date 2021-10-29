import 'dart:io';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:xscore/db/sp_util.dart';
import 'package:xscore/eventbus/bus_event.dart';
import 'package:xscore/routers/PageRoutes.dart';
import 'package:xscore/routers/RouteApplication.dart';
import 'package:xscore/utils/log_util.dart';

class Global {

  static String  token = ""; //登录后给它赋值
  static int userId = 0; //登录后的用户id
  static RouteObserver<Route> sLifeObserver;
  static const bool kReleaseMode = bool.fromEnvironment('dart.vm.product', defaultValue: false);
  static bool isDebug = !const bool.fromEnvironment("dart.vm.product");
  //初始化全局信息
  static Future init(VoidCallback callback,RoutesMap rm) async {
    LogUtil.init(isDebug: isDebug,tag: "PAYVAR日志");
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await SpUtil.init();
    callback();
    RouteObserver<Route> lifeObserver = RouteObserver();
    sLifeObserver=lifeObserver;
    RoutersApplication(rm);
    //注入跨页通知事件
    final eventBus = new EventBus();
    ApplicationEvent.event = eventBus;
    if (Platform.isAndroid) {
      // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
      SystemUiOverlayStyle systemUiOverlayStyle =
          SystemUiOverlayStyle(statusBarColor: Colors.transparent);
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }

}
