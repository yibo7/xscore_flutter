import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/**
 * 底部弹框
 */
class BottomSheetDialog {
  static Future<dynamic> showBottomSheet(BuildContext context, Widget widget) {
    return showModalBottomSheet(
        isScrollControlled: true, // !important 可以使软键盘不遮挡输入框
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView( // !important
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Stack(
                children: [
                  // 防止弹框圆角被覆盖
                  Container(
                    width: double.infinity,
                    height: 25,
                    color: Colors.black54,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(16),right: ScreenUtil().setWidth(16),top: ScreenUtil().setHeight(26),bottom: ScreenUtil().setHeight(26)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            topLeft: Radius.circular(12))),
                    child: widget,
                  )
                ],
              ),
            )
          );
        }
    );
  }
}