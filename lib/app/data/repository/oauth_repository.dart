
import 'package:get/get.dart';
import '../model/baseResponse_model.dart';
import '../model/login_model.dart';
import '../remote/oauth_remote_source.dart';

abstract class OauthRepository {
  Future<LoginResponse> loginResponse(LoginRequest request);
  Future<BaseResponseModel> logoutReqData();
}

class OauthRepositoryImpl implements OauthRepository{

  final OauthRemoteDataSource _remoteSource = Get.find(tag: (OauthRemoteDataSource).toString());

  @override
  Future<LoginResponse> loginResponse(LoginRequest request) {
    return _remoteSource.loginReqData(request);
  }

  @override
  Future<BaseResponseModel> logoutReqData() {
   return _remoteSource.logoutReqData();
  }

}

