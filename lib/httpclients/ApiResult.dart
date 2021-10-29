

// class GetApiData{
//   static String get(String text){
//     Map<String, dynamic> entity = json.decode(text);
//     if(entity["code"]==0){
//       return entity["data"].toString();
//     }else{
//       showToast(entity["msg"].toString());
//       return null;
//     }
//   }
//
// }

class ApiResult{
  int code;
  String msg;
  dynamic data;

  ApiResult(int code,String msg,dynamic data){
    this.code = code;
    this.msg = msg;
    this.data = data;
  }
}