import 'dart:convert';

class EbMap{
  EbMap({Map<String,dynamic> m}){
    if(m!=null)
      _map = m;
  }
  String get toJson{
    String sJson = json.encode(_map);
    return sJson;
  }

  EbMap.fromJson(String source){
    Map<String,dynamic> mP = json.decode(source);
    EbMap(m: mP);
  }
  initJson(String source){
    Map<String,dynamic> mP = json.decode(source);
    _map = mP;
  }
  Map<String,dynamic> _map = {};
  _setValue(var k,var v) => _map[k] = v;
  _getValue(String k){
    if(!_map.containsKey(k)){
      throw Exception("你使用的KEY:$k 在payload不存在，请检查你的key名字是否正确，或确定key是否在payload");
    }
    return _map[k];
  }
  putObj<T>(String k,T v)=>_setValue(k, v);
  putInt(String k,int v)=>_map[k]=v;
  putString(String k,String v)=>_setValue(k, v);

  putBool(String k,bool v)=>_setValue(k, v);
  putList<V>(String k,List<V> v)=>_setValue(k, v);
  putMap<K,V>(String k,Map<K,V> v)=>_setValue(k, v);

  int getInt(String k)=>_getValue(k) as int;
  String getString(String k)=>_getValue(k) as String;
  bool getBool(String k)=>_getValue(k) as bool;
  List getList(String k)=>_getValue(k) as List;
  Map getMap(String k)=>_getValue(k) as Map;
  T getObj<T>(String k)=>_getValue(k) as T;
  @override
  String toString(){
    return _map.toString();
  }

  clear(){
    _map.clear();
  }

}