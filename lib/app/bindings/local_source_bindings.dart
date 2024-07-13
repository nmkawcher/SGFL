import 'package:get/get.dart';

import '../data/local/db/sqlite_manager.dart';
import '../data/local/db/sqlite_manager_impl.dart';
import '/app/data/local/preference/preference_manager.dart';
import '/app/data/local/preference/preference_manager_impl.dart';

class LocalSourceBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PreferenceManager>(
      () => PreferenceManagerImpl(),
      tag: (PreferenceManager).toString(),
      fenix: true,
    );
    Get.lazyPut<SQLiteManager>(
          () => SQLiteManagerImpl(),
      tag: (SQLiteManager).toString(),
      fenix: true,
    );
  }
}
