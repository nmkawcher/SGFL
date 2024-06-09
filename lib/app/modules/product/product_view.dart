import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/product_model.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../core/widget/custom_btn.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import 'product_controller.dart';

class ProductView extends BaseView<ProductController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title:"Products");
  }

  @override
  Widget body(BuildContext context) {
    return Obx((){
      return Container(
        margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 70
                  ),
                  itemCount: controller.productList.length,
                  itemBuilder: (context, index)=> productItemUi(controller.productList[index])
              ),
            ),
            DefaultAppBtn(
                title: appLocalization.submit,
                onClick: (){Get.toNamed(Routes.REQUISITION_Quantity);}
            )
          ],
        ),
      );
    });
  }

  Widget productItemUi(ProductModel product) {
    return Obx((){
      var selectValue = product.isSelect ?? false.obs;
      return Container(
        decoration: BoxDecoration(
           color: selectValue.isFalse ? AppColors.primary.withOpacity(0.2) : AppColors.pageBackground,
            borderRadius: BorderRadius.circular(4)
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        child: ListTile(
          onTap: () {
            product.isSelect?.value = !selectValue.value;

          },
          tileColor: AppColors.pageBackground,
          focusColor: AppColors.primary.withOpacity(0.2),
          leading: AppColors.circleIconBG(AppColors.orange, Icons.water_drop_outlined),
          title: Text(product.productName!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.textColor),
          ),
          subtitle: Row(
            children: [
              Text(product.productUnit!, style: const TextStyle(fontSize: 10, color: AppColors.gray)),
              const SizedBox(width: 4),
              Text('${product.productPrice.toString()} ${appLocalization.tk}', style: const TextStyle(fontSize: 10,color: AppColors.primary),
              ),
            ],
          ),
        ),
      );
    });

  }

}
