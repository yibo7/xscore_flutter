import 'package:provider/provider.dart';
import 'package:xscore/const/const_color.dart';
import 'package:xscore/ui/ui_base.dart';
import 'package:xscore/widgets/view_state_widget.dart';

import 'base_view_model.dart';

abstract class SubBase<T extends BaseViewModel,M extends StatefulWidget> extends EbBaseState<M>  {
  List<dynamic> get getData;
  T vModel;
  @override
  Widget build(BuildContext context) {
      vModel = Provider.of<T>(context,listen: true);
      onBuilding();
      if(getData.length>0){
        return ListView.separated(
          itemBuilder: (context, index) =>buildItem(context,getData[index]),
          separatorBuilder: (context,index) =>Container(color: line_view_color,height: setHeight(1),),
          itemCount: getData.length,
        );
      }
      else{
        return   ViewStateEmptyWidget();
      }

  }
  void onBuilding(){

  }
  Widget buildItem(context,Map item);

}



