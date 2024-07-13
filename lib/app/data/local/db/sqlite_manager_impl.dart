import 'package:path/path.dart' as path;
import 'package:sgfl_sales/app/data/model/login_model.dart';
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
    await deleteDatabase(dbPath);
    return openDatabase(dbPath, version: dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version)async{

    await db.execute(userInfoDBTable);

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
  Future<User?> getUserInfoData() async {
    final db = await database;
    final map = await db.query(tableUserInfo);
    if(map.isNotEmpty) {
      return User.fromJson(map.first);
    }else{
      return null;
    }
  }


}

