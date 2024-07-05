import 'package:dio/dio.dart';
import '../../core/base/base_remote_source.dart';
import '../../core/values/app_const.dart';
import '../model/baseResponse_model.dart';
import '../model/depot_model.dart';
import '../model/login_model.dart';


abstract class RemoteDataSource {
  Future<LoginResponse> loginReqData(LoginRequest request);
  Future<BaseResponseModel> logoutReqData();
  Future<List<DepotModel>> getAllDepot(int depotId);
}


class RemoteDataSourceImpl extends BaseRemoteSource implements RemoteDataSource {

  @override
  Future<LoginResponse> loginReqData(LoginRequest request) {

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
    var dioCall = dioClient.get(endpoint);

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _baseResponseData(response));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<DepotModel>> getAllDepot(int depotId) {
    var dioCall = dioClient.get(ApiEndPoint.DEPOT, queryParameters: {'depot_id': depotId});

    try {
      return callApiWithErrorParser(dioCall)
          .then((response) => _depotResData(response));
    } catch (e) {
      rethrow;
    }
  }


  /// Response Data
  BaseResponseModel _baseResponseData(Response<dynamic> response){
    return BaseResponseModel.fromJson(response.data);
  }

  LoginResponse _loginResData(Response<dynamic> response){
    return LoginResponse.fromJson(response.data);
  }

  List<DepotModel> _depotResData(Response<dynamic> response){
   return depotModelFromJson(response.data);
  }

}
