import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../core/widget/custom_btn.dart';
import '../../data/model/depot_model.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import 'depot_controller.dart';

class DepotView extends BaseView<DepotController> {
  DepotView(){
    controller.fetchDepotData();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title:"Select Depot");
  }

  @override
  Widget body(BuildContext context) {
    return Obx((){
      return ListView.builder(
          itemCount: controller.depotList.length,
          itemBuilder: (context, index){
            return Column(
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  leading: const SizedBox(
                    height: double.infinity,
                    child: Icon(Icons.account_balance_rounded, color: AppColors.blueGrey, size: 24),
                  ),
                  title:  Text(controller.depotList[index].name!, style: const TextStyle(fontSize: 16, color: AppColors.blueGrey)),
                  subtitle: Text(controller.depotList[index].address!, style: const TextStyle(fontSize: 12, color: AppColors.blueGrey)),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  padding:const EdgeInsets.only(left: 8, right: 8, top: 8),
                  itemCount: controller.depotList[index].depotZone?.length,
                  itemBuilder:(context, subIndex)=> depotItem(index, subIndex),
                ),
              ],
            );
          }
      );
    });
  }


  @override
  Widget? bottomNavigationBar() {
    return Obx((){
      return Padding(
        padding: const EdgeInsets.all(16),
        child: controller.selectedDepot.value == 0 ? null : DefaultAppBtn(
            title: appLocalization.next,
            onClick: (){
                Get.toNamed(Routes.REQUISITION,
                   arguments: [
                      controller.selectedDepotZone,
                      Get.arguments
                   ]
              );
            }
        ),
      );
    });
  }


  Widget depotItem(int index, int subIndex){
    DepotZone depot = controller.depotList[index].depotZone![subIndex];

    return Obx((){
      var isSelected = controller.selectedDepot.value == depot.id;
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
          onTap: (){
            controller.selectedDepot.value = depot.id ?? 0;
            controller.selectedDepotZone.value = depot;
          },
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
                    Text( depot.name!, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('${depot.address} ${depot.postcode}',style: const TextStyle(fontSize: 12, color: AppColors.gray)),
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
