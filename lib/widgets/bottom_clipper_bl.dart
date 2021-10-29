
import 'dart:ui';

import 'package:flutter/cupertino.dart';
//贝塞尔曲线切割
//曲线路径
class BottomClipperBl extends CustomClipper<Path>{
  @override
  Path getClip(Size size){
    var path = Path(); //定义路径

    //波浪曲线路径
    path.lineTo(0, 0); //第1个点
    path.lineTo(0, size.height - 40.0); //第2个点
    var firstControlPoint = Offset(size.width/4, size.height); //第一段曲线控制点
    var firstEndPoint = Offset(size.width/2.25, size.height-30); //第一段曲线结束点
    path.quadraticBezierTo( //形成曲线
        firstControlPoint.dx,
        firstControlPoint.dy,
        firstEndPoint.dx,
        firstEndPoint.dy);

    var secondControlPoint = Offset(size.width/4*3, size.height-90); //第二段曲线控制点
    var secondEndPoint = Offset(size.width, size.height-40); //第二段曲线结束点
    path.quadraticBezierTo( //形成曲线
        secondControlPoint.dx,
        secondControlPoint.dy,
        secondEndPoint.dx,
        secondEndPoint.dy);

    path.lineTo(size.width, size.height-40);
    path.lineTo(size.width, 0);


    return path;
  }
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}