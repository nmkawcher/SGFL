import 'package:get/get.dart';
import '../data/repository/oauth_repository.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OauthRepository>(
      () => OauthRepositoryImpl(),
      tag: (OauthRepository).toString(),
        fenix: true
    );
  }
}
