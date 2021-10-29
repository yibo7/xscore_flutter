

import 'package:flutter/material.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/const/const_font.dart';

class TitleView extends StatelessWidget {

  final String text;
  const TitleView({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:15),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: TextStyle(
            color: black_33,
            fontSize: font_32
        ),
      ),
    );
  }
}
