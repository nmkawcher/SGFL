import 'package:dio/dio.dart';
import '../../core/base/base_remote_source.dart';
import '../../core/values/app_const.dart';
import '../model/baseResponse_model.dart';
import '../model/login_model.dart';


abstract class OauthRemoteDataSource {
  Future<LoginResponse> loginReqData(LoginRequest request);
  Future<BaseResponseModel> logoutReqData();
}


class OauthRemoteDataSourceImpl extends BaseRemoteSource implements OauthRemoteDataSource {

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


  /// Response Data
  BaseResponseModel _baseResponseData(Response<dynamic> response){
    return BaseResponseModel.fromJson(response.data);
  }

  LoginResponse _loginResData(Response<dynamic> response){
    return LoginResponse.fromJson(response.data);
  }

}
