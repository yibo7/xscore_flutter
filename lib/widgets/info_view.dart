

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/utils/ebutils.dart';

// ignore: must_be_immutable
class InfoView extends StatefulWidget {
  String leftText;
  String rightText="";
  VoidCallback onPressed;
  bool isOff;

  InfoView(this.leftText,{this.rightText,this.onPressed,this.isOff=false});
  @override
  InfoViewState createState() => InfoViewState();

}

class InfoViewState extends State<InfoView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(top:
            ScreenUtil().setHeight(15),bottom: ScreenUtil().setHeight(15) ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                this.widget.leftText,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(15), color: asset_around_color),
              ),
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: ScreenUtil().setWidth(13)),
                  child: Text(
                     this.widget.rightText,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(13),
                        color: home_text_grey_color),
                  ),
                ),
                Offstage(
                  offstage: this.widget.isOff,
                  child:Container(
                      child: Image.asset(
                        EbUtils.getImgPath('dayu'),
                        fit: BoxFit.cover,
                        width: ScreenUtil().setWidth(7),
                        height: ScreenUtil().setHeight(12),
                      )
                  )
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () =>
      {
        this.widget.onPressed()
      },
    );
  }
}