import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get/get.dart';

import '../utils/app_haptics.dart';
import '../values/app_colors.dart';


class StatusCard extends GetView {

  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        height: 220,
        viewportFraction: 0.60,
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
      itemCount: 3,
      itemBuilder: (context, itemIndex, pageViewIndex){
        return Card(
          elevation: 4,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          margin: const EdgeInsets.only(right: 8, left: 16, top: 24,bottom: 6),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.accentPrimary,AppColors.primary,],
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
                        padding: const EdgeInsets.only(left: 4,right: 2,top: 4,bottom: 2),
                        child: const Text('PENDING', style: TextStyle(fontSize: 10, color: AppColors.orange, fontWeight: FontWeight.w600)
                        )),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text('#235648', textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 16, color: AppColors.colorWhite, fontWeight: FontWeight.w600)
                      ),
                    ),
                  ],
                ),
                const SizedBox(height:30),
                const Text('Padma Oil Company ltd',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.colorWhite)),
                const SizedBox(height: 4),
                const Text('Bagabri, Sylhet', style: TextStyle(fontSize: 12, color: AppColors.colorWhite)),
                const SizedBox(height: 4),
                const Text('Aug 12, 2024', style: TextStyle(fontSize: 11, color: AppColors.colorWhite)),
                const SizedBox(height: 18),
                const Divider(thickness: 0.5, color: AppColors.grayDark),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Qty: 5.3', style: TextStyle(fontSize: 14, color: AppColors.orange, fontWeight: FontWeight.w600)),
                    Text('৳ 12000', style: TextStyle(fontSize: 14, color: AppColors.orange, fontWeight: FontWeight.w600)),
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