
import 'package:get/get.dart';
import '../model/baseResponse_model.dart';
import '../model/depot_model.dart';
import '../model/login_model.dart';
import '../model/product_model.dart';
import '../model/profile_model.dart';
import '../model/reset_pass_model.dart';
import '../remote/remote_source.dart';

abstract class Repository {
  Future<LoginModel> loginResponse(LoginModel request);
  Future<BaseResponseModel> logoutReqData();
  Future<List<DepotModel>> getAllDepot({int? depotId});
  Future<List<ProductModel>> getAllProduct();
  Future<ProfileModel> getProfileData();
  Future<ProfileModel> updateProfileData(ProfileModel profile);
  Future<BaseResponseModel> updatePassword(PasswordReqModel passwordReqModel);
}

class RepositoryImpl implements Repository{

  final RemoteDataSource _remoteSource = Get.find(tag: (RemoteDataSource).toString());

  @override
  Future<LoginModel> loginResponse(LoginModel request) {
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

  @override
  Future<ProfileModel> getProfileData() {
    return _remoteSource.getProfileData();
  }

  @override
  Future<ProfileModel> updateProfileData(ProfileModel profile) {
    return _remoteSource.updateProfileData(profile);
  }

  @override
  Future<BaseResponseModel> updatePassword(PasswordReqModel passwordReqModel) {
    return _remoteSource.updatePassword(passwordReqModel);
  }

}

