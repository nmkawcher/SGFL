import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../core/widget/step_widget.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import 'order_details_controller.dart';

class OrderDetailsView extends BaseView<OrderDetailsController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title: 'Order Details',elevation: 0);
  }

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 20,bottom: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          orderStatusBarUI(),
          const SizedBox(height: 16),
          const Text('Order id #2345435', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          const Text('Date #12 JUN 2024', style: TextStyle(fontSize: 12, color: AppColors.gray)),
          const SizedBox(height: 8),
          const Text('Depot Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Padma Oil Company Limited', style: const TextStyle(fontSize: 14, color: AppColors.textColor)),
                  Text('Road 16,SIRAJDOLLA ROAD, CHITTAGONG', style: const TextStyle(fontSize: 13,color: AppColors.gray)),
                ],
              ),
              AppColors.circleIconBG(AppColors.primary, Icons.location_on_rounded)
            ],
          ),
          const SizedBox(height: 8),
          const Text('Product Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const Divider(color: AppColors.grayLight1, thickness: 1),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.productList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    leading: AppColors.circleIconBG(AppColors.orange, Icons.water_drop),
                    trailing: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('2', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: AppColors.colorDark),),
                        Text('Lorry', style: TextStyle(fontSize: 12,color: AppColors.gray),
                        ),
                      ],
                    ),
                    title: Text(controller.productList[index].productName!, style: const TextStyle(fontSize: 16)),
                    subtitle: const Row(
                      children: [
                        Text('Total', style: TextStyle(fontSize: 12, color: AppColors.gray),),
                        SizedBox(width: 4),
                        Text('7000 Tk.', style: TextStyle(fontSize: 12,color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                  Container(height: 1, width: Get.width, color: AppColors.grayLight1,)
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Number of lorry', style: TextStyle(fontSize: 14,color: AppColors.gray)),
              Text('5 lorry', style: TextStyle(fontSize: 14,color: AppColors.orange)),
            ],
          ),
          const SizedBox(height: 4),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Amount', style: TextStyle(fontSize: 14,color: AppColors.gray)),
              Text('5000.00 Tk', style: TextStyle(fontSize: 14,color: AppColors.orange)),
            ],
          ),

        ],
      ),
    );
  }

  Widget orderStatusBarUI() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: AppColors.defaultDecoration(color: AppColors.grayLight1),
      child: SizedBox(height: 80, child: StepWidget(step: 1)),
    );
  }


}
