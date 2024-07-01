import 'package:get/get.dart';

import '../data/remote/oauth_remote_source.dart';

class RemoteSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OauthRemoteDataSource>(
        () => OauthRemoteDataSourceImpl(),
        tag: (OauthRemoteDataSource).toString(),
          fenix: true
    );
  }
}
