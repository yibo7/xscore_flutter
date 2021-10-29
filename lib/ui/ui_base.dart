import 'dart:async';
export 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ndialog/ndialog.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/db/sp_util.dart';
import 'package:xscore/langconfig/lang_utils.dart';
import 'package:xscore/settings/eb_colors.dart';
import 'package:xscore/settings/gaps.dart';
import 'package:xscore/settings/global.dart';
import 'package:xscore/utils/StringUtil.dart';
import 'package:xscore/utils/ebutils.dart';
import 'package:xscore/utils/log_util.dart';
import 'package:xscore/widgets/line_view.dart';
export 'package:xscore/utils/ebmap.dart';
export 'package:xscore/ui/base_provider_widget.dart';
export 'package:xscore/utils/StringUtil.dart';
export 'package:xscore/widgets/view_state_widget.dart';
export 'package:xscore/widgets/line_view.dart';
import 'bottom_sheet_dialog.dart';
export 'package:xscore/utils/ebutils.dart';
export 'package:xscore/utils/num_util.dart';
export 'package:xscore/widgets/CustomButton.dart';
export 'package:xscore/widgets/form/eb_login_textfield.dart';
export 'package:xscore/ui/bottom_sheet_dialog.dart';
export 'package:xscore/widgets/form/eb_textfield.dart';
export 'package:xscore/widgets/title_bar.dart';
enum BoxLine{
  top,bottom,left,right,all
}
//只支持上或下，或全部圆角
enum CircularType{
  top,bottom,all
}



class BaseUtils{

  //获取语言包中的语言
  String getLang(BuildContext context, String id){
    return LangUtils.getString(context,id);
  }

  //region SP的本地存储
  getSpString(String key){
    return SpUtil.getString(key,defValue: "");
  }
  getSpBool(String key){
    return SpUtil.getBool(key,defValue: false);
  }
  getSpDouble(String key){
    return SpUtil.getDouble(key,defValue: 0);
  }
  getSpDynamic(String key){
    return SpUtil.getDynamic(key,defValue: 0);
  }
  getSpInt(String key){
    return SpUtil.getInt(key,defValue: 0);
  }

  setSpString(String key,String v){
    return SpUtil.putString(key,v);
  }
  setSpBool(String key,bool v){
    return SpUtil.putBool(key,v);
  }
  setSpDouble(String key,double v){
    return SpUtil.putDouble(key,v);
  }

  setSpInt(String key,int v){
    return SpUtil.putInt(key,v);
  }
  //endregion

  String getImgPath(String name) {
    return EbUtils.getImgPath(name);
  }
  //操作提示
  void showMsg(String msg) {
    // EbUtils.showSnackBar(context,msg);
    showToast(msg);
  }
  //检测是否用户已经登录
  void logDebug(Object lg) {
    LogUtil.debug(lg);
  }

  void showBottomDialog(BuildContext context,Widget widget){
    BottomSheetDialog.showBottomSheet(context, widget);
  }

  Future<void> confirmBox(context,title,tips,fun) async {
     await NDialog(dialogStyle: DialogStyle(titleDivider: true),
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(tips),
      ),
      actions: <Widget>[
        FlatButton(child: Text("取消"),onPressed: () {
          Navigator.pop(context);
        }),
        FlatButton(child: Text("确认"),onPressed: () {
          fun();
          Navigator.pop(context);
        })
      ],
    ).show(context);


  }

  //region 导航


  //返回上一页
  void goToUp(BuildContext context){
    Navigator.pop(context);
  }

  //endregion

  //region 样式

  //获取随机颜色
  static const List<String> _colors=["3FD849","FF9853","A4D846","4066C7","005748","94A000","00893F","00C5D3","FFAA09","00380D","820022"];
  Color getRandColor({List<String> colors=_colors}){
    String color = EbUtils.getRandomStr(colors);
    return getColor(color);
  }
  getCacheNetImage(String url,{double width,double height,BoxFit boxFit = BoxFit.none}){
    if(StringUtil.isEmpty(url)){
      url = "";
    }
    return CachedNetworkImage(
      imageUrl: url,width: width,height: height,fit: boxFit,
      placeholder: (context, url) => CircularProgressIndicator(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
    //fit: BoxFit.cover
  }
  // getCircleAvatar(String url){
  //   logDebug("地址是"+url);
  //     return CircleAvatar(
  //       backgroundImage: getNetworkImage(url),
  //     );
  // }
  // getNetworkImage(String url){
  //   return NetworkImage(url);
  // }
  //获取线性渐变背景的装饰器
  BoxDecoration getBoxLinearGradient(List<Color> colors,{AlignmentGeometry start = Alignment.topLeft,AlignmentGeometry end = Alignment.bottomRight }){
    return BoxDecoration(
        gradient: LinearGradient(
          begin: start,
          end: end,
          colors: colors,
        ));
  }
  //获取边框装饰器
  BoxDecoration getBoxLine({
    Color bgColor,
    Color borderColor=Colors.black12,
    BoxLine boxLine = BoxLine.all,
    double width=0.3,
    double circular=5,
    circularType=CircularType.all,Border customBorder
  }){
    Color clLine =  borderColor;//getColor(borderColor);

    Border border ;
    if(customBorder!=null){
      border = customBorder;
    }else{
      if(boxLine==BoxLine.bottom)
        border = Border(bottom: BorderSide(width: width, color: clLine));
      else if(boxLine==BoxLine.left)
        border = Border(left: BorderSide(width: width, color: clLine));
      else if(boxLine==BoxLine.top)
        border = Border(top: BorderSide(width: width, color: clLine));
      else if(boxLine==BoxLine.right)
        border = Border(right: BorderSide(width: width, color: clLine));
      else
        border = Border.all(width: width,color: clLine);
    }


    BorderRadius borderRadius;
    if(circular>0){
      if(circularType==CircularType.bottom)
        borderRadius = BorderRadius.vertical(bottom:Radius.circular(circular));
      else if(circularType==CircularType.top)
        borderRadius = BorderRadius.vertical(top:Radius.circular(circular));
      else if(circularType==CircularType.all)
        borderRadius = BorderRadius.all(Radius.circular(circular));
    }

    return BoxDecoration(
      color: bgColor==null?null:bgColor,
      border: border,
      borderRadius: borderRadius,
    );
  }

  //获取一个高度占位
  getHeight(double height){
    return  Gaps.getVGap(height);
  }
  //获取一个宽度占位
  getWidth(double width){
    return  Gaps.getHGap(width);
  }
  Color getColor(String color){
    return EbColors.getColor(color);
  }

  getLineView({Color color:line_view_color}){
   return LineView(color:color);
  }
  getFontStyle({double size=12,Color color = Colors.black38,bool isBold=false,String fontFamily}){

    return TextStyle(
        fontSize: size,
        color: color,
        fontWeight: isBold?FontWeight.bold:FontWeight.normal,
        fontFamily:fontFamily
    );

  }
//endregion

  //region 事件

  //给指定的元素添加点击事件
  onTap(child,fun){
    return GestureDetector(
      onTap: fun,
      child: child,
    );
  }
  //给指定的元素添加双击事件
  onDoubleTap(child,fun){
    return GestureDetector(
      onDoubleTap: fun,
      child: child,
    );
  }
  //给指定的元素添加长按事件
  onLongPress(child,fun){
    return GestureDetector(
      onLongPress: fun,
      child: child,
    );
  }
//endregion

  //region 设备
  //屏幕大小-宽度
  // double getScreenWidth(BuildContext context){
  //   return MediaQuery.of(context).size.width;
  // }
  // //屏幕大小-宽度
  // double getScreenHeight(BuildContext context){
  //   return MediaQuery.of(context).size.height;
  // }
  double getScreenWidth(){

    return ScreenUtil().screenWidth;
  }
  double getScreenHeight(){
    return ScreenUtil().screenHeight;
  }
  //上边刘海高度
  double get getStatusBarHeight{
    return ScreenUtil().statusBarHeight;
    //return MediaQuery.of(context).padding.top;
  }

  //下边内置导航高度
  double get getBottomBarHeight{
    return ScreenUtil().bottomBarHeight;
    // return MediaQuery.of(context).padding.top;
  }
  num  setSp(num h){
    return ScreenUtil().setSp(h);
  }
  num  setHeight(num h){
    return ScreenUtil().setHeight(h);
  }
  num  setWidth(num w){
    return ScreenUtil().setWidth(w);
  }
  // //获取字体大小
  // num  setSp(num fontSize){
  //   return ScreenUtil().setSp(fontSize);
  // }
//endregion

  getProvider<T>(context,isListen){
    return Provider.of<T>(context,listen: isListen);
  }
}

abstract class EbBaseStatelessWidget extends StatelessWidget with BaseUtils{
  EbBaseStatelessWidget({Key key}) : super(key: key);

}

abstract class EbBaseStatefulWidget extends StatefulWidget with BaseUtils{
  EbBaseStatefulWidget({Key key}) : super(key: key);

}

abstract class LifeState<T extends StatefulWidget> extends State<T> with BaseUtils,WidgetsBindingObserver, RouteAware{
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    Global.sLifeObserver.subscribe(this, ModalRoute.of(context));
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    Global.sLifeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    } else if (state == AppLifecycleState.paused) {
      onPaused();
    }
  }

  /**
   * onResume  onPaused
   * 不能做大量耗时操作
   */
  void onResume();//屏幕切到前台

  void onPaused();//页面不可见或切换到后台
}

abstract class EbBaseState<T extends StatefulWidget> extends State<T> with BaseUtils {

}

abstract class EbMvc<T extends StatefulWidget,M extends EbMvcModel> extends EbBaseState<T>{
  EbMvcModel get initModel;
  M  mvModel;
  EbMvcModel _modelBase;
  EbMvc(){

    mvModel = initModel;
    _modelBase = mvModel;
    _modelBase.initStateFun((){
      setState(() {
        return mvModel;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _modelBase.initData();
    });
    loadData();

    _modelBase.runTimerFun(setState);
  }
  bool isLoaded =false;
  Future loadData() async {
    //await new Future.delayed(const Duration(seconds: 3));//模拟网络请求延迟
    setState(() {
      _modelBase.loadData();
      isLoaded = true;
    });
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print('deactivate');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose');
    _modelBase.cancelTimers();
  }

}


abstract class EbMvcModel{

  void cancelTimers(){
    if(lstTimer.length>0){
      lstTimer.forEach((value) {
        value.cancel();
      });
    }
  }
  List<Timer> lstTimer = [];
  void runTimerFun(upState){
    if(lstTimerFuns.length>0){
      lstTimerFuns.forEach((value) {
        var t = Timer.periodic(Duration(milliseconds: value.timerSpan),(Void){
          upState(() {
            value.fun();
          });
        });
        lstTimer.add(t);

      });

    }
  }
  List<FunTimerRun> lstTimerFuns =[];
  void addTimerFun(int timerSpan,fun){
    lstTimerFuns.add(FunTimerRun(timerSpan,fun));
  }
  void initData();
  void loadData();
  var _flush;
  void initStateFun(fun){
    _flush = fun;
  }
  void flushUI(){
    _flush();
  }
}
class FunTimerRun{
  int timerSpan = 0;
  var fun;
  FunTimerRun(this.timerSpan,this.fun);
}