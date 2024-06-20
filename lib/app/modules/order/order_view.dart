import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import '../../routes/app_pages.dart';
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
            height: 40,
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
              indicatorWeight: 0,
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
    var padding = const EdgeInsets.all(8);
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
              padding: padding,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                var statusColors = AppColors.statusColor(controller.orderStatus.value);
                return orderItemUI(statusColors);
          }),
          ListView.separated(
              itemCount: 4,
              shrinkWrap: true,
              padding: padding,
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemBuilder: (BuildContext context, int index) {
                var statusColors = AppColors.statusColor(controller.orderStatus.value);
                return orderItemUI(statusColors);
              }),

        ]
    );
  }

  Widget orderItemUI(Color statusColors) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: (){Get.toNamed(Routes.ORDERDetails);},
        child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                AppColors.circleIconBG(statusColors, Icons.water_drop),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('#2551646', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      const SizedBox(height: 2),
                      const Text('Podma Oil Company ltd.', style: TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.normal)),
                      const Text('Bagabri, Sylhet',  style: TextStyle(fontSize: 12, color: AppColors.gray)),
                      Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: statusColors.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('5.2 / ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.grayDark)),
                              Text('৳ 200000', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gray)),
                            ],
                          )
                      )
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Pending', style: TextStyle(fontSize: 12, color: statusColors, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    const Text('22 JAN 2024', style: TextStyle(fontSize: 12, color: AppColors.gray, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

}
