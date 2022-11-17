import 'package:rent_collection_app/database/database_helper.dart';
import 'package:rent_collection_app/database/util.dart';
import 'package:rent_collection_app/models/product.dart';

class ProductRepo {
  DatabaseHelper dbhelper = DatabaseHelper();

//To show all

  Future<List<Product>> getproduct() async {
    var dbClient = await dbhelper.db;
    List<Map> maps =
        await dbClient.query(tableName, columns: ['shopid', 'name', 'price']);
    List<Product> product = [];

    for (int i = 0; i < maps.length; i++) {
      product.add(Product.fromMap(maps[i]));
    }
    return product;
  }

  // Future<List<Product>> getrow(int id) async {
  //   var dbClient = await dbhelper.db;
  //   List<Map> maps =
  //       await dbClient.query(tableName, columns: ['shopid', 'name', 'price'],where: 'id=shopid',whereArgs: [id]);
  //   List<Product> product = [];

  //   for (int i = 0; i < maps.length; i++) {
  //     product.add(Product.fromMap(maps[i]));
  //   }
  //   return product;
  // }

//Find One row
  Future<List<Product>> find(int id) async {
    var dbClient = await dbhelper.db;
    List<Map> maps = await dbClient.query(tableName,
        columns: ['shopid', 'name', 'price'], where: 'id=shopid');
    List<Product> product = [];

    product.add(Product.fromMap(maps[id]));

    return product;
  }

//FOr one Row against name
  Future<List<Map<String, dynamic>>> queryRows(id) async {
    var dbClient = await dbhelper.db;
    return await dbClient.query(tableName, where: "shopid LIKE '%$id%'");
  }

  //insert
  Future<int> add(Product product) async {
    var dbClient = await dbhelper.db;
    return await dbClient.insert(tableName, product.toMap());
  }

//update
  Future<int> update(Product product) async {
    var dbClient = await dbhelper.db;
    return await dbClient.update(tableName, product.toMap(),
        where: 'shopid = ?', whereArgs: [product.id]);
  }

//delete
  Future<int> delete(int id) async {
    var dbClient = await dbhelper.db;
    return await dbClient
        .delete(tableName, where: 'shopid = ?', whereArgs: [id]);
  }
}
