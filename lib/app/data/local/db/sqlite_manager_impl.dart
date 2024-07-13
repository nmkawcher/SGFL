import 'dart:async';
import 'package:path/path.dart' as path;
import 'package:sgfl_sales/app/data/model/login_model.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import 'package:sqflite/sqflite.dart';
import 'sqlite_manager.dart';
import 'sqlite_table.dart';

class SQLiteManagerImpl extends SQLiteManager {

  int dbVersion = 1;
  static Database? _database;
  Future<Database> get database async => _database ??= await _open();
  Future close() async => await _database?.close();

  Future<Database> _open() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'sgfl.db');
    return openDatabase(dbPath, version: dbVersion, onCreate: _onCreate);
  }

  @override
  Future deleteDB() async {
    final rootPath = await getDatabasesPath();
    final dbPath = path.join(rootPath, 'sgfl.db');
    await deleteDatabase(dbPath);
  }

  Future _onCreate(Database db, int version)async{
    await db.execute(userDBTable);
    await db.execute(organisationDBTable);
    await db.execute(productDBTable);

  }

 ///.............. CRUID Operation ................

  @override
  Future<int> insertItems(String tableName, Map<String, dynamic> toMap)async {
    final db = await database;
    return db.insert(tableName, toMap, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<int> deleteAllData(String tableName) async {
    final db = await database;
    return db.delete(tableName);
  }

  @override
  Future<Organisation?> getOrganisationData()async {
    final db = await database;
    final map = await db.query(tableOrganization, limit: 1);
    if(map.isNotEmpty) {
      return Organisation.fromJson(map.first);
    }else{
      return null;
    }
  }

  @override
  Future<UserModel?> getUserInfoData() async{
    final db = await database;
    final map = await db.query(tableUser, limit: 1);
    if(map.isNotEmpty) {
      return UserModel.fromJson(map.first);
    }else{
      return null;
    }
  }

  @override
  Future<List<ProductModel>> getProductData() async{
    final db = await database;
    final map = await db.query(tableProduct);
    return List.generate(map.length, (index) => ProductModel.fromJson(map[index]));
  }




}

