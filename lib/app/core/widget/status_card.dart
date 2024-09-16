import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../../data/model/home_model.dart';
import '../utils/app_haptics.dart';
import '../values/app_colors.dart';


class OrderUiModel extends GetView {

  List<LatestOrder> orderList;
  OrderUiModel({required this.orderList});
  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 235,
        viewportFraction: 0.70,
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        enlargeStrategy: CenterPageEnlargeStrategy.zoom,
        padEnds: true,
        initialPage: 1,
        onPageChanged: (index, reason) {
          if (reason == CarouselPageChangedReason.manual) AppHaptics.lightImpact();
        },
      ),
      itemCount: orderList.length,
      itemBuilder: (context, itemIndex, pageViewIndex){
        LatestOrder order = orderList[itemIndex];
        return Card(
          elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.only(right: 8, left: 16, top: 20,bottom: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),side: BorderSide(color: AppColors.borderColor,width: 1)),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.colorWhite,AppColors.colorWhite,],
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        decoration: AppColors.defaultDecoration(
                            color:AppColors.orange,
                            radius: 6
                        ),
                        padding: const EdgeInsets.only(left: 4,right: 4,top: 4,bottom: 2),
                        child: Text(order.status?.toUpperCase() ??"", style: const TextStyle(fontSize: 10, color: AppColors.orange, fontWeight: FontWeight.w600)
                     )),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text('#${order.challanNo}', textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 16, color: AppColors.textColor, fontWeight: FontWeight.w600)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:20),
                Text(order.order?.customer?.name??"",
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textColor)),
                const SizedBox(height: 4),
                Text(order.order?.dipo?.address??"", style: const TextStyle(fontSize: 12, color: AppColors.bodyTextColor)),
                const SizedBox(height: 4),
                Text(order.date??"", style: const TextStyle(fontSize: 11, color: AppColors.colorWhite)),
                const SizedBox(height: 14),
                const Divider(thickness: 0.5, color: AppColors.grayDark),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Qty: ${order.quantityLiter ?? 0.00}', style: const TextStyle(fontSize: 12, color: AppColors.bodyTextColor, fontWeight: FontWeight.w600)),
                    Text('৳ ${order.totalAmount ?? 0.00}', style: const TextStyle(fontSize: 12, color: AppColors.bodyTextColor, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}