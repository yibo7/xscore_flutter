
import 'package:xscore/widgets/qrscanview.dart';

import 'RouteApplication.dart';


abstract class RoutesMap {
  Map<String,RoutePageBuilder> pageRoutes = {};
  initPages(){
    addPage("QrScanView",()=> QrScanView());
  }
  addPage(String key,pg){
    if(!pageRoutes.containsKey(key)){
      pageRoutes[key] = RoutePageBuilder(builder: pg);
    }else{
      throw new Exception('已经包含页面:'+key);
    }

  }
}


