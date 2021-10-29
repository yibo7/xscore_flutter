import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' ;
import 'package:xscore/utils/ebmap.dart';

//配置新的路由请按以下步骤配置,
//如果要跳转的同时传参数，即要求通过 EbMap 来传，在需要接收的页面通过定义一个EbMap类型的data变量来接收

//第三步，定义跳转的方法
class RMethods{
  static FluroRouter router;
  // static const String index = '/indexp';
  //公共跳转方法
  static goTo(BuildContext context,String pageName,{EbMap data,bool clearStack=false}){
    if(data==null){
      router.navigateTo(context, pageName,clearStack:clearStack );
    }
    else{
      String sData = Uri.encodeComponent(data.toJson);
      router.navigateTo(context, "$pageName?data=$sData");
    }
  }

  static popUtil(BuildContext context,String pageName){
    Navigator.of(context).popUntil(ModalRoute.withName(pageName));
  }

  static pushNamedAndRemoveUntil(BuildContext context,String pageName,String pageName2){
    Navigator.of(context)
        .pushNamedAndRemoveUntil(
        pageName.toString(),
    ModalRoute.withName(pageName2.toString()),//清除旧栈需要保留的栈 不清除就不写这句
    );
  }

  //退出当前页面
  static pop(BuildContext context){
    Navigator.pop(context);
  }

}