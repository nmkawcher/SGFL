import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/utils/helper.dart';
import '../../core/widget/emptyPage_widget.dart';
import '/app/core/base/base_view.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_images.dart';
import 'notification_controller.dart';


class NotificationView extends BaseView<NotificationController> {

  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return AppBar(
      title: Text(appLocalization.notification,style: const TextStyle(color: Colors.black)),
      elevation: 1,
      centerTitle: true,
      backgroundColor: Colors.white,
      iconTheme: const IconThemeData(color: Colors.black),
      systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget body(BuildContext context) {
      return  1==2 ?
       EmptyPageWidget(iconData: AppImages.notification, message: appLocalization.noNotification) :
       ListView.builder(
        shrinkWrap:  true,
        itemCount: 1,
        itemBuilder: (_, index){
          return Container(
            padding: const EdgeInsets.only(top: 8),
            color: 1==2? Colors.transparent: AppColors.primary.withOpacity(0.15),
            child: Column(
              children: [
                ListTile(
                  horizontalTitleGap: 0,
                  visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  title: const Text('Order Confirm', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Padma oil litmited. Order ID #22546 Tk. 250000, 5 Lorry order completed',
                            style: TextStyle(fontSize: 12)
                        ),
                        const SizedBox(height: 16),
                        Text(Helper.dateTimeFormat(DateTime.now()), style: const TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  height: 1,
                  width: Get.width,
                  color: AppColors.grayLight1,
                )
              ],
            ),
          );
        },
      );
  }

}

