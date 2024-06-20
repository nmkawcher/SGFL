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
      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8,right: 8, bottom: 70),
        child: Column(
          children: [
            Container(
              height: 36,
              margin: const EdgeInsets.only(top: 16, bottom: 8),
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.productList.length,
                itemBuilder: (context, index)=>addProductItemUI(index)
              ),
            ),
            const SizedBox(height: 32),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('PRODUCT SUMMARY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
                Text('Unit : Liter', style: TextStyle(fontSize: 12, color: AppColors.gray)),
              ],
            ),
            const SizedBox(height: 16),
            requisitionSummaryTable(),

          ],
        ),
      );
    });
  }

  Widget addProductItemUI(int index){
    return GestureDetector(
      onTap: (){controller.productList.add(controller.productList[index]);},
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 4, left: 8),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 4),
        decoration: AppColors.defaultDecoration(radius: 16, color: Colors.transparent, bgColor: AppColors.primary.withOpacity(0.2)),
        child: Text(ProductModel.productList[index].productName!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.blueGrey)),
      ),
    );
  }

  @override
  Widget? bottomNavigationBar() {
    return Container(
      height: 240,
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
              Text('Quantity', style: TextStyle(fontSize: 14,color: AppColors.gray)),
              Text('05', style: TextStyle(fontSize: 14,color: AppColors.gray,  fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total Amount', style: TextStyle(fontSize: 14,color: AppColors.gray)),
              Text('${appLocalization.stk} 5000.00', style: const TextStyle(fontSize: 14,color: AppColors.gray,fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          const Divider(color: AppColors.grayLight,thickness: 0.5),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(controller.depotList.first.depotName!, style: const TextStyle(fontSize: 14, color: AppColors.textColor)),
                  const SizedBox(height: 4),
                  Text(controller.depotList.first.depotAddress!, style: const TextStyle(fontSize: 12,color: AppColors.gray)),
                ],
              ),
              AppColors.circleIconBG(AppColors.primary, Icons.location_on_rounded, radius: 16, iconSize: 18)
            ],
          ),
          const SizedBox(height: 24),
          DefaultAppBtn(
              title: appLocalization.submit,
              onClick: () {}
          ),
        ],
      ),
    );
  }

  Widget requisitionSummaryTable(){
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayLight1),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: Get.width,
      child: DataTable(
        columnSpacing: 30,
        dividerThickness: 0.00000000001,
        headingRowHeight: 35,
        dataRowMinHeight: 35.0,
        dataRowMaxHeight: 40.0,
        headingRowColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.20)),
        columns: [
          DataColumn(label: Text('Product', style: AppColors.tableHeaderStyle())),
          DataColumn(label: Flexible(child: Center(child: Text('Unit Price', style: AppColors.tableHeaderStyle())))),
          DataColumn(label: Flexible(child: Center(child: Text('Quantity', style: AppColors.tableHeaderStyle())))),
        ],
        rows:ProductModel.productList.map((index) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(index.productName!, style: const TextStyle(fontSize: 13,color: AppColors.blueGrey, fontWeight: FontWeight.w600))
              ),
              DataCell(Center(child: Text('${index.productPrice}',style: AppColors.tableCallStyle()))),
              DataCell(
                Center(
                  child: InputQty(
                    qtyFormProps: const QtyFormProps(
                        style: TextStyle(fontSize: 18, color: AppColors.colorDark),
                        cursorColor: AppColors.blueGrey,
                        cursorWidth: 1
                    ),
                    decoration: const QtyDecorationProps(
                      border: OutlineInputBorder(borderSide:  BorderSide.none),
                      borderShape: BorderShapeBtn.none,
                      contentPadding: EdgeInsets.all(4),
                      btnColor: AppColors.blueGrey,
                      width: 8,
                      plusBtn: Padding(
                        padding: EdgeInsets.only(right: 2),
                        child: Icon(Icons.add_circle, color: AppColors.blueGrey, size: 24),
                      ),
                      minusBtn: Padding(
                        padding: EdgeInsets.only(left: 2),
                        child: Icon(Icons.remove_circle_rounded, color: Colors.black54, size: 24),
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
            ],
          );
        }).toList(),
      ),
    );
  }


}
