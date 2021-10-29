import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/utils/ebutils.dart';

class UserListView extends StatelessWidget {
  IconData   image;
  String name;
  VoidCallback onPressed;

  UserListView(this.image, this.name, {this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(
            top: ScreenUtil().setHeight(15),
            bottom: ScreenUtil().setHeight(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(image,color: Colors.black38,size: 20.0,),
                // Image.asset(
                //   EbUtils.getImgPath(image),
                //   width: 20,
                //   height: 20,
                // ),
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(12)),
                  child: Text(name,
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(15),
                          color: asset_around_color)),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: ScreenUtil().setWidth(12)),
              child: Image.asset(
                EbUtils.getImgPath('dayu'),
                fit: BoxFit.cover,
                width: ScreenUtil().setWidth(7),
                height: ScreenUtil().setHeight(12),
              ),
            )
          ],
        ),
      ),
      onTap: () => {onPressed()},
    );
  }
}
