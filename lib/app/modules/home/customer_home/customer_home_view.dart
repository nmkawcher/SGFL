import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/values/app_images.dart';
import 'package:sgfl_sales/app/core/widget/order_dataTable.dart';
import 'package:sgfl_sales/app/core/widget/step_widget.dart';
import 'package:sgfl_sales/app/data/model/order_history.dart';

import '../../../core/widget/status_card.dart';
import '../../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import '../../../core/values/app_colors.dart';
import 'customer_home_controller.dart';


class CustomerHomeView extends BaseView<CustomerHomeController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) =>null;


  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileUI(),
          totalStatusUI(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('RECENT ORDER', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)).marginOnly(left: 10, top: 24),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 20, color: AppColors.colorDark).marginOnly(right: 10, top: 24),
            ],
          ),
          StatusCard(),
        ],
      ),
    );
  }

  Widget profileUI(){
    return Container(
      margin: const EdgeInsets.only(left: 8,right: 8,top: 16),
      child: ListTile(
        onTap: (){Get.toNamed(Routes.PROFILE);},
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(AppImages.profile, height: 40)
        ),
        trailing: GestureDetector(
          onTap: (){Get.toNamed(Routes.NOTIFICATION);},
          child: Badge(
            largeSize: 8.00,
            smallSize: 8.00,
            isLabelVisible: true,
            child: Image.asset(AppImages.notificationIcon, height: 24),
          ),
        ),
        title: const Text('Welcome Back',style: TextStyle(fontSize: 12, color: AppColors.gray)),
        subtitle: const Text('Mr. Williams',
            style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: AppColors.textColor)
        ),
      ),
    );
  }

  Widget totalStatusUI(){
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(left: 16,right: 16,top: 16),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
             Stack(
               clipBehavior: Clip.none,
               children: [
                 Positioned(
                   top: 0, left: 0, bottom: 0,
                   child: Column(
                     mainAxisSize: MainAxisSize.min,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       sideCalculation("ORDER", "120"),
                       const SizedBox(height: 24),
                       sideCalculation("LORRY", "12"),
                     ],
                   ),
                 ),
                 Align(
                   alignment: Alignment.centerRight,
                   child: DashedCircularProgressBar(
                     height: 140, width: 140,
                     valueNotifier: controller.valueNotifier,
                     progress: 43,
                     startAngle: 0,
                     sweepAngle: 360,
                     foregroundColor: AppColors.orange,
                     backgroundColor: AppColors.primary.withOpacity(0.2),
                     foregroundStrokeWidth: 10,
                     backgroundStrokeWidth: 2,
                     animation: true,
                     seekSize: 6,
                     seekColor: AppColors.colorWhite,
                     child: ValueListenableBuilder(
                         valueListenable: controller.valueNotifier,
                         builder: (_, double value, __) => Column(
                           mainAxisSize: MainAxisSize.min,
                           crossAxisAlignment: CrossAxisAlignment.center,
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             Text('${value.toInt()}', style: const TextStyle(fontSize: 30)),
                             const Text('COMPLETE', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: AppColors.gray)),
                           ],
                         )
                     ),
                   ),
                 ),
               ],
             ),
            const SizedBox(height: 8),
            const Divider( thickness: 1, color: AppColors.grayLight1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                bottomCalculation("PENDING", "12", AppColors.orange),
                bottomCalculation("PROCESSING", "02", AppColors.primary),
                bottomCalculation("COMPLETE", "43", AppColors.green)
              ],
            ),
          ],
        )
      ),
    );
  }

  Widget bottomCalculation(String title, String value, Color color){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Container(
          height: 3, width: 66,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),

        ),
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.gray)),
      ],
    );
  }

  Widget sideCalculation(String title, String value){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 3, height: 48,
          margin: const EdgeInsets.only(right: 8),
          decoration: const BoxDecoration(color: AppColors.primary,
              borderRadius: BorderRadius.all(Radius.circular(10))
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.gray)),
            Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

}
