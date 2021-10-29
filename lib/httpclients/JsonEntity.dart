
import 'EntityFactory.dart';

class JsonEntity<T> {
  int code;
  String message;
  T data;

  //dio 调用 json返回的是一个map类型，所以可以通过键值对方式获取
  JsonEntity.fromJson(json) {
//    code = int.parse(json["code"]);
    code = json["code"];
    message= json["msg"];
    // data值需要经过工厂转换为我们传进来的类型
    data= EntityFactory.generateOBJ<T>(json["data"]);
  }
}
