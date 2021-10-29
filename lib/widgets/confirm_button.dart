import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/const/const_spacing.dart';
import 'package:xscore/utils/utils_window.dart';

// ignore: must_be_immutable
class ConfirmButton extends StatelessWidget{

  VoidCallback callBackFun;
  String buttonText;

  ConfirmButton(this.buttonText,{@required this.callBackFun});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WindowUtils.getScreenWidth(),
      height: button_height,
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(80.0)),
      child: RaisedButton(
        color: button_color,
        disabledColor: black_33,
        onPressed: callBackFun,
        textColor: colorWhite,
        padding: const EdgeInsets.all(0.0),
        shape: const RoundedRectangleBorder(
            side: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(3))),
        child: Text(
          buttonText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(16.0),
              color: colorWhite,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}