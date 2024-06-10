import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:sgfl_sales/app/core/widget/custom_btn.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import 'requisition_controller.dart';

class RequisitionQuantityView extends BaseView<RequisitionController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title:"Requisition");
  }

  @override
  Widget body(BuildContext context) {
    return Obx((){
      return Column(
        children: [
          Container(
            height: 36,
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.productList.length,
              itemBuilder: (context, index)=>addProductItemUI(index)
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding:const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
              itemCount: controller.productList.length,
              itemBuilder: (context, index) => requisitionItemUI(index),
            ),
          ),
        ],
      );
    });
  }

  Widget requisitionItemUI(int index) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {},
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        decoration: AppColors.defaultDecoration(radius: 8,color: AppColors.red,bgColor: AppColors.red),
        child: const Icon(Icons.delete, color: AppColors.colorWhite),
      ),

      child: Container(
        decoration: AppColors.defaultDecoration(radius: 8),
        margin: const EdgeInsets.only(bottom: 8),
        child: ListTile(
            tileColor: AppColors.pageBackground,
            focusColor: AppColors.Yellow.withOpacity(0.2),
            title: Text(ProductModel.productList[index].productName!,
              style: const TextStyle(fontSize: 16, color: AppColors.textColor),
            ),
            subtitle: Row(
              children: [
                Text(ProductModel.productList[index].productUnit!,
                  style: const TextStyle(fontSize: 12, color: AppColors.gray),
                ),
                const SizedBox(width: 4),
                Text('${ProductModel.productList[index].productPrice.toString()} ${appLocalization.tk}',
                  style: const TextStyle(fontSize: 12,color: AppColors.primary),
                ),
              ],
            ),
            leading: AppColors.circleIconBG(AppColors.primary, Icons.water_drop),
            trailing: InputQty(
              qtyFormProps: const QtyFormProps(
                style: TextStyle(fontSize: 18, color: AppColors.colorWhite),
                cursorColor: AppColors.colorWhite,
                cursorWidth: 1
              ),
              decoration: const QtyDecorationProps(
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                borderShape: BorderShapeBtn.none,
                fillColor: AppColors.colorDark,
                contentPadding: EdgeInsets.all(4),
                btnColor: AppColors.colorWhite,
                width: 8,
                plusBtn: Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Icon(Icons.add_circle, color: AppColors.colorWhite, size: 24),
                ),
                minusBtn: Padding(
                  padding: EdgeInsets.only(left: 2),
                  child: Icon(Icons.remove_circle_rounded, color: Colors.white12, size: 24),
                ),
              ),
              maxVal: 99999,
              initVal: 1,
              minVal: 1,
              steps: 0.5,
              onQtyChanged: (val) {},
            ),
        ),
      ),
    );
  }

  Widget addProductItemUI(int index){
    return GestureDetector(
      onTap: (){controller.productList.add(controller.productList[index]);},
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 8, left: 8),
        padding: const EdgeInsets.all(8),
        decoration: AppColors.defaultDecoration(radius: 32,color: AppColors.primary, bgColor: AppColors.primary),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Icon(Icons.add, color: AppColors.colorWhite, size: 16),
            const SizedBox(width: 4),
            Text(ProductModel.productList[index].productName!, style: const TextStyle(fontSize: 16,color: AppColors.colorWhite)),
          ],
        ),
      ),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return Container(
      height: 256,
      padding: const EdgeInsets.all(16),
      decoration:  BoxDecoration(
        color: AppColors.colorWhite,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32)
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.colorDark.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 16,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const Divider(color: AppColors.grayLight,thickness: 0.5),
          const Text('Depot Address', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.depotList.first.depotName!, style: const TextStyle(fontSize: 14, color: AppColors.textColor)),
                  Text(controller.depotList.first.depotAddress!, style: const TextStyle(fontSize: 13,color: AppColors.gray)),
                ],
              ),
              AppColors.circleIconBG(AppColors.primary, Icons.location_on_rounded)
            ],
          ),
          const SizedBox(height: 24),
          DefaultAppBtn(
              title: appLocalization.next,
              onClick: () {Get.toNamed(Routes.HOME_Customer);}
          ),
        ],
      ),
    );
  }


}
