import 'package:flutter/material.dart';
import 'package:xscore/db/sp_util.dart';
import 'package:xscore/ui/ui_base.dart';
import 'package:xscore/widgets/swiper.dart';
//启动页面与启动引导页面 MainActivityPage()
const String key_guide = 'key_guide'; //本地数据库保存键值，是否已经打开过引导
class StartGuide extends StatefulWidget {
  BuildContext _context;
  final callBack;
  final List<String> _guideList; //引导图的列表
  final String _startImg; //启动页面显示的图
  final bool _isGuideAlways; //是否每次启动都打开引导页
  List<Widget> _bannerList = new List();

  StartGuide(
      this._guideList, this._startImg, this._isGuideAlways, this.callBack,
      {Key key})
      : super(key: key) {
    _initBannerData();
  }

  @override
  _StartGuideState createState() => _StartGuideState();

  void _initBannerData() {
    for (int i = 0, length = _guideList.length; i < length; i++) {
      if (i == length - 1) {
        _bannerList.add(new Stack(
          children: <Widget>[
            new Image.asset(
              _guideList[i],
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            new Align(
              alignment: Alignment.bottomCenter,
              child: new Container(
                margin: EdgeInsets.only(bottom: 110.0),
                child: new InkWell(
                  onTap: () {
                    SpUtil.putBool(key_guide, false);

                    callBack();
                  },
                  child: new CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.indigoAccent,
                    child: new Padding(
                      padding: EdgeInsets.all(2.0),
                      child: new Text(
                        '立即体验',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
      } else {
        _bannerList.add(new Image.asset(
          _guideList[i],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        ));
      }
    }
  }
}

class _StartGuideState extends EbBaseState<StartGuide>    with SingleTickerProviderStateMixin {
   @override
  Widget build(BuildContext context) {
    this.widget._context = context;
    if (isOpenAnimation) {
      return Swiper(
          autoStart: false,
          circular: false,
          indicator: CircleSwiperIndicator(
            radius: 4.0,
            padding: EdgeInsets.only(bottom: 30.0),
            itemColor: Colors.black26,
          ),
          children: this.widget._bannerList);
    } else {
      return Container(
          width: double.infinity,
          padding: EdgeInsets.only(left: setWidth(70),right: setWidth(70)),
          decoration: getBoxLinearGradient(
              [getColor("508BFF"),getColor("68E8FF")]),
          alignment: Alignment.center,
          child: ScaleTransition( //播放动画
            scale: _animationController,
            child: Image.asset(
              this.widget._startImg,
              fit: BoxFit.fill,
            ),
          ));
      // _animationController.forward(from: 0.0);
      // return Container(
      //     width: double.infinity,
      //     padding: EdgeInsets.all(70),
      //     decoration: getBoxLinearGradient(
      //         [splash_start_color,splash_middle_color,splash_end_color]),
      //     alignment: Alignment.center,
      //     child: ScaleTransition( //播放动画
      //       scale: _animationController,
      //       child: Image.asset(
      //         this.widget._startImg,
      //         fit: BoxFit.fill,
      //       ),
      //     ));
    }
  }
   bool get  isOpenAnimation{
    bool isOpend = SpUtil.getBool(key_guide, defValue: true);
    return isOpend || this.widget._isGuideAlways;
  }
  @override
  void initState() {
    _animationController =  AnimationController(duration: const Duration(seconds: 2), vsync: this);
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        this.widget.callBack();
      }
    });
    if(!isOpenAnimation){
      Future.delayed(Duration(milliseconds: 700), () {
        _animationController.forward();
      });
    }

    super.initState();

  }

  AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
