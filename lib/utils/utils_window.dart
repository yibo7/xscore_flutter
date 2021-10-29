import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart' hide Action;

class WindowUtils {
  static double getScreenWidth() {
    return window.physicalSize.width / window.devicePixelRatio;
  }

  static double getScreenHeight() {
    return window.physicalSize.height / window.devicePixelRatio;
  }

  static bool isIPhoneX(BuildContext context) {
    if (Platform.isIOS) {
      var size = MediaQuery.of(context).size;
      if (size.height == 812.0 || size.width == 812.0) {
        return true;
      }
    }
    return false;
  }
  /* 距离 */
// 屏幕宽
  static double ScreenWidth(BuildContext context) => MediaQuery.of(context).size.width;
// 屏幕高
  static double ScreenHeight(BuildContext context) => MediaQuery.of(context).size.height;
/* 上下距离 */
// 上边距在 iPhoneX 上的值是 44， 在其他设备上的值是 20， 是包含了电池条的高度的。
  static double TopPadding(BuildContext context) => MediaQuery.of(context).padding.top;
// 下边距在iPhoneX 上的值是34，在其他设备上的值是 0
  static double BottomPadding(BuildContext context) => MediaQuery.of(context).padding.bottom;
/* 根据6s视频计算尺寸 */
  static double IFFitDouble6sWidth(BuildContext context, double size_width) =>
      MediaQuery.of(context).size.width / 375.0 * size_width;
/* 根据6s视频计算尺寸 */
  static double IFFitDouble6sHeight(BuildContext context, double size_height) =>
      MediaQuery.of(context).size.height / 667.0 * size_height;
  /* 当前运行环境,当App运行在Release环境时，inProduction为true；当App运行在Debug和Profile环境时，inProduction为false */
  static final bool isInProduction = const bool.fromEnvironment("dart.vm.product");
}