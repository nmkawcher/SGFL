import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/contractor_model.dart';
import 'package:sgfl_sales/app/data/model/unassign_model.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_app_bar.dart';
import '../../core/widget/custom_btn.dart';
import '/app/core/base/base_view.dart';
import 'assign_controller.dart';

class AssignView extends BaseView<AssignController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title:"Assign Contractor");
  }

  @override
  Widget body(BuildContext context) {
    return Obx((){
      return RefreshIndicator(
        onRefresh: () async {controller.loadInitialData();},
        child: ListView.builder(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
            shrinkWrap: true,
            itemCount: controller.unassignedList.length,
            itemBuilder: (context, index)=> itemUi(controller.unassignedList[index])
        ),
      );
    });
  }

  Widget itemUi(UnassignedModel product) {
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
              controller.selectedUnassign.add(product);
            } else {
              controller.selectedUnassign.remove(product);
            }
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.challanNo ?? "", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary)),
                      const SizedBox(height: 2),
                      Text(product.order?.customer?.name??'', style: const TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.normal)),
                      Text(product.order?.dipo?.name??'',  style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                      Text('${product.date}', style: const TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text('${product.quantityLiter}', style: const TextStyle(fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.w600)),
                        const Text(' (Ltr)', style: TextStyle(fontSize: 11, color: AppColors.gray)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(product.product??'', style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  @override
  Widget? bottomNavigationBar() {
    return Obx((){
      return controller.selectedUnassign.isEmpty
        ? const SizedBox()
        : Container(
          color: const Color(0xFFFAF9F9),
          height: 200,
          padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
          child: Form(
            key: controller.assignFormKey,
            child: Column(
              children: [
                DropdownSearch<Contractor>(
                  popupProps: PopupProps.menu(
                    constraints:  const BoxConstraints.tightFor(height:250),
                    containerBuilder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.all(16),
                        child: child,
                      );
                    },
                    menuProps: MenuProps(
                        clipBehavior: Clip.antiAlias,
                        elevation: 8,
                        borderRadius: BorderRadius.circular(16)
                    ),
                  ),
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    baseStyle: const TextStyle(fontSize: 14),
                    dropdownSearchDecoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                      labelText: 'Contractor',
                      prefixIcon: const Icon(Icons.person, color: AppColors.primary,),
                      labelStyle: const TextStyle(fontSize: 18),
                      contentPadding: const EdgeInsets.all(18),
                    ),
                  ),
                  validator: (Contractor? value) => value == null ?  appLocalization.requiredField : null,
                  items: controller.contractorList,
                  itemAsString: (Contractor person) => person.name!,
                  onChanged: (value){
                    controller.selectedContractor.value = value!.id!;
                  },
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: DefaultAppBtn(
                      title: "Assign Contractor",
                      onClick: (){
                        controller.saveAssign();
                      }
                  ),
                ),
              ],
            ),
          ),
        );
    });
  }


}
