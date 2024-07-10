import 'package:dio/dio.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import 'package:sgfl_sales/app/data/model/profile_model.dart';

import '../../core/base/base_remote_source.dart';
import '../../core/values/app_const.dart';
import '../model/baseResponse_model.dart';
import '../model/depot_model.dart';
import '../model/login_model.dart';
import '../model/reset_pass_model.dart';


abstract class RemoteDataSource {
  Future<LoginModel> loginReqData(LoginModel request);
  Future<BaseResponseModel> logoutReqData();
  Future<List<DepotModel>> getAllDepot({int? depotId});
  Future<List<ProductModel>> getAllProduct();
  Future<ProfileModel> getProfileData();
  Future<ProfileModel> updateProfileData(ProfileModel profile);
  Future<BaseResponseModel> updatePassword(PasswordReqModel passwordReqModel);
}


class RemoteDataSourceImpl extends BaseRemoteSource implements RemoteDataSource {

  @override
  Future<LoginModel> loginReqData(LoginModel request) {

    var data = FormData.fromMap(request.toJson());
    var dioCall = dioClient.post(ApiEndPoint.LOGIN,data: data);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _loginResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> logoutReqData() {

    var endpoint = ApiEndPoint.LOGOUT;
    var dioCall = dioClient.post(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _baseResponseData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DepotModel>> getAllDepot({int? depotId}) {
    var dioCall = depotId == 0
        ? dioClient.get(ApiEndPoint.DEPOT)
        : dioClient.get('${ApiEndPoint.DEPOT}/$depotId');

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _depotResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> getAllProduct() {
    var dioCall = dioClient.get(ApiEndPoint.PRODUCT);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _productResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileModel> getProfileData() {
    var dioCall = dioClient.get(ApiEndPoint.PROFILE);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _profileResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProfileModel> updateProfileData(ProfileModel profile) {
    var data = FormData.fromMap(profile.profileUpdateJson());
    var dioCall = dioClient.post(ApiEndPoint.PROFILE,data: data);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _profileUpdateResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> updatePassword(PasswordReqModel passwordReqModel) {
    var data = FormData.fromMap(passwordReqModel.toJson());
    var dioCall = dioClient.post(ApiEndPoint.PASSWORD,data: data);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _baseResponseData(response));
    } catch (e) {
      rethrow;
    }
  }

  /// Response Data
  BaseResponseModel _baseResponseData(Response<dynamic> response){
    return BaseResponseModel.fromJson(response.data);
  }

  LoginModel _loginResData(Response<dynamic> response){
    return LoginModel.fromJson(response.data);
  }

  List<DepotModel> _depotResData(Response<dynamic> response){
   return depotModelFromJson(response.data);
  }

  List<ProductModel> _productResData(Response<dynamic> response){
   return productModelFromJson(response.data);
  }

  ProfileModel _profileResData(Response<dynamic> response){
   return ProfileModel.fromJson(response.data);
  }

  ProfileModel _profileUpdateResData(Response<dynamic> response){
    var result = BaseResponseModel.fromJson(response.data);
   return ProfileModel.fromJson(result.data);
  }

}
