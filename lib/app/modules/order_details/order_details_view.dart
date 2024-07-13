import 'package:flutter/material.dart';
import 'package:sgfl_sales/app/core/widget/custom_btn.dart';
import 'package:sgfl_sales/app/data/model/order_model.dart';
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          orderStatusBarUI(),
          const SizedBox(height: 16),
          Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
            child:  Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Company Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
                  const SizedBox(height: 8),
                  Text(controller.order.customer?.name ??"", style: const TextStyle(fontSize: 15, color: AppColors.colorDark)),
                  Text(controller.order.customer?.address ??"", style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                  const SizedBox(height: 6),
                  textWrap2('Name', controller.order.customer?.adminName ??""),
                  textWrap2('Phone',  controller.order.customer?.contactPhone ??""),
                  textWrap2('Email',  controller.order.customer?.contactEmail ??""),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Details Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
                  const SizedBox(height: 8),
                  Text('Requisition ID #${controller.order.orderNo ??""}', style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 4),
                  textWrap2('Date', controller.order.date ??""),
                  textWrap2('Shipping', controller.order.dipo?.address ??""),
                  const SizedBox(height: 4),
                  textWrap('Note', controller.order.note ??""),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Requisition Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
          const SizedBox(height: 8),
          ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: controller.order.orderItems?.length ?? 0,
              itemBuilder: (context, index){
                OrderItem item = controller.order.orderItems![index];
                return Column(
                  children: [
                    ListTile(
                      tileColor: AppColors.blueGrey.withOpacity(0.07),
                      horizontalTitleGap: 0,
                      contentPadding: const EdgeInsets.only(left: 10),
                      leading: AppColors.circleIconBG(AppColors.orange, Icons.water_drop, radius: 16),
                      title:  Row(
                        children: [
                          Text(item.product!, style: const TextStyle(fontSize: 14, color: AppColors.blueGrey, fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8),
                          Text('(Unit Price: ৳${item.perLiterPrice})', style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                        ],
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding:const EdgeInsets.only(left: 8, right: 8,),
                      itemCount: item.itemLorries?.length,
                      itemBuilder:(context, subIndex){
                        ItemLorry lorry = item.itemLorries![subIndex];
                        return Card(
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                       Text(lorry.contractor?.name ??"", style: const TextStyle(fontSize: 15, color: AppColors.colorDark)),
                                      const SizedBox(height: 4),
                                      textWrap2('Truck No', lorry.lorry?.regNo ??""),
                                      textWrap2('Contact', lorry.contractor?.contactPhone ??""),
                                    ],
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        Text('R: ${lorry.quantityReceived}', style: const TextStyle(fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.w600)),
                                        const Text(' (Ltr)', style: TextStyle(fontSize: 11, color: AppColors.gray)),
                                      ],
                                    ),
                                    const SizedBox(height: 2),
                                    lorry.quantityReceived == "0.00"?
                                        ResizeAbleBtn(title: "RECEIVED",textSize: 10, onClick: () {  },):
                                    const Text('RECEIVED', style: TextStyle(fontSize: 12, color: AppColors.gray, fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    ),
                  ],
                );
              }
          ),
        ],
      ),
    );
  }

  Widget orderStatusBarUI() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: AppColors.defaultDecoration(color: AppColors.grayLight1),
      child: SizedBox(height: 80, child: StepWidget(step: controller.progressStep)),
    );
  }

  Widget textWrap(String title, String text){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text('$title:',style: const TextStyle(fontSize: 13, color: AppColors.blueGrey)),
        const SizedBox(width: 4),
        Expanded(
            child: Text(text, overflow: TextOverflow.visible,
                style: const TextStyle(fontSize: 13, color: AppColors.gray)
            )
        ),
      ],
    );
  }

  Widget textWrap2(String title, String text){
    return  Table(
      columnWidths:const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
      },
      children: [
        TableRow(
          children: [
            TableCell(child: Text(title, style: const TextStyle(fontSize: 13,color: AppColors.blueGrey))),
            TableCell(child: Text(": $text" , style: const TextStyle(fontSize: 13,color: Colors.black))),
          ],
        ),
      ],
    );
  }




}
