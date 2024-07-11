import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/order_model.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import '../../routes/app_pages.dart';
import 'order_controller.dart';

class OrderView extends BaseView<OrderController> {

  OrderView(){
    controller.fetchOrderData();
  }

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
    return Obx((){
      return  TabBarView(
          controller: controller.tabController,
          children: [
            buildOrderList(controller.pendingOrderList),
            buildOrderList(controller.processingOrderList),
            buildOrderList(controller.completedOrderList),
          ],
      );
    });
  }


  Widget buildOrderList(RxList<Order> orderList) {
    return ListView.separated(
      itemCount: orderList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
      itemBuilder: (BuildContext context, int index) {
        return orderItemUI(orderList[index]);
      },
    );
  }


  Widget orderItemUI(Order order) {
    var statusColors = AppColors.statusColor(order.status ?? '');
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           Text(order.orderNo ?? "", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary)),
                           Text(' at ${order.orderAt}', style: const TextStyle(fontSize: 12, color: AppColors.gray, fontWeight: FontWeight.w400)),
                         ],
                       ),
                       const SizedBox(height: 2),
                       Text(order.supplier??'', style: const TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.normal)),
                       Text(order.customer??'',  style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                       Container(
                          margin: const EdgeInsets.only(top: 4),
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: statusColors.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child:  Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(order.quantityLiter??'', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.grayDark)),
                              Text(' / ৳ ${order.totalAmount ?? 0.00}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gray)),
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
                    Text('${order.totalLorryPhysically} Lorry', style: const TextStyle(fontSize: 13, color: AppColors.blueGrey, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(order.status?.toUpperCase()??'', style: TextStyle(fontSize: 12, color: statusColors, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
      ),
    );
  }

}
