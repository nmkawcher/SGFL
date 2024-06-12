import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/values/app_images.dart';
import 'package:sgfl_sales/app/core/widget/order_dataTable.dart';
import 'package:sgfl_sales/app/core/widget/step_widget.dart';
import 'package:sgfl_sales/app/data/model/order_history.dart';

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
          const Text('Order Status', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)).marginOnly(left: 10, top: 16),
          SizedBox(
            height: 200,
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: 3,
                padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index){
                  return orderStatusBarUI();
                }
            ),
          ),
        ],
      ),
    );
  }

  Widget orderStatusBarUI() {
    return Container(
      width: 120,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(60),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10)
          ),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.colorPrimary, AppColors.primary]
          )
      ),
      margin: const EdgeInsets.only(left: 8,right:8, top: 16),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          const Positioned(
            top: -24, left: 10,
            child: Icon(Icons.water_drop, color: AppColors.orange, size: 50),
          ),
          Positioned(
              top: -30, left: -16,
              child: CircleAvatar(
                  radius: 46,
                  backgroundColor: Colors.white.withOpacity(0.20)
              )
          ),
          const Positioned(
            left: 10, right: 8,bottom: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('#233213', style: TextStyle(fontSize: 16, color: AppColors.colorWhite, fontWeight: FontWeight.w600)),
                SizedBox(height: 4),
                Text('PENDING', style: TextStyle(fontSize: 10, color: AppColors.colorWhite, fontWeight: FontWeight.w600)),
                Text('Total lorry #3', style: TextStyle(fontSize: 10, color: AppColors.colorWhite, fontWeight: FontWeight.w600)),
                Text('Aug 12, 2024', style: TextStyle(fontSize: 12, color: AppColors.colorWhite)),
                SizedBox(height: 8),
                Row(
                  children: [
                    Text('960300', style: TextStyle(fontSize: 18, color: AppColors.colorWhite, fontWeight: FontWeight.w600)),
                    SizedBox(width: 4),
                    Text('Tk.', style: TextStyle(fontSize: 12, color: AppColors.colorWhite)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileUI(){
    return Container(
      margin: const EdgeInsets.only(left: 8,right: 8,top: 16),
      child: ListTile(
        onTap: (){Get.toNamed(Routes.PROFILE);},
        leading: AppColors.circleIconBG(AppColors.primary, Icons.person),
        trailing: GestureDetector(
          onTap: (){Get.toNamed(Routes.NOTIFICATION);},
          child: Badge(
            largeSize: 10.00,
            smallSize: 10.00,
            isLabelVisible: true,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color:AppColors.primary, width: 0.5)
              ),
              child: Image.asset(AppImages.notificationIcon, height: 24,),
            ),
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
    return Container(
      margin: const EdgeInsets.only(left: 16,right: 16,top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(60),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(10)
          ),
          border: Border.all(color: AppColors.grayLight2, width: 0.5),
          color: AppColors.colorWhite
      ),
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
                     sideCalculation("Total Order", "120", AppColors.primary),
                     const SizedBox(height: 24),
                     sideCalculation("Total Lorry", "12", AppColors.orange),
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
                   foregroundColor: AppColors.primary,
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
                           const Text('COMPLETE', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
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
              bottomCalculation("PROCESSING", "02", Colors.blueAccent),
              bottomCalculation("COMPLETE", "43", AppColors.primary),
            ],
          ),
        ],
      )
    );
  }

  Widget bottomCalculation(String title, String value, Color color){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        Container(
          height: 3, width: 66,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),

        ),
        Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.gray)),
      ],
    );
  }

  Widget sideCalculation(String title, String value, Color color){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: 2, height: 48,
          margin: const EdgeInsets.only(right: 8),
          decoration: BoxDecoration(color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10))
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                const SizedBox(width: 4),
                const Text('Lorry', style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300)),
              ],
            ),
          ],
        ),
      ],
    );
  }

}
