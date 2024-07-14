import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/widget/custom_btn.dart';
import 'package:sgfl_sales/app/data/model/order_model.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../core/widget/custom_inputField.dart';
import '../../core/widget/step_widget.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import 'order_details_controller.dart';

class OrderDetailsView extends BaseView<OrderDetailsController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return CustomAppBar(title: '${controller.title} Details',elevation: 0);
  }

  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 20,bottom: 16),
      child: Obx((){
        return Column(
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
                                          Text(lorry.contractor?.name ??"Not Assign Yet",
                                              style: TextStyle(fontSize: 15,
                                                  color: lorry.contractor?.name == null
                                                      ? AppColors.gray
                                                      : AppColors.colorDark
                                              )
                                          ),
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
                                            Text('O: ${lorry.quantityLiter}', style: const TextStyle(fontSize: 12, color: AppColors.grayDark, fontWeight: FontWeight.w600)),
                                            const Text(' (Ltr)', style: TextStyle(fontSize: 11, color: AppColors.gray)),
                                          ],
                                        ),
                                        if(lorry.editable! == true)...[
                                          const SizedBox(height: 12),
                                          lorry.quantityReceived == "0.00"
                                              ? ResizeAbleBtn(title: "RECEIVED",textSize: 10,
                                              onClick: () {
                                                DialogHelper.onDefaultButtonSheet(
                                                    bottomSheetBar(lorry.id!),
                                                    dialogHeight: Get.height * 0.33
                                                );
                                              })
                                              : Row(
                                            children: [
                                              Text('R: ${lorry.quantityReceived}', style: const TextStyle(fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.w600)),
                                              const Text(' (Ltr)', style: TextStyle(fontSize: 11, color: AppColors.gray)),
                                            ],
                                          ),
                                        ]
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
            const SizedBox(height: 16),
            if(controller.isAdmin.isFalse
                && (controller.order.status == 'processing'
                    || controller.order.status == 'shipped'
                    || controller.order.status == 'confirmed')
            )...[
              Padding(
                padding: const EdgeInsets.all(8),
                child: DefaultAppBtn(title: 'Complete', onClick: (){controller.confirmOrder('delivered');}),
              ),
            ]
          ],
        );
      })
    );
  }

  @override
  Widget? bottomNavigationBar() {
      return Obx((){
        return controller.isAdmin.value
            ? Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Row(
              children: [
                Expanded(child: DefaultAppBtn(title: 'Cancel',backgroundColor: AppColors.red, onClick: (){controller.confirmOrder('canceled');})),
                const SizedBox(width: 24),
                Expanded(child: DefaultAppBtn(title: 'Confirm', onClick: (){controller.confirmOrder('confirmed');})),
              ],
            )
        ):const SizedBox();
      });
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

  Widget bottomSheetBar(int itemId) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Form(
        key: controller.orderFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Received Quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
            const SizedBox(height: 24),
            DefaultInputFiled(
              txtController:controller.receivedQtyController,
              onChanged:(value){} ,
              validator: (value) {
                if(value!.isEmpty) {return appLocalization.requiredField;}
                else {return null;}
              },
              labelText: 'Received Quantity',
              hintText: 'How many liter received',
              keyboardType: TextInputType.number,
              fontSize: 14,
            ),
            const SizedBox(height: 16),
            DefaultAppBtn(title: 'Submit',
                onClick: (){
                  controller.receivedQuantity(itemId);
                }),
          ],
        ),
      ),
    );
  }


}
