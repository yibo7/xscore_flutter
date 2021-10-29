// import 'tables/tokens_entity.dart';
//
// import '../bll_base.dart';
//
// class TableTokens extends BllBase<TokensEntity,int> {
//
//   @override
//   String get tableName => "pv_tokens";
//   Future<List<TokensEntity>> getListByCoinType(String coinType) async {
//     List<TokensEntity> lst = [];
//     List<Map> records = await db.query(tableName,where: "coinType = ?",whereArgs: [coinType]);
//     records.forEach((v) {
//       lst.add(fromMap(v));
//     });
//     return lst;
//   }
//   Future<bool> existByAddress(String address) async {
//     return existByColum("address", address);
//   }
//   @override
//   Future<void> createTable() async {
//     await db.execute('''
//         create table $tableName (
//         id integer primary key autoincrement,
//         address text not null,
//         info text not null,
//         mdwu text not null,
//         coinType text not null,
//         tokenName text not null,
//         addTime text not null)
//       ''');
//   }
//
//   @override
//   TokensEntity fromMap(Map<String, dynamic> mp) {
//     TokensEntity model = TokensEntity();
//     model.id = mp['id'];
//     model.address = mp['address'];
//     model.info = mp['info'];
//     model.mdwu = mp['mdwu'];
//     model.addTime = mp['addTime'];
//     model.coinType = mp['coinType'];
//     model.tokenName = mp['tokenName'];
//     return model;
//   }
//
// }