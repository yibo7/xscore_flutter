import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart' hide Router;
import 'package:xscore/utils/ebmap.dart';

import 'PageRoutes.dart';
import 'RMethods.dart';

class RoutePageBuilder{
  final  builder; //PageBuilderFunc
  HandlerFunc handlerFunc;
  RoutePageBuilder({this.builder}){
//     this.handlerFunc = (context,_){
//       return this.builder(ModalRoute.of(context).settings.arguments as Bundle);
//     };
    this.handlerFunc = (BuildContext context, Map<String, List<String>> params){

      if(params.containsKey("data")){
        String d = params['data']?.first;
        EbMap mP = EbMap();
         mP.initJson(d);
        return this.builder(mP);
      }
      else{
        return this.builder();
      }
    };
  }

  Handler getHandler(){
    return Handler(handlerFunc: this.handlerFunc);
  }
}

class RoutersApplication{
  RoutersApplication(RoutesMap pr){
    final rt = FluroRouter(); //路由初始化
    RMethods.router = rt;
    //HanderConfig.configureRoutes(router);
    //找不到路由
    rt.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context,Map<String,List<String>> params){
          print('出错了:找不到路由！');
        }
    );
    pr.initPages();
    pr.pageRoutes.forEach((path,handler){
      rt.define(path.toString(), handler: handler.getHandler(),transitionType: TransitionType.inFromRight);
    });
  }
//  static Router router;
}

