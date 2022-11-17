import 'package:rent_collection_app/database/database_helper.dart';
import 'package:rent_collection_app/database/util.dart';
import 'package:rent_collection_app/models/shop_model.dart';

class ShopDetailRepo {
  // final int commonId;

  // ShopDetailRepo({required this.commonId});
  DatabaseHelper dbhelper = DatabaseHelper();

//To show all

  // Future<List<ShopModel>> getshopDetails() async {
  //   var dbClient = await dbhelper.db;
  //   List<Map> maps = await dbClient.query(tableName1,
  //       columns: ['id', 'collectedamount', 'collectiondate', 'shopid']);
  //   List<ShopModel> shopModel = [];

  //   for (int i = 0; i < maps.length; i++) {
  //     shopModel.add(ShopModel.fromMap(maps[i]));
  //   }
  //   return shopModel;
  // }

  Future<List<ShopModel>> getshopDetailsById(int id) async {
    var dbClient = await dbhelper.db;
    List<Map> maps = await dbClient.query(tableName1,
        columns: ['id', 'collectedamount', 'collectiondate', 'shopid'],
        where: 'shopid=?',
        whereArgs: [id]);
    List<ShopModel> shopModel = [];

    for (int i = 0; i < maps.length; i++) {
      shopModel.add(ShopModel.fromMap(maps[i]));
    }
    print('Query:  ${id} length ${shopModel.length}');
    return shopModel;
  }

  Future<List<ShopModel>> getshopDetails() async {
    var dbClient = await dbhelper.db;
    List<Map> maps = await dbClient.query(tableName1,
        columns: ['id', 'collectedamount', 'collectiondate', 'shopid']);
    List<ShopModel> shopModel = [];

    for (int i = 0; i < maps.length; i++) {
      shopModel.add(ShopModel.fromMap(maps[i]));
    }

    return shopModel;
  }

  //insert
  Future<int> add(ShopModel shopModel) async {
    var dbClient = await dbhelper.db;
    return await dbClient.insert(tableName1, shopModel.toMap());
  }

//update
  Future<int> update(ShopModel shopModel) async {
    var dbClient = await dbhelper.db;
    return await dbClient.update(tableName1, shopModel.toMap(),
        where: 'id = ?', whereArgs: [shopModel.id]);
  }

//delete
  Future<int> delete(int id) async {
    var dbClient = await dbhelper.db;
    return await dbClient.delete(tableName1, where: 'id = ?', whereArgs: [id]);
  }

//SUM AMOUNT
  Future getTotal() async {
    var dbClient = await dbhelper.db;
    var result =
        await dbClient.rawQuery("SELECT SUM(collectedamount) FROM  tableName1");
    var value = result[0]["SUM(collectedamount)"]; // value = 220
    print(value);
    return result.toString();
  }
}
