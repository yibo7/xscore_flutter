import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xscore/const/const_spacing.dart';

class LineView extends StatelessWidget {

  final double left;
  final double right;
  final Color color;
  final num height;
  const LineView({this.left, this.right, this.color,this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      margin: EdgeInsets.only(
        left: left == null ? 0 : ScreenUtil().setWidth(left),
        right: right == null ? 0 : ScreenUtil().setWidth(right),
      ),
      height: height == null?line_height:height,
    );
  }
}
