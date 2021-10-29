import 'EntityFactory.dart';

class JsonListEntity<T> {
  int code;
  String message;
  List<T> data;

  JsonListEntity({this.code, this.message, this.data});

  factory JsonListEntity.fromJson(json) {
    List<T> mData = new List<T>();
    if (json['data'] != null) {
      //遍历data并转换为我们传进来的类型
      (json['data'] as List).forEach((v) {
        mData.add(EntityFactory.generateOBJ<T>(v));
      });
    }
    return JsonListEntity(
      code: json["code"],
      message: json["msg"],
      data: mData,
    );
  }
}
