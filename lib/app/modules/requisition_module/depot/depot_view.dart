import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:input_quantity/input_quantity.dart';
import '../../../core/utils/util.dart';
import '../../../core/values/app_colors.dart';
import '../../../core/widget/custom_app_bar.dart';
import '../../../core/widget/custom_bottom_sheet_plus.dart';
import '../../../core/widget/custom_btn.dart';
import '../../../core/widget/custom_inputField.dart';
import '../../../data/model/depot_model.dart';
import '../../../data/model/product_model.dart';
import '../../../data/model/requisition_model.dart';
import '../../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import 'depot_controller.dart';

class DepotView extends BaseView<DepotController> {
  DepotView() {
    controller.fetchDepotData();
    controller.loadInitialData();
  }

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return const CustomAppBar(title: "Place Your Requisition",backgroundColor: AppColors.colorWhite,);
  }

  @override
  Widget body(BuildContext context) {
    return Obx(() {
      return RefreshIndicator(
        onRefresh: () async {
          controller.fetchDepotData();
        },
        child: ListView.builder(
            itemCount: controller.depotList.length,
            padding: EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Visibility(
                    visible: controller.isUserAdmin.value,
                    child: ListTile(
                      horizontalTitleGap: 0,
                      leading: const SizedBox(
                        height: double.infinity,
                        child: Icon(Icons.account_balance_rounded,
                            color: AppColors.blueGrey, size: 24),
                      ),
                      title: Text(controller.depotList[index].name!,
                          style: const TextStyle(
                              fontSize: 16, color: AppColors.blueGrey)),
                      subtitle: Text(controller.depotList[index].address!,
                          style: const TextStyle(
                              fontSize: 12, color: AppColors.blueGrey)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DepotDropdown(controller: controller, index: index),
                  // Obx((){
                  //   return InkWell(
                  //     onTap: () {
                  //       CustomBottomSheetPlus(
                  //           bgColor: AppColors.getGreyColor().withOpacity(.2),
                  //           isNeedPadding: false,
                  //           child: StatefulBuilder(builder: (context, setState) {
                  //             return Container(
                  //               height: MediaQuery.of(context).size.height * .9,
                  //               padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  //               decoration: BoxDecoration(
                  //                 color: AppColors.colorWhite,
                  //                 borderRadius: const BorderRadius.only(
                  //                   topLeft: Radius.circular(20),
                  //                   topRight: Radius.circular(20),
                  //                 ),
                  //                 boxShadow: MyUtils.getShadow(),
                  //               ),
                  //               child: ListView.builder(
                  //                   shrinkWrap: true,
                  //                   physics: const ClampingScrollPhysics(),
                  //                   padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  //                   itemCount: controller.depotList[index].depotZone?.length,
                  //                   itemBuilder: (context, subIndex) {
                  //                     DepotZone depot = controller.depotList[index].depotZone![subIndex];
                  //                     return depotItem(index, subIndex,depot);
                  //                   }
                  //               ),
                  //             );
                  //           })).show(context);
                  //     },
                  //     child: Container(
                  //       padding: const EdgeInsets.only(
                  //           left: 8, right: 8, top: 10, bottom: 10),
                  //       decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(8),
                  //         color: AppColors.colorWhite
                  //       ),
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [
                  //           const Icon(Icons.location_on_rounded,
                  //               color: AppColors.primary, size: 18),
                  //           const SizedBox(width: 8),
                  //           Text(
                  //               controller.selectedDepotZone.value.name ??
                  //                   "Select a Depo",
                  //               overflow: TextOverflow.ellipsis,
                  //               style: const TextStyle(fontSize: 16)),
                  //           const Spacer(),
                  //           const Icon(
                  //             Icons.arrow_drop_down_sharp,
                  //             size: 18,
                  //             color: Colors.black,
                  //           )
                  //         ],
                  //       ),
                  //     ),
                  //   );
                  // }),
                  // GridView.builder(
                  //     padding: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 24),
                  //     shrinkWrap: true,
                  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2,
                  //         crossAxisSpacing: 8,
                  //         mainAxisSpacing: 8,
                  //         childAspectRatio: 2.5
                  //     ),
                  //     itemCount: controller.productList.length,
                  //     itemBuilder: (context, index)=> productItemUi(controller.productList[index])
                  // ),
                  // const SizedBox(height: 16),
                  // const Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Text('PRODUCT SUMMARY', style: TextStyle(fontSize: 16,
                  //         fontWeight: FontWeight.w600,
                  //         color: AppColors.colorDark)),
                  //     Text('Unit : Liter',
                  //         style: TextStyle(fontSize: 12, color: AppColors.gray)),
                  //   ],
                  // ),
                  const SizedBox(height: 16),
                  requisitionSummaryTable(),
                  const SizedBox(height: 16),
                  DefaultInputFiled(
                    txtController: controller.notedController,
                    labelText: 'Note',
                    hintText: 'Write your instruction here',
                    maxLine: 3,
                    fontSize: 14,
                    onChanged: (String value) {},
                  ),
                  const SizedBox(height: 16),
                  Obx((){
                    bool isDepoSelected = controller.selectedDepotZone.value.id != null;
                    return DefaultAppBtn(title: appLocalization.submit,
                        onClick: () {
                      print("----------- click ${isDepoSelected}");
                          if(!isDepoSelected){
                            showErrorSnackBar("Please Select an Depo");
                            return;
                          }
                          controller.creteRequisition();
                        }
                    );
                    // return Container(
                    //   height:isDepoSelected ? 180 : 100,
                    //   padding: const EdgeInsets.all(16),
                    //   decoration: BoxDecoration(
                    //     color: AppColors.colorWhite,
                    //     borderRadius: const BorderRadius.only(
                    //         topLeft: Radius.circular(32),
                    //         topRight: Radius.circular(32)
                    //     ),
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: AppColors.colorDark.withOpacity(0.2),
                    //         spreadRadius: 1,
                    //         blurRadius: 16,
                    //         offset: const Offset(0, 1), // changes position of shadow
                    //       ),
                    //     ],
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Visibility(
                    //           visible: isDepoSelected,
                    //           child: const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                    //       const SizedBox(height: 8),
                    //       Visibility(
                    //         visible: controller.selectedDepotZone.value.id != null && controller.selectedDepotZone.value.id.toString().isNotEmpty,
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.center,
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(controller.selectedDepotZone.value.name ?? "", style: const TextStyle(fontSize: 14, color: AppColors.textColor)),
                    //                 const SizedBox(height: 4),
                    //                 Text(controller.selectedDepotZone.value.address ?? "", style: const TextStyle(fontSize: 12, color: AppColors.gray)),
                    //               ],
                    //             ),
                    //             AppColors.circleIconBG(AppColors.primary, Icons.location_on_rounded, radius: 16, iconSize: 18)
                    //           ],
                    //         ),
                    //       ),
                    //       SizedBox(height: isDepoSelected? 24:0),
                    //
                    //     ],
                    //   ),
                    // );
                  })
                ],
              );
            }),
      );
    });
  }

  @override
  Widget? bottomNavigationBar() {
    return  null;
  }


  //product
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

  // depo
  Widget depotItem(int index, int subIndex,DepotZone depot) {


    return Obx(() {
      var isSelected = controller.selectedDepot.value == depot.id;
      return Card(
        clipBehavior: Clip.antiAlias,
        elevation: isSelected ? 3 : 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
                color: isSelected ? AppColors.orange : Colors.transparent,
                width: 1)),
        child: InkWell(
          onTap: () {
            controller.selectedDepot.value = depot.id ?? 0;
            controller.selectedDepotZone.value = depot;
            Get.back();
          },
          child: Container(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.location_on_rounded,
                    color: AppColors.primary, size: 24),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(depot.name!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 4),
                    Text('${depot.address} ${depot.postcode}',
                        style: const TextStyle(
                            fontSize: 12, color: AppColors.gray)),
                  ],
                ),
                const Spacer(),
                Icon(
                    isSelected
                        ? Icons.check_circle_rounded
                        : Icons.circle_outlined,
                    color: isSelected ? AppColors.orange : AppColors.grayLight1,
                    size: 20),
              ],
            ),
          ),
        ),
      );
    });
  }


  //requisition
  Widget requisitionSummaryTable() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      width: Get.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: Get.width,
            maxWidth: double.infinity,
          ),
          child: DataTable(
            columnSpacing: 30,
            dividerThickness: 0.00000000001,
            headingRowHeight: 35,
            dataRowMinHeight: 35.0,
            dataRowMaxHeight: 40.0,
            headingRowColor: WidgetStateProperty.all(AppColors.bgColor2),
            columns: [
              DataColumn(label: Text('Product', style: AppColors.tableHeaderStyle())),
              DataColumn(label: Flexible(child: Center(child: Text('Qty(9000) Ltr', style: AppColors.tableHeaderStyle())))),
              DataColumn(label: Flexible(child: Center(child: Text('Qty(13500) Ltr', style: AppColors.tableHeaderStyle())))),
            ],
            rows: List.generate(controller.productList.length, growable: true , (index){
              return productRow(controller.productList[index]);
            }),
          ),
        ),
      ),
    );
  }

  DataRow productRow(ProductModel product) {
    ProductReq reqProduct = ProductReq();
    reqProduct.productId = product.id;
    controller.productReqList.add(reqProduct);
    return DataRow(
      cells: <DataCell>[
        DataCell(Text(product.name!, style: const TextStyle(fontSize: 12, color: AppColors.tileColor, fontWeight: FontWeight.w600))),
        quantityCell(9000,reqProduct ),
        quantityCell(13500, reqProduct),
      ],
    );
  }

  DataCell quantityCell(int multiplier, ProductReq reqProduct) {
    return DataCell(
      Center(
        child: InputQty(
          qtyFormProps: const QtyFormProps(
              style: TextStyle(fontSize: 14, color: AppColors.colorDark),
              enableTyping: false
          ),
          decoration: const QtyDecorationProps(
            border: OutlineInputBorder(borderSide: BorderSide.none),
            borderShape: BorderShapeBtn.none,
            contentPadding: EdgeInsets.all(4),
            btnColor: AppColors.primary,
            width: 8,
            plusBtn: Padding(
              padding: EdgeInsets.only(right: 2),
              child: Icon(
                  Icons.add_circle, color: AppColors.primary, size: 20),
            ),
            minusBtn: Padding(
              padding: EdgeInsets.only(left: 2),
              child: Icon(
                  Icons.remove_circle_rounded, color: AppColors.primary, size: 20),
            ),
          ),
          maxVal: 99999999,
          initVal: 0,
          minVal: 0,
          steps: multiplier,
          onQtyChanged: (val) {
            if (multiplier == 9000) {
              reqProduct.baseQuantity = val.toInt();
            } else {
              reqProduct.upperQuantity = val.toInt();
            }
          },
        ),
      ),
    );
  }
}

class DepotDropdown extends StatefulWidget {
  final DepotController controller;
  final int index;

  const DepotDropdown({required this.controller, required this.index});

  @override
  _DepotDropdownState createState() => _DepotDropdownState();
}

class _DepotDropdownState extends State<DepotDropdown> {
  late DepotZone selectedDepotZone;

  @override
  void initState() {
    super.initState();
    // Initially set the selected depot zone to the first one, or you can customize it.
    DepotZone selectedDepo = widget.controller.depotList[widget.index].depotZone?.first ?? DepotZone(name: "Select a Depo");
    selectedDepotZone = selectedDepo;
    widget.controller.selectedDepotZone.value = selectedDepo;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.colorWhite
      ),
      child: DropdownButton<DepotZone>(
        isExpanded: true,
        value: selectedDepotZone,
        icon: const Icon(Icons.arrow_drop_down_sharp, size: 18, color: Colors.black),
        underline: SizedBox(),
        items: widget.controller.depotList[widget.index].depotZone?.map((DepotZone depot) {

          var isSelected = widget.controller.selectedDepot.value == depot.id;
          return DropdownMenuItem<DepotZone>(
            value: depot,
            child: FittedBox(
              child: Container(
                padding: EdgeInsets.only(bottom: 5,top:5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: AppColors.primary, size: 24),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(depot.name!,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        Text('${depot.address} ${depot.postcode}',
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.gray)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: (DepotZone? newDepot) {
          setState(() {
            selectedDepotZone = newDepot!;
            widget.controller.selectedDepotZone.value = newDepot; // Update the controller value
          });
        },
      ),
    );
  }
}

