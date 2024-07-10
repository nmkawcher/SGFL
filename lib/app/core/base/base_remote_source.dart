import 'package:dio/dio.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

import '../utils/dialog_helper.dart';
import '/app/network/dio_provider.dart';
import '/app/network/error_handlers.dart';
import '/app/network/exceptions/base_exception.dart';
import '/flavors/build_config.dart';

abstract class BaseRemoteSource {
  Dio get dioClient => DioProvider.dioWithHeaderToken;

  final logger = BuildConfig.instance.config.logger;

  Future<Response<T>> callApiWithErrorParser<T>(Future<Response<T>> api) async {
    try {
      Response<T> response = await api;

      return response;
    } on DioException catch (dioError) {
      Exception exception = handleDioError(dioError);

      String? status = dioError.response?.data["status"];
      int? statusCode = dioError.response?.data["statusCode"];
      String? errorMessage = dioError.response?.data["message"];
      DialogHelper.showErrorDialog("Something went wrong", errorMessage!);


      logger.e("Throwing error from repository: >>>>>>> $exception : ${(exception as BaseException).message}");
      throw exception;
    } catch (error) {
      logger.e("Generic error: >>>>>>> $error");

      if (error is BaseException) {
        rethrow;
      }

      throw handleError("$error");
    }
  }
}
