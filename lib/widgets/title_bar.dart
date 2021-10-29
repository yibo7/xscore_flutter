import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/ui/bottom_sheet_dialog.dart';

import 'back_button_arrows.dart';

class TitleBar extends StatelessWidget {
  final title_color = Color.fromRGBO(255, 255, 255, 1.0);
  String title;
  // 是否展示右侧图标
  bool rightIcon;
  // 点击右侧图标dialog的视图
  Widget dialogView;
  Color backgroundColor;
  TitleBar({this.title,this.rightIcon = false,this.dialogView,this.backgroundColor,this.rightUserIcon=Icons.help});
  IconData rightUserIcon;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return AppBar(
      elevation: 0.0,
      //设置无阴影
      backgroundColor: backgroundColor,
      leading: Visibility(
        child: BackButtonArrows(
          color: title_color,
        ),
        visible: true,
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: title_color, fontSize: 17,),
      ),
      actions: [
        Visibility(
          child: IconButton(
            color: colorWhite,
            icon: Icon(rightUserIcon),
            onPressed: () {
              if(this.rightIcon) {
                BottomSheetDialog.showBottomSheet(context, dialogView);
              }
            },
          ),
          visible: rightIcon,
        ),
      ],
    );
  }
}



