import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

class DatabaseHelper {
  static Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDatabase();
    return _db!;
  }

  _onConfigure(Database db) async {
    // Add support for cascade delete
    await db.execute("PRAGMA foreign_keys = ON");
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(
      documentDirectory.path,
      'rents.db',
    );

    // await deleteDatabase(path);

    var db = openDatabase(path,
        version: 3, onCreate: _onCreate, onConfigure: _onConfigure);
    return db;
  }

  _onCreate(Database db, int version) {
    db.execute(
        '''CREATE TABLE rents(shopid INTEGER PRIMARY KEY, name TEXT NOT NULL UNIQUE, price TEXT NOT NULL )''');

    db.execute(
        '''CREATE TABLE shopdetails(id INTEGER PRIMARY KEY, collectedamount TEXT, collectiondate TEXT, shopid INTEGER NOT NULL )''');
  }
}
