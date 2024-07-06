
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import '../model/baseResponse_model.dart';
import '../model/depot_model.dart';
import '../model/login_model.dart';
import '../remote/remote_source.dart';

abstract class Repository {
  Future<LoginResponse> loginResponse(LoginRequest request);
  Future<BaseResponseModel> logoutReqData();
  Future<List<DepotModel>> getAllDepot({int? depotId});
  Future<List<ProductModel>> getAllProduct();
}

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteSource = Get.find(tag: (RemoteDataSource).toString());

  @override
  Future<LoginResponse> loginResponse(LoginRequest request) {
    return _remoteSource.loginReqData(request);
  }

  @override
  Future<BaseResponseModel> logoutReqData() {
   return _remoteSource.logoutReqData();
  }

  @override
  Future<List<DepotModel>> getAllDepot({int? depotId}) {
    return _remoteSource.getAllDepot(depotId: depotId);
  }

  @override
  Future<List<ProductModel>> getAllProduct() {
    return _remoteSource.getAllProduct();
  }


}

