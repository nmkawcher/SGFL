import 'package:get/get.dart';
import '../../data/local/preference/preference_manager.dart';
import '../../data/model/depot_model.dart';
import '../../data/repository/repository.dart';
import '/app/core/base/base_controller.dart';

class DepotController extends BaseController {

  RxInt selectedDepot = 0.obs;
  var selectedDepotZone = DepotZone().obs;
  final RxList<DepotModel> _rxDepotList = RxList.empty();
  List<DepotModel> get depotList => _rxDepotList.toList();

  final Repository _repository = Get.find(tag: (Repository).toString());

  void fetchDepotData() async{
    var orgId = await preference.getInt(PreferenceManager.keyOrganizationId);
    var service = _repository.getAllDepot(depotId: orgId);
    callDataService(service, onSuccess: _handleResponseSuccess);
  }

  void _handleResponseSuccess(List<DepotModel> result) async {
    _rxDepotList.addAll(result);
  }

}
