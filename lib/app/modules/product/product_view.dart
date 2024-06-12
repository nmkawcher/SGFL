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
      return GridView.builder(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.5
          ),
          itemCount: controller.productList.length,
          itemBuilder: (context, index)=> productItemUi(controller.productList[index])
      );
    });
  }

  @override
  Widget? bottomNavigationBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DefaultAppBtn(
          title: appLocalization.submit,
          onClick: (){Get.toNamed(Routes.REQUISITION_Information);}
      ),
    );
  }

  Widget productItemUi(ProductModel product) {
    return Obx(() {
      return GestureDetector(
        onTap: (){product.isSelected.value = !product.isSelected.value;},
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: AppColors.grayShed,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(
                    color: product.isSelected.isTrue
                        ? AppColors.orange
                        :Colors.transparent
                )
            ),
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                AppColors.circleIconBG(AppColors.orange, Icons.water_drop_outlined),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(product.productName!, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textColor),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(product.productUnit!, style: const TextStyle(
                            fontSize: 10, color: AppColors.gray)),
                        const SizedBox(width: 4),
                        Text('${product.productPrice.toString()} ${appLocalization
                            .tk}', style: const TextStyle(
                            fontSize: 10, color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            )
        ),
      );
    });
  }
}
