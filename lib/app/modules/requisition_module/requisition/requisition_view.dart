import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_btn.dart';
import '../../../core/widget/custom_inputField.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/requisition_model.dart';
import '/app/core/base/base_view.dart';
import 'requisition_controller.dart';

class RequisitionView extends BaseView<RequisitionController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title: "Requisition");
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 70),
        child: Column(
          children: [
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                 Text('PRODUCT SUMMARY', style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.colorDark)),
                Text('Unit : Liter',
                    style: TextStyle(fontSize: 12, color: AppColors.gray)),
              ],
            ),
            const SizedBox(height: 16),
            requisitionSummaryTable(),
            const SizedBox(height: 24),
            DefaultInputFiled(
              txtController: controller.notedController,
              labelText: 'Note',
              hintText: 'Write your instruction here',
              maxLine: 3,
              fontSize: 14,
              onChanged: (String value) {},
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget? bottomNavigationBar() {
    return null;
  }

  Widget requisitionSummaryTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grayLight1),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: Get.width,
            maxWidth: double.infinity,
          ),
          child: DataTable(
            columnSpacing: 30,
            dividerThickness: 0.00000000001,
            headingRowHeight: 35,
            dataRowMinHeight: 35.0,
            dataRowMaxHeight: 40.0,
            headingRowColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.20)),
            columns: [
              DataColumn(label: Text('Product', style: AppColors.tableHeaderStyle())),
              DataColumn(label: Flexible(child: Center(child: Text('Qty(9000) Ltr', style: AppColors.tableHeaderStyle())))),
              DataColumn(label: Flexible(child: Center(child: Text('Qty(13500) Ltr', style: AppColors.tableHeaderStyle())))),
            ],
            rows: List.generate(controller.productList.length, growable: true , (index){
              return productRow(controller.productList[index]);
            }),
          ),
        ),
      ),
    );
  }

  DataRow productRow(ProductModel product) {
    ProductReq reqProduct = ProductReq();
    reqProduct.productId = product.id;
    controller.productReqList.add(reqProduct);
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(product.name!, style: const TextStyle(fontSize: 12, color: AppColors.blueGrey, fontWeight: FontWeight.w600))),
        quantityCell(9000,reqProduct ),
        quantityCell(13500, reqProduct),
      ],
    );
  }

  DataCell quantityCell(int multiplier, ProductReq reqProduct) {
    return DataCell(
      Center(
        child: InputQty(
          qtyFormProps: const QtyFormProps(
            style: TextStyle(fontSize: 14, color: AppColors.colorDark),
            enableTyping: false
          ),
          decoration: const QtyDecorationProps(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            borderShape: BorderShapeBtn.none,
            contentPadding: EdgeInsets.all(4),
            btnColor: AppColors.blueGrey,
            width: 8,
            plusBtn: Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(
                  Icons.add_circle, color: AppColors.blueGrey, size: 20),
            ),
            minusBtn: Padding(
              padding: EdgeInsets.only(left: 2),
              child: Icon(
                  Icons.remove_circle_rounded, color: Colors.black54, size: 20),
            ),
          ),
          maxVal: 99999999,
          initVal: 0,
          minVal: 0,
          steps: multiplier,
          onQtyChanged: (val) {
            if (multiplier == 9000) {
              reqProduct.baseQuantity = val.toInt();
            } else {
              reqProduct.upperQuantity = val.toInt();
            }
          },
        ),
      ),
    );
  }
}