
import 'package:xscore/httpclients/DioHttpClient.dart';
import 'package:xscore/settings/global.dart';
import 'package:xscore/utils/xs_encrypt.dart';
export 'package:xscore/httpclients/ApiResult.dart';
abstract class ApisBase {
  //提供payvar网站的api调用
  DioHttpClient httpPv;

  ApisBase() {
    httpPv = getHttp();
  }
  DioHttpClient getHttp();
  //得到Sign
  //适用于登录后存在Token的场景
  //把data 和 token 签名
  String sign(Map<String, dynamic> params) {

    // 将待签名字符串要求按照参数名进行排序(首先比较所有参数名的第一个字母，按abcd顺序排列，
    // 若遇到相同首字母，则看第二个字母，以此类推.
    List<String> keys = params.keys.toList();
    // key排序
    keys.sort((a, b) {
      List<int> al = a.codeUnits;
      List<int> bl = b.codeUnits;
      for (int i = 0; i < al.length; i++) {
        if (bl.length <= i) return 1;
        if (al[i] > bl[i]) {
          return 1;
        } else if (al[i] < bl[i]) return -1;
      }
      return 0;
    });
    String sign = "";
    for (var key in keys) {
      sign += key + "=" + (params[key]).toString() + '&';
    }
    String data = sign+'secret_key='+Global.token;
    String signv = XsEncrypt.encodeMd5(data);
    params.addAll({"sign":signv});
    return  signv;
  }


  String formatNum(double num,int postion){
    if((num.toString().length-num.toString().lastIndexOf(".")-1)<postion){
      //小数点后有几位小数
      String key= num.toStringAsFixed(postion).substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
      return key;
    }else{
      String key= num.toString().substring(0,num.toString().lastIndexOf(".")+postion+1).toString();
      return key;
    }
  }

}
