
import '../../model/login_model.dart';
import '../../model/product_model.dart';

abstract class SQLiteManager{

  Future<int> insertItems(String tableName, Map<String, dynamic> toMap);

  Future<int> deleteAllData(String tableName);

  Future deleteDB();

  Future<UserModel?> getUserInfoData();

  Future<Organisation?> getOrganisationData();

  Future<List<ProductModel>>getProductData();

}
