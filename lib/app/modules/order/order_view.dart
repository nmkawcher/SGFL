import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sgfl_sales/app/data/model/contractor_model.dart';
import 'package:sgfl_sales/app/data/model/driver_mode.dart';
import 'package:sgfl_sales/app/data/model/lorry_model.dart';
import 'package:sgfl_sales/app/data/model/order_model.dart';
import '../../core/utils/dialog_helper.dart';
import '../../core/widget/custom_btn.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import 'order_controller.dart';

class OrderView extends BaseView<OrderController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
        title: Text(controller.title, style: const TextStyle(fontSize: 20, color: AppColors.colorDark, fontWeight: FontWeight.w500)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.colorGrayBG,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight - 8.0),
          child: Container(
            height: 40,
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.10),
              borderRadius: BorderRadius.circular(32),
            ),
            child: TabBar(
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              controller: controller.tabController,
              tabs: controller.tabs,
              unselectedLabelColor: AppColors.primary,
              labelColor: AppColors.colorWhite,
              indicatorWeight: 0,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(80.0),
                color: AppColors.primary,
              ),
            ),
          ),
        ),
    );
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      return TabBarView(
        controller: controller.tabController,
        children: controller.isContractor.value
            ? controller.tabs.map((tab) => buildContractorList(controller.getContractorOrderList(tab.text!.toLowerCase()))).toList()
            : controller.tabs.map((tab) => buildOrderList(controller.getOrderList(tab.text!.toLowerCase()))).toList(),
      );
    });
  }

  Widget buildOrderList(List<Order> orderList) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.orderLists[controller.requestStatus.value]!.clear();
        controller.fetchOrderData(controller.requestStatus.value);
      },
      child: ListView.separated(
        itemCount: orderList.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
        itemBuilder: (BuildContext context, int index) {
          return orderItemUI(orderList[index]);
        },
      ),
    );
  }
  Widget orderItemUI(Order order) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: (){controller.gotoOrderDetails(order);},
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children:[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(order.orderNo ?? "", style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    const SizedBox(height: 2),
                    Text(order.customer?.name??'', style: const TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.normal)),
                    Text(order.dipo?.name??'',  style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                    Container(
                        margin: const EdgeInsets.only(top: 4),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.orange.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:  Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${order.quantityLiter} (Ltr)', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.grayDark)),
                            Text(' / ৳ ${order.totalAmount ?? 0.00}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.gray)),
                          ],
                        )
                    )
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(order.status?.toUpperCase()??'', style: const TextStyle(fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 2),
                  Text('${order.date}', style: const TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.w400)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContractorList(List<ContractorOrder> orderList) {
    return RefreshIndicator(
      onRefresh: () async {
        controller.contractorOrderLists[controller.requestStatus.value]!.clear();
        controller.fetchOrderData(controller.requestStatus.value);
      },
      child: ListView.separated(
        itemCount: orderList.length,
        padding: const EdgeInsets.all(8),
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
        itemBuilder: (BuildContext context, int index) {
          return contractorItemUI(orderList[index]);
        },
      ),
    );
  }
  Widget contractorItemUI(ContractorOrder order) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: (){
          controller.lorryList.clear();
          controller.driverList.clear();
          controller.selectedOrderID.value = order.id!;
          if(controller.requestStatus.value =="pending" && order.lorry?.regNo == null){
            controller.contractorDataLoad();
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(order.challanNo ?? "", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary)),
                        const SizedBox(width: 4),
                        Text('${order.date}', style: const TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.w400)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(order.order?.customer?.name??'', style: const TextStyle(fontSize: 13, color: AppColors.gray, fontWeight: FontWeight.normal)),
                    Text(order.order?.dipo?.name??'',  style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                    textWrap2('Truck No', order.lorry?.regNo ??""),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Text('${order.quantityLiter}', style: const TextStyle(fontSize: 12, color: AppColors.orange, fontWeight: FontWeight.w600)),
                      const Text(' (Ltr)', style: TextStyle(fontSize: 11, color: AppColors.gray)),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(order.product??'', style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textWrap2(String title, String text){
   return Row(
      children: [
        Text('$title: ', style: const TextStyle(fontSize: 13,color: AppColors.blueGrey)),
        Text(text , style: const TextStyle(fontSize: 13,color: Colors.black)),
      ],
    );
  }
  Widget bottomSheetBar(int itemId) {
    return Container(
      margin: const EdgeInsets.only(top: 40, left: 16, right: 16),
      child: Form(
        key: controller.orderDetailsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lorry Assign', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.colorDark)),
            const SizedBox(height: 24),
            DropdownSearch<LorryModel>(
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
                  labelText: 'Lorry',
                  prefixIcon: const Icon(Icons.directions_bus_filled_rounded, color: AppColors.primary,),
                  labelStyle: const TextStyle(fontSize: 18),
                  contentPadding: const EdgeInsets.all(18),
                ),
              ),
              validator: (LorryModel? value) => value == null ?  appLocalization.requiredField : null,
              items: controller.lorryList,
              itemAsString: (LorryModel lorry) => lorry.regNo!,
              onChanged: (value){
                controller.selectedLorry.value = value!.id!;
              },
            ),
            const SizedBox(height: 8),
            DropdownSearch<DriverModel>(
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
                  labelText: 'Driver',
                  prefixIcon: const Icon(Icons.person, color: AppColors.primary,),
                  labelStyle: const TextStyle(fontSize: 18),
                  contentPadding: const EdgeInsets.all(18),
                ),
              ),
              validator: (DriverModel? value) => value == null ?  appLocalization.requiredField : null,
              items: controller.driverList,
              itemAsString: (DriverModel driver) => driver.name!,
              onChanged: (value){
                controller.selectedDriver.value = value!.id!;
              },
            ),
            const SizedBox(height: 32),
            DefaultAppBtn(title: 'Submit', onClick: (){controller.saveLorryAssign(itemId);}),
          ],
        ),
      ),
    );
  }


}
