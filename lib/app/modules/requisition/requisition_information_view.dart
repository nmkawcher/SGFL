import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/model/location_model.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import '../../core/widget/custom_btn.dart';
import '../../core/widget/custom_inputField.dart';
import '../../routes/app_pages.dart';
import 'requisition_controller.dart';

class RequisitionInformationView extends BaseView<RequisitionController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.colorWhite),
      title: const Text("Information", style: TextStyle(color: AppColors.colorWhite)),
      centerTitle: true,
      backgroundColor: AppColors.primary,
    );
  }

  @override
  Widget body(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 24),
      child: Column(
        children: [
          DropdownSearch<LocationModel>(
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
                labelText: 'Shipping Address',
                prefixIcon: const Icon(Icons.location_on_rounded, color: AppColors.primary,),
                labelStyle: const TextStyle(fontSize: 16),
                contentPadding: const EdgeInsets.all(18),
              ),
            ),
            validator: (LocationModel? value) => value == null ?  appLocalization.requiredField : null,
            items: LocationModel.locationList,
            itemAsString: (LocationModel location) => location.locationName!,
            onChanged: (value){},
          ),
         const SizedBox(height: 16),
          DefaultInputFiled(
            txtController: controller.notedController,
            labelText: appLocalization.details,
            maxLine: 4,
            onChanged: (String value) {},
            marginBottom: 24,
          ),
          const SizedBox(height: 32),
          DefaultAppBtn(
            title: appLocalization.next,
            textSize:16,
            onClick: () {Get.toNamed(Routes.REQUISITION_Summary);},
          )
        ],
      )
    );
  }

}
