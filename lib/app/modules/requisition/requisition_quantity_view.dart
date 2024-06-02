import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/core/widget/custom_btn.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import '../../core/values/app_colors.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import 'requisition_controller.dart';

class RequisitionQuantityView extends BaseView<RequisitionController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.colorWhite),
      title: const Text("Requisition", style: TextStyle(color: AppColors.colorWhite)),
      centerTitle: true,
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         Expanded(
             child: ListView.builder(
               padding: EdgeInsets.only(bottom: Get.height * 0.1),
                itemCount: ProductModel.productList.length,
                 itemBuilder: (context, index) => requisitionItemUI1(index),
             )
         ),
         DefaultAppBtn(title: 'Next', onClick: (){
           Get.toNamed(Routes.REQUISITION_Information);
         })
        ],
      )
    );
  }

  Widget requisitionItemUI1(int index) {
    return Card(
               elevation: 2,
               clipBehavior: Clip.antiAliasWithSaveLayer,
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
               child: Stack(
                 clipBehavior: Clip.none,
                 children: [
                   ListTile(
                       tileColor: AppColors.pageBackground,
                       focusColor: AppColors.Yellow.withOpacity(0.2),
                       onTap: () {},
                       title: Text(ProductModel.productList[index].productName!,
                         style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColor),
                       ),
                       subtitle: Row(
                         children: [
                           Text(ProductModel.productList[index].productUnit!,
                             style: const TextStyle(fontSize: 14, color: AppColors.gray),
                           ),
                           const SizedBox(width: 4),
                           Text('${ProductModel.productList[index].productPrice.toString()} ${appLocalization.tk}',
                             style: const TextStyle(fontSize: 14,color: AppColors.primary),
                           ),
                         ],
                       ),
                       trailing: SizedBox(
                         width: 100,height: 40,
                         child: TextFormField(
                             maxLength: 8,
                             textAlign: TextAlign.center,
                             keyboardType: TextInputType.number,
                             textAlignVertical: TextAlignVertical.center,
                             style: const TextStyle(color: AppColors.textColor, fontSize: 16),
                             decoration: const InputDecoration(
                                 counterText: '',
                                 filled: true,
                                 isDense: true,
                                 hintText:"Quantity",
                                 hintStyle: TextStyle(color: AppColors.textColor, fontSize: 14),
                                 border: OutlineInputBorder(
                                   borderSide: BorderSide.none,
                                   borderRadius: BorderRadius.all(Radius.circular(8)),
                                 )
                             )
                         ),
                       )
                   ),
                   Positioned(
                     right: 2, top: 2,
                     child: GestureDetector(onTap: (){},
                         child: const Icon(Icons.cancel_rounded,color: AppColors.gray58, size: 18)
                     )
                   )
                 ],
               ),
             );
  }

  Widget requisitionItemUI2(int index) {
    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppColors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListTile(
                tileColor: AppColors.pageBackground,
                focusColor: AppColors.Yellow.withOpacity(0.2),
                onTap: () {},
                title: Text(ProductModel.productList[index].productName!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColor),
                ),
                subtitle: Row(
                  children: [
                    Text(ProductModel.productList[index].productUnit!,
                      style: const TextStyle(fontSize: 14, color: AppColors.gray),
                    ),
                    const SizedBox(width: 4),
                    Text('${ProductModel.productList[index].productPrice.toString()} ${appLocalization.tk}',
                      style: const TextStyle(fontSize: 14,color: AppColors.primary),
                    ),
                  ],
                ),
                trailing: SizedBox(
                  width: 100,height: 40,
                  child: TextFormField(
                      maxLength: 8,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textAlignVertical: TextAlignVertical.center,
                      style: const TextStyle(color: AppColors.textColor, fontSize: 16),
                      decoration: const InputDecoration(
                          counterText: '',
                          filled: true,
                          isDense: true,
                          hintText:"Quantity",
                          hintStyle: TextStyle(color: AppColors.textColor, fontSize: 14),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          )
                      )
                  ),
                )
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8, left: 8),
            color: AppColors.red,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.delete,color: AppColors.pageBackground, size: 24),
            ),
          )
        ],
      ),
    );
  }

}
