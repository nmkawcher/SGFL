
import '../../model/login_model.dart';

abstract class SQLiteManager{

  Future<int> insertItems(String tableName, Map<String, dynamic> toMap);

  Future<int> deleteAllData(String tableName);

  Future<User?> getUserInfoData();

}
