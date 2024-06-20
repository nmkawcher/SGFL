import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../data/model/depot_model.dart';
import '../../data/model/location_model.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_btn.dart';
import '../../core/widget/custom_inputField.dart';
import '../../routes/app_pages.dart';
import 'requisition_controller.dart';

class RequisitionInformationView extends BaseView<RequisitionController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title:"Select Depot");
  }

  @override
  Widget body(BuildContext context) {
    return Obx((){
      return ListView.builder(
          padding:const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
          itemCount: controller.depotList.length,
          itemBuilder:(context, index)=> depotItem(controller.depotList[index], index),
      );
    });
  }


  @override
  Widget? bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DefaultAppBtn(
          title: appLocalization.next,
          onClick: () {Get.toNamed(Routes.REQUISITION_Quantity);}
      ),
    );
  }


  Widget depotItem(DepotModel depot, int index){
    return Obx((){
      var isSelected = controller.selectedDepot.value == index;
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: isSelected ? 3 : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: isSelected ? AppColors.orange : Colors.transparent,
                width: 1
            )
        ),
        child: InkWell(
          onTap: (){ controller.selectedDepot.value = index;},
          child: Container(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_rounded, color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text( depot.depotName!, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(depot.depotAddress!,style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                  ],
                ),
                const Spacer(),
                Icon(isSelected ?
                Icons.check_circle_rounded : Icons.circle_outlined,
                    color: isSelected ? AppColors.orange : AppColors.grayLight1,
                    size: 20
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

}
