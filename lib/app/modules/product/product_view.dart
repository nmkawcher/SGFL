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
  ProductView(){
    controller.loadInitialData();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title:"Select Products");
  }

  @override
  Widget body(BuildContext context) {
    return Obx((){
      return RefreshIndicator(
        onRefresh: () async {controller.fetchProductData();},
        child: GridView.builder(
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
        ),
      );
    });
  }

  @override
  Widget? bottomNavigationBar() {
    return Obx((){
      return Padding(
        padding: const EdgeInsets.all(16),
        child: controller.selectedProduct.isEmpty ? null : DefaultAppBtn(
            title: appLocalization.next,
            onClick: (){
              Get.toNamed(Routes.REQUISITION,
                arguments: [
                  Get.arguments,
                  controller.selectedProduct,
                ]
              );
            }
        ),
      );
    });
  }

  Widget productItemUi(ProductModel product) {
    return Obx((){
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: product.isSelected.isTrue ? 3 : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: product.isSelected.isTrue ? AppColors.orange : Colors.transparent,
                width: 1
            )
        ),
        child: InkWell(
          onTap: (){
            product.isSelected.value = !product.isSelected.value;
            if(product.isSelected.isTrue) {
              controller.selectedProduct.add(product);
            } else {
              controller.selectedProduct.remove(product);
            }
          },
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  AppColors.circleIconBG(AppColors.orange, Icons.water_drop_outlined, radius: 14),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(product.name!, overflow: TextOverflow.visible,
                          style: const TextStyle(fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textColor),
                        ),
                        Text('Price ${appLocalization.stk} ${product.priceLiter}', style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 10, color: AppColors.primary),
                        )
                      ],
                    ),
                  ),
                ],
              )
          ),
        ),
      );
    });
  }
}
