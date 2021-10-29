import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/ui/ui_base.dart';

/// 加载中
class ViewStateLoadingWidget extends StatelessWidget {

  double width;
  double height;

  ViewStateLoadingWidget({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return
      Container(
      width: width,
        height: height,
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      )
    ;
  }
}

/// ErrorWidget
class ViewStateErrorWidget extends EbBaseStatelessWidget {
  VoidCallback onPressed;
  String _title;
  ViewStateErrorWidget({this.onPressed,String title = "发生错误了"}){
    _title = title;
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      child: GestureDetector(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        Image.asset(getImgPath("no_network"),
        width: setWidth(160),
        height: setHeight(148),),
      Container(
        padding: EdgeInsets.only(left: setWidth(23),right: setWidth(23),top: setHeight(8),bottom: setHeight(8)),
          decoration: BoxDecoration(
              border: Border.all(width: setWidth(1), color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(setWidth(17)))
      ),
      child: Text(
        _title,
        style: TextStyle(color: Colors.blue, fontSize: setSp(15)),
      ),
    )],
    ),
    onTap:onPressed ,
    ),
    );
  }

}

/// 页面无数据
class ViewStateEmptyWidget extends EbBaseStatelessWidget {
  String _title;
  ViewStateEmptyWidget({String title = "暂无数据"}){
    _title = title;
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      alignment: Alignment.center,
      child: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(getImgPath("no_data"),
              width: setWidth(160),
              height: setHeight(148),),
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                _title,
                style: TextStyle(color: black_99, fontSize: setSp(15)),
              ),
            )],
        ),
      ),
    );
  }
}

