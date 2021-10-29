
import 'package:flutter/material.dart';

class  BoxItem extends StatelessWidget {
   BoxItem(this.text,{
    Key key,
    this.height = 35,
    this.margin ,
    this.radius,
    this.bgColor,

    this.style,
  }) : super(key: key){
    if(this.margin==null)
      this.margin = EdgeInsets.all(3);
  }

  final double height;

  /// Empty space to surround the [decoration] and [child].
   EdgeInsetsGeometry margin;

  final double radius;
  final Color bgColor;

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    Color _bgColor = bgColor ?? Theme.of(context).primaryColor;
    BorderRadius _borderRadius = BorderRadius.circular(radius ?? (height / 2));
    return new Container(
      padding: EdgeInsets.all(8),
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: _bgColor,
          borderRadius: _borderRadius,
//          border: Border.all(),

    ),
      child: Text(
        text,
        textAlign:TextAlign.center,
        style:
        style ?? new TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}

