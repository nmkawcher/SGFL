import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_btn.dart';
import '/app/core/base/base_view.dart';
import 'requisition_controller.dart';

class RequisitionSummaryView extends BaseView<RequisitionController> {

  var txt = "Lorem Ipsum is simply dummy text of the printing and typesetting industry."
      " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,"
      " when an unknown printer took a galley of type and scrambled it to make a type specimen book."
      " It has survived not only five centuries";

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.colorWhite),
      title: const Text("Summary", style: TextStyle(color: AppColors.colorWhite)),
      centerTitle: true,
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 24),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: Get.height * 0.1),
              children:  [
                requisitionSummaryTable(),
                Container(
                  height: 40,
                  margin: const EdgeInsets.only(top: 8),
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.grayLight),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('# Total Price', style: TextStyle(fontSize: 14, color: AppColors.gray)),
                      Text('120000 Tk.', style: TextStyle(fontSize: 14, color: AppColors.textColor)),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.only(left: 8, right: 8, top:4, bottom: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary.withOpacity(0.25)),
                  ),
                  child: Column(
                    children: [
                      const ListTile(
                        dense: true,
                        visualDensity: VisualDensity.compact,
                        contentPadding: EdgeInsets.zero,
                        trailing: Icon(Icons.location_on_rounded, color: AppColors.primary, size: 24),
                        title: Text('Shipping Address', style: TextStyle(fontSize: 12, color: AppColors.gray)),
                        subtitle: Text('Sarulia, Demra Dhaka', style: TextStyle(fontSize: 14,color: AppColors.textColor)),
                      ),
                      const Divider(color: AppColors.grayLight,thickness: 0.5),
                      Text(txt, textAlign: TextAlign.start, style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DefaultAppBtn(title: appLocalization.submit, onClick: (){})
        ],
      )
    );
  }

  Widget requisitionSummaryTable(){
    return SizedBox(
      width: Get.width,
      child: DataTable(
        columnSpacing: 16,
        dividerThickness: 1,
        headingRowHeight: 40,
        decoration: BoxDecoration(border: Border.all(color: AppColors.grayLight)),
        columns:  const [
          DataColumn(label: Text('#', style: TextStyle(fontWeight: FontWeight.w500, fontSize:13 , color: AppColors.gray),),),
          DataColumn(label: Text('Product', style: TextStyle(fontWeight: FontWeight.w500, fontSize:13, color: AppColors.gray),),),
          DataColumn(label: Text('Unit', style: TextStyle(fontWeight: FontWeight.w500, fontSize:13, color: AppColors.gray),),),
          DataColumn(label: Text('Quantity', style: TextStyle(fontWeight: FontWeight.w500, fontSize:13, color: AppColors.gray ),),),
          DataColumn(label: Text('Price', style: TextStyle(fontWeight: FontWeight.w500, fontSize:13, color: AppColors.gray ),),),
        ],
        rows:ProductModel.productList.map((index) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text('${ProductModel.productList.indexOf(index)+1}',style: const TextStyle(fontSize:12),)),
              DataCell(Text(index.productName!,style: const TextStyle(fontSize:12))),
              DataCell(Text(index.productUnit!,style: const TextStyle(fontSize:12))),
              DataCell(Align(alignment: Alignment.center,
                  child: Text(index.productQuantity.toString(),style: const TextStyle(fontSize:12)))
              ),
              DataCell(Text('${index.productPrice}',style: const TextStyle(fontSize:12))),
            ],
          );
        }).toList(),
      ),
    );
  }


}
