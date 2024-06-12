import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import 'order_controller.dart';

class OrderView extends BaseView<OrderController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
        title: const Text('Orders',style: TextStyle(fontSize: 20, color: AppColors.colorDark, fontWeight: FontWeight.w500)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight - 8.0),
          child: Container(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(32),
            ),
            child: TabBar(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              controller: controller.tabController,
              tabs: controller.tabs,
              unselectedLabelColor: AppColors.primary,
              labelColor: AppColors.colorWhite,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: AppColors.primary,
              ),
            ),
          ),
        ),
    );
  }

  @override
  Widget body(BuildContext context) {
    var padding = const EdgeInsets.only(top: 16);
    return  TabBarView(
      controller: controller.tabController,
        children: [
          ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              padding: padding,
              itemBuilder: (BuildContext context, int index) {
                var statusColors = AppColors.statusColor(controller.orderStatus.value);
                return orderItemUI(statusColors);
          }),
          ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                var statusColors = AppColors.statusColor(controller.orderStatus.value);
                return orderItemUI(statusColors);
          }),
          ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                var statusColors = AppColors.statusColor(controller.orderStatus.value);
                return orderItemUI(statusColors);
              }),

        ]
    );
  }

  Widget orderItemUI(Color statusColors) {
    return InkWell(
      onTap: (){Get.toNamed(Routes.ORDERDetails);},
      child: Container(
          padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  AppColors.circleIconBG(statusColors, Icons.water_drop),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Row(
                              children: [
                                Text('Order#: ', style: TextStyle(fontSize: 18, color: AppColors.textColor)),
                                Text('2551646', style: TextStyle(fontSize: 18, color: AppColors.primary)),
                              ],
                            ),
                            Container(
                                padding: const EdgeInsets.all(4),
                                decoration: AppColors.fillDecoration(color: statusColors, radius: 8, bgColor: statusColors),
                                child: const Text('Panding', style: TextStyle(fontSize: 12, color: AppColors.colorWhite))
                            )
                          ],
                        ),
                        const Text('12 JUN 2024', style: TextStyle(fontSize: 13, color: AppColors.gray)),
                        const SizedBox(height: 8),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Shipping address', style: TextStyle(fontSize: 14, color: AppColors.gray)),
                                SizedBox(width:4),
                                Icon(Icons.location_on_rounded, color: AppColors.gray,size: 16,),
                              ],
                            ),
                            Text('1234, 5th Avenue, New York, USA', style: TextStyle(fontSize: 14)),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 8),
                height: 1,
                width: Get.width,
                color: AppColors.grayLight1,
              )
            ],
          ),
        ),
    );
  }

}
