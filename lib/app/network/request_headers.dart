import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import '../data/local/preference/preference_manager.dart';

class RequestHeaderInterceptor extends InterceptorsWrapper {

  final PreferenceManager _preferenceManager = getx.Get.find(tag: (PreferenceManager).toString());


  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    getCustomHeaders().then((customHeaders) {
      options.headers.addAll(customHeaders);
      super.onRequest(options, handler);
    });
  }

  Future<Map<String, String>> getCustomHeaders() async {
    final String accessToken = await _preferenceManager.getString(PreferenceManager.keyAccessToken);

    if (accessToken.trim().isNotEmpty) {
      var customHeaders = {'content-type': 'application/json'};
      customHeaders.addAll({'Authorization': "Bearer $accessToken"});
      return customHeaders;

    }else{
      var customHeaders = {'content-type': 'form-data'};
      return customHeaders;
    }

  }
}
