import 'package:get/get.dart';
import '../data/repository/repository.dart';

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Repository>(
      () => RepositoryImpl(),
      tag: (Repository).toString(),
        fenix: true
    );
  }
}
