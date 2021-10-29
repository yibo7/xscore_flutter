import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xscore/ui/ui_base.dart';

class CustomTips extends EbBaseStatelessWidget {
  VoidCallback onPressed;
  String _title;
  Color _color;
  CustomTips({this.onPressed,String title = "操作提示",Color color = Colors.orange}){
    _title = title;
    _color = color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_protected_setup_outlined,size: 50,color: _color,),
            Container(
              padding: EdgeInsets.only(left: setWidth(23),right: setWidth(23),top: setHeight(8),bottom: setHeight(8)),
              child: Text(
                _title,
                style: TextStyle(color: _color, fontSize: setSp(15)),
              ),
            )],
        ),
        onTap:onPressed ,
      ),
    );
  }

}