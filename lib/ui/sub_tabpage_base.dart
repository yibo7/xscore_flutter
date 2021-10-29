export 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xscore/ui/ui_base.dart';
export 'package:xscore/utils/StringUtil.dart';
export 'package:xscore/utils/num_util.dart';
export 'package:xscore/widgets/CustomButton.dart';
export 'package:xscore/widgets/form/eb_login_textfield.dart';
export 'package:xscore/widgets/form/eb_textfield.dart';
import 'base_view_model.dart';

abstract class SubTabPageBase<T extends BaseViewModel> extends EbBaseStatelessWidget  {

  @override
  Widget build(BuildContext context) {
    T vModel = Provider.of<T>(context,listen: true);
    return buildPage(context,vModel);
  }
  Widget buildPage(BuildContext context,T model);

}