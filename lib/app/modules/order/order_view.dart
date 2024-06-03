import 'package:flutter/material.dart';
import '../../core/widget/custom_app_bar.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import 'order_controller.dart';

class OrderView extends BaseView<OrderController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title:"Orders");
  }

  @override
  Widget body(BuildContext context) {

    return ListView.separated(
      itemCount: 4,
      padding: const EdgeInsets.all(8),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
      itemBuilder: (BuildContext context, int index) {
        var statusColors = AppColors.statusColor(controller.orderStatus.value);
        return orderItemUI(statusColors);
      },
    );
  }

  Widget orderItemUI(Color statusColors) {
    return Container(
        decoration: AppColors.defaultDecoration(),
        padding: const EdgeInsets.only(left: 10,right: 8,top: 8,bottom: 8),
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
                    decoration: AppColors.defaultDecoration(color: statusColors, radius: 8),
                    child: Text('Panding', style: TextStyle(fontSize: 12, color: statusColors)
                    )
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
      );
  }

}
