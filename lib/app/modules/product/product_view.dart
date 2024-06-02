import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_btn.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import 'product_controller.dart';

class ProductView extends BaseView<ProductController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.colorWhite),
      title: const Text("Products", style: TextStyle(color: AppColors.colorWhite)),
      centerTitle: true,
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
      child: Column(
        children: [
          TextFormField(
              controller: controller.searchTextController,
              style: const TextStyle(color: AppColors.textColor, fontSize: 18),
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: AppColors.grayLight2,
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(Icons.search, color: AppColors.textColor),
                  ),
                  hintStyle: TextStyle(color: AppColors.textColor, fontSize: 16),
                  contentPadding: EdgeInsets.only(left: 24, top: 18, bottom: 18),
                  hintText: "Search Product",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32)),
                      borderSide: BorderSide.none
                  )
              )
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: Get.height * 0.1),
                itemCount: ProductModel.productList.length,
                itemBuilder: (context, index){
                  return Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child:  ListTile(
                      tileColor: AppColors.pageBackground,
                      focusColor: AppColors.primary.withOpacity(0.2),
                      onTap: () {},
                      title: Text(ProductModel.productList[index].productName!,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textColor),
                      ),
                      subtitle: Row(
                        children: [
                          Text(ProductModel.productList[index].productUnit!,
                            style: const TextStyle(fontSize: 16, color: AppColors.gray),
                          ),
                          const SizedBox(width: 4),
                          Text('${ProductModel.productList[index].productPrice.toString()} ${appLocalization.tk}',
                            style: const TextStyle(fontSize: 14,color: AppColors.primary),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.add_circle, color: AppColors.primary, size: 32),
                    ),
                  );
                }
            ),
          ),
          DefaultAppBtn(
              title: appLocalization.submit,
              onClick: (){Get.toNamed(Routes.REQUISITION_Quantity);}
          )
        ],
      ),
    );
  }


}
