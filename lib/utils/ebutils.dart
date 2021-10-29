import 'dart:math';

import 'package:flutter/material.dart';

class EbUtils {
  static String getImgPath(String name, {String format: 'png'}) {
    return 'res/images/$name.$format';
  }
  static void showSnackBar(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(
      SnackBar(content: Text("$msg")),
    );
  }
  // static bool isLogin() {
  //   return ObjectUtil.isNotEmpty(SpUtil.getString(UserConstant.keyAppToken));
  // }
  //获取一个小于max的随机整数
  static int getRandomNum(int max) {
    var rng = new Random();
    return rng.nextInt(max);
  }
  static String getRandomStr(List<String> strs) {
    if(strs.length>0){
      int rng = getRandomNum(strs.length);
      return strs[rng];
    }
     return "";
  }


}