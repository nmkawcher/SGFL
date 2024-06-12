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
          const Text('Order id #2345435', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
          const Text('Date #12 JUN 2024', style: TextStyle(fontSize: 12, color: AppColors.gray)),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Padma Oil Company Limited', style: TextStyle(fontSize: 14, color: AppColors.textColor)),
                  Text('Road 16,SIRAJDOLLA ROAD, CHITTAGONG', style: TextStyle(fontSize: 13,color: AppColors.gray)),
                ],
              ),
              AppColors.circleIconBG(AppColors.primary, Icons.location_on_rounded)
            ],
          ),
          const SizedBox(height: 8),
          const Text('Product Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          const Divider(color: AppColors.grayLight1, thickness: 1),
          ListView.builder(
            shrinkWrap: true,
            itemCount: controller.productList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AppColors.circleIconBG(AppColors.orange, Icons.water_drop),
                        const SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(controller.productList[index].productName!, style: const TextStyle(fontSize: 16)),
                             const Row(
                              children: [
                                Text('Total', style: TextStyle(fontSize: 12, color: AppColors.gray),),
                                SizedBox(width: 4),
                                Text('7000 Tk.', style: TextStyle(fontSize: 12,color: AppColors.primary),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('2', style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600, color: AppColors.colorDark),),
                            Text('Lorry', style: TextStyle(fontSize: 12,color: AppColors.gray),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1, width: Get.width,
                    color: AppColors.grayLight1,
                    margin: const EdgeInsets.only(top: 8,bottom: 8)
                  )
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          const Text('Order Summary', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
