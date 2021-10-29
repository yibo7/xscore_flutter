import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xscore/const/const_color.dart';

class CustomButtom extends StatelessWidget {
  final String text;
  final Color textColor;

  final Color disabledColor;

  final Color enableColor;

  final double borderRadius;
  final VoidCallback onPressed;

  final num height;
  final  num width;
  final double textSize;
  final  Color borderColor;


  CustomButtom(
      {this.onPressed,
      this.text,
      this.disabledColor = disable_color,
      this.enableColor = custom_button_color,
      this.textColor = Colors.white,
      this.textSize = 15,
      this.borderRadius = 6.0,
      this.width,
      this.height,
      this.borderColor = Colors.transparent
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent, //背景透明防止背景重叠
        width: width,
        height: height == null ? ScreenUtil().setHeight(44):height,
        child: RaisedButton(
          onPressed: onPressed,
          color: enableColor,
          disabledColor: disabledColor,
          child: Text(
            text ,
            style:
                TextStyle(color: textColor, fontSize: textSize),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(color: borderColor)
          ),

        ));
  }
}
