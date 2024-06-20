import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../core/widget/step_widget.dart';
import '../../data/model/product_model.dart';
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
        crossAxisAlignment: CrossAxisAlignment.end,
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
                  const Text('Padma Oil Company LTD.', style: TextStyle(fontSize: 15, color: AppColors.colorDark)),
                  const SizedBox(height: 4),
                  textWrap2('Contact Person', 'Mr. Abul Khayer'),
                  textWrap2('Address', 'Bagabri, Sylhet'),
                  textWrap2('Phone', '01689936665'),
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
                  const Text('Requisition ID #2345435', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
                  const SizedBox(height: 4),
                  textWrap2('Date', '12 JUN 2024'),
                  textWrap2('Shipping', 'Bagabri, Sylhet'),
                  const SizedBox(height: 4),
                  textWrap('Note', 'Padma Oil Company LTD, Bagabri, Sylhet, Requisition ID: 2345435,Date: 12 JUN 2024'),
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
                  const Text('Contractor Info', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
                  const SizedBox(height: 8),
                  const Text('M/S Tanisa Enterprise', style: TextStyle(fontSize: 15, color: AppColors.colorDark)),
                  const SizedBox(height: 4),
                  textWrap2('Driver', 'Mr. Abul Khayer'),
                  textWrap2('Address', 'Bagabri, Sylhet'),
                  textWrap2('Lorry Number', 'Dhaka Metro L-250255'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('PRODUCT SUMMARY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
              Text('Unit : Liter', style: TextStyle(fontSize: 12, color: AppColors.gray)),
            ],
          ),
          const SizedBox(height: 8),
          orderSummaryTable(),

        ],
      ),
    );
  }

  Widget orderStatusBarUI() {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: AppColors.defaultDecoration(color: AppColors.grayLight1),
      child: SizedBox(height: 80, child: StepWidget(step: 1)),
    );
  }

  Widget orderSummaryTable(){
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
        headingRowHeight: 30,
        dataRowMinHeight: 30.0,
        dataRowMaxHeight: 35.0,
        headingRowColor: WidgetStateProperty.all(AppColors.primary.withOpacity(0.20)),
        columns: [
          DataColumn(label: Text('Product', style: AppColors.tableHeaderStyle())),
          DataColumn(label: Flexible(child: Center(child: Text('Unit Price', style: AppColors.tableHeaderStyle())))),
          DataColumn(label: Flexible(child: Center(child: Text('Quantity', style: AppColors.tableHeaderStyle())))),
        ],
        rows:ProductModel.productList.map((index) {
          return DataRow(
            cells: <DataCell>[
              DataCell(Text(index.productName!,
                  style: const TextStyle(fontSize: 12,color: AppColors.blueGrey, fontWeight: FontWeight.w600))
              ),
              DataCell(Center(child: Text('${index.productPrice}',style: AppColors.tableCallStyle()))),
              DataCell(Center(child: Text(index.productQuantity.toString(),style: AppColors.tableCallStyle()))
              ),
            ],
          );
        }).toList(),
      ),
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
            child: Text(text, overflow: TextOverflow.visible, style: const TextStyle(fontSize: 13, color: AppColors.gray))),
      ],
    );
  }

  Widget textWrap2(String title, String text){
    return  Table(
      columnWidths:const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(4),
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
