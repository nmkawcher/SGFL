import 'dart:convert';

import 'package:dio/dio.dart';
import '../../core/base/base_remote_source.dart';
import '../../core/values/app_const.dart';
import '../model/baseResponse_model.dart';
import '../model/contractor_model.dart';
import '../model/depot_model.dart';
import '../model/home_model.dart';
import '../model/login_model.dart';
import '../model/product_model.dart';
import '../model/requisition_model.dart';
import '../model/reset_pass_model.dart';
import '../model/unassign_model.dart';


abstract class RemoteDataSource {
  Future<LoginModel> loginReqData(LoginModel request);
  Future<BaseResponseModel> logoutReqData();
  Future<List<DepotModel>> getAllDepot({int? depotId});
  Future<List<ProductModel>> getAllProduct();
  Future<UserModel> getProfileData();
  Future<UserModel> updateProfileData(UserModel profile);
  Future<BaseResponseModel> updatePassword(PasswordReqModel passwordReqModel);
  Future<BaseResponseModel> requisitionReqData(RequisitionReqModel reqModel);
  Future<dynamic> getOrderData({dynamic query});
  Future<HomeModel> getDashBoardData();
  Future<BaseResponseModel> orderConfirm(int id);
  Future<List<UnassignedModel>> getAllUnassigned();
  Future<List<Contractor>> getContractorData();
  Future<BaseResponseModel> assignOrder(List<AssignModel> assignModel);

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
  Future<UserModel> getProfileData() {
    var dioCall = dioClient.get(ApiEndPoint.PROFILE);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _profileResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> updateProfileData(UserModel profile) {
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

  @override
  Future<BaseResponseModel> requisitionReqData(RequisitionReqModel reqModel) {
    var data = FormData.fromMap(reqModel.toJson());
    var dioCall = dioClient.post(ApiEndPoint.REQUISITION,data: data);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _baseResponseData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> getOrderData({dynamic query}){
      var dioCall = dioClient.get(ApiEndPoint.ORDER, queryParameters: query);

      try {
        return callApiWithErrorParser(dioCall)
            .then((response) => _orderResData(response));
      } catch (e) {
        rethrow;
      }
  }

  @override
  Future<HomeModel> getDashBoardData() {
    var dioCall = dioClient.get(ApiEndPoint.DASHBOARD);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _homeResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> orderConfirm(int id) {
    var data = FormData.fromMap({'status': 'confirmed', '_method': 'put'});
    var dioCall = dioClient.post('${ApiEndPoint.ORDER}/$id/status-update', data: data);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _baseResponseData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<UnassignedModel>> getAllUnassigned() {
    var dioCall = dioClient.get(ApiEndPoint.UNASSIGN);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _unAssignResData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<BaseResponseModel> assignOrder(List<AssignModel> assignModel) {
    var data = FormData.fromMap(
      { '_method': 'put',
        "items": List.from(assignModel.map((x) => x.toJson())),
      }
    );

    var dioCall = dioClient.post(ApiEndPoint.ASSIGN, data: data);
    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _baseResponseData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Contractor>> getContractorData() {
    var dioCall = dioClient.get(ApiEndPoint.CONTRACTOR);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _contractorResData(response));
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

  UserModel _profileResData(Response<dynamic> response){
   return UserModel.fromJson(response.data);
  }

  UserModel _profileUpdateResData(Response<dynamic> response){
    var result = BaseResponseModel.fromJson(response.data);
   return UserModel.fromJson(result.data);
  }

  dynamic _orderResData(Response<dynamic> response){
    return response.data;
  }

  HomeModel _homeResData(Response<dynamic> response){
    return HomeModel.fromJson(response.data);
  }

  List<UnassignedModel> _unAssignResData(Response<dynamic> response){
    return unAssignModelFromJson(response.data);
  }

  List<Contractor> _contractorResData(Response<dynamic> response){
    return List.from(response.data.map((x) => Contractor.fromJson(x)));
  }

}
