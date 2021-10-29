// import 'tables/address_entity.dart';
//
// import '../bll_base.dart';
//
// class TableAddress extends BllBase<AddressEntity,int> {
//
//   @override
//   String get tableName => "pv_address";
//   Future<bool> existByAddress(String address) async {
//      return existByColum("address", address);
//   }
//   Future<List<AddressEntity>> getListByCoinType(String coinType) async {
//     List<AddressEntity> lst = [];
//     List<Map> records = await db.query(tableName,where: "coinType = ?",whereArgs: [coinType]);
//     records.forEach((v) {
//       lst.add(fromMap(v));
//     });
//     return lst;
//   }
//   Future<AddressEntity> getEntityById(int id) async {
//     List<Map> maps = await db.query(tableName,
//         columns: ["id", "address", "info","mdwu","addTime","coinType"],
//         where: 'id = ?',
//         whereArgs: [id]);
//     if (maps.length > 0) {
//       return fromMap(maps.first);
//     }
//     return null;
//   }
//
//   @override
//   Future<void> createTable() async {
//     await db.execute('''
//         create table pv_address (
//         id integer primary key autoincrement,
//         address text not null,
//         info text not null,
//         mdwu text not null,
//         coinType text not null,
//         addTime text not null)
//       ''');
//   }
//
//   @override
//   AddressEntity fromMap(Map<String, dynamic> mp) {
//     AddressEntity model = AddressEntity();
//     model.id = mp['id'];
//     model.address = mp['address'];
//     model.info = mp['info'];
//     model.mdwu = mp['mdwu'];
//     model.addTime = mp['addTime'];
//     model.coinType = mp['coinType'];
//     return model;
//   }
//
//
// }