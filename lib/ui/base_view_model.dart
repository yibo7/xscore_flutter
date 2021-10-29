import 'package:flutter/cupertino.dart';
import 'package:oktoast/oktoast.dart';
import 'package:xscore/utils/log_util.dart';
import 'package:xscore/widgets/view_state_widget.dart';
export 'package:xscore/httpclients/ApiResult.dart';
export 'package:xscore/utils/StringUtil.dart';
export 'package:xscore/utils/num_util.dart';
enum ViewState {
  complete,//完成
  loading, //加载中
  empty, //无数据
  error, //加载失败
}
abstract class BaseViewModel with ChangeNotifier{

  void showMsg(String msg) {
    showToast(msg);
  }
  void logDebug(Object lg) {
    LogUtil.debug(lg);
  }
  void init();
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  onChange(){
    notifyListeners();
  }

  //------------------------------------------------------
  /// 当前的页面状态,默认为loading,可在viewModel的构造方法中指定;
  ViewState _viewState=ViewState.loading;

  ViewState get viewState => _viewState;

  set viewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }


  /// get
  bool get isLoading => viewState == ViewState.loading;

  bool get isComplete => viewState == ViewState.complete;

  bool get isEmpty => viewState == ViewState.empty;

  bool get isError => viewState == ViewState.error;

  /// set
  void setComplete() {
    //不等于时才去改变，减少渲染
    if(viewState!=ViewState.complete) viewState = ViewState.complete;
  }

  void setLoading() {
    //不等于时才去改变，减少渲染
    if(viewState!=ViewState.loading) viewState = ViewState.loading;
  }
  void setError() {
    //不等于时才去改变，减少渲染
    if(viewState!=ViewState.error) viewState = ViewState.error;
  }
  void setEmpty() {
    //不等于时才去改变，减少渲染
    if(viewState!=ViewState.empty) viewState = ViewState.empty;
  }
  Widget getLoadingWidget(){
    return ViewStateLoadingWidget();
  }
  Widget getEmptyWidget({String tips="暂无数据"}){
    return ViewStateEmptyWidget(title:tips ,);
  }

  Widget getErrorWidget({String t = "发生错误了",VoidCallback onpressed}){
    return ViewStateErrorWidget(title:t,onPressed: onpressed,);
  }

  void goToUp(BuildContext context){
    Navigator.pop(context);
  }
}
