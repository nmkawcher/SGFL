import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sgfl_sales/app/data/model/order_history.dart';
import '../../core/utils/helper.dart';
import '../../core/values/app_colors.dart';
import '../../core/values/app_images.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDatatable extends GetView {

  const OrderDatatable({ super.key, required this.history});
  final Iterable<OrderHistory> history;
  AppLocalizations get appLocalization => AppLocalizations.of(Get.context!)!;

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) {
      return Center(
          child: Column(
           children: [
            Lottie.asset(AppImages.emptyIcon,height: 150,width: 150,repeat: false,),
             Text(appLocalization.noPaymentHistory,style: const TextStyle(fontSize: 14,color: AppColors.gray),)
          ]),
      );
    } else {
      return ConstrainedBox(
        constraints: BoxConstraints(
            minWidth: Get.width,
            maxWidth: double.infinity
        ),
        child: DataTable(
            columnSpacing: 16,
            dividerThickness: 1,
            headingRowHeight: 40,

            decoration: BoxDecoration(border: Border.all(color: AppColors.grayLight), borderRadius: BorderRadius.circular(8)),
            columns:  [
              const DataColumn(label: Text('Order ID', style: TextStyle(fontSize: 13, color:AppColors.gray)),),
              DataColumn(label: Text(appLocalization.amount,style: const TextStyle(fontSize: 13, color:AppColors.gray)),),
              DataColumn(label: Text(appLocalization.status, style: const TextStyle(fontSize: 13, color:AppColors.gray))),
              DataColumn(label: Text(appLocalization.date, style: const TextStyle(fontSize: 13, color:AppColors.gray)),),
            ],
            rows: history.map((element) {
              String date = Helper.dateFormat(element.dateTime ?? DateTime.now());
              String time = Helper.timeFormat(element.dateTime ?? DateTime.now());

              return DataRow(
                cells: [
                  DataCell(Text('${element.orderID}', style: const TextStyle(fontSize: 12))),
                  DataCell(Text('${element.amount} ${appLocalization.tk}', style: const TextStyle(fontSize: 12))),
                  DataCell(Text('${element.status}', style: const TextStyle(fontSize: 12))),
                  DataCell(
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(date, style: const TextStyle(fontSize: 12)),
                          Text(time, style: const TextStyle(fontSize: 12,color: AppColors.gray)),
                        ],
                      )
                  ),
                ],
              );
            }
          ).toList()
        ),
      );
    }
  }

  Widget downloadFileBTN(String source, fileName) {
    RxDouble downloadProgress = 0.0.obs;
    var child = beforeDownloadFile().obs;

    return GestureDetector(
      onTap: ()async{
        child.value = downloadPercentIndicator(downloadProgress.value);
       /* Helper.downloadBill(value: source, fileName: fileName,
          onReceiveProgress: (received,total) {
            if (total != -1) {
              downloadProgress.value = (received / total) * 100;
              child.value = downloadPercentIndicator(downloadProgress.value);
              if (downloadProgress.value == 100) {
                child.value = downloadComplete();
                Timer(5.seconds, () {child.value = beforeDownloadFile();});
              }
            }
          }
        );*/
      },
      child: Obx(() => child.value)
    );
  }

  Widget beforeDownloadFile() {
    return  CircleAvatar(
      backgroundColor: AppColors.primary, radius: 20,
      child: SvgPicture.asset(AppImages.downloadReceipt,)
    );
  }

  Widget downloadPercentIndicator(double downloadProgress) {
    return  const SizedBox(
      height: 30,width: 30,
      child: CircularProgressIndicator(strokeWidth: 3,),
    );

  }

  Widget downloadComplete(){
    return const CircleAvatar(
        backgroundColor: AppColors.greenLight, radius: 20,
        child: Icon(Icons.download_done_rounded, color: AppColors.green,size: 24)
    );
  }
}
