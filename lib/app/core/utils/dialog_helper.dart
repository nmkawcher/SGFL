import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../values/app_colors.dart';
import '../values/app_images.dart';
import '../values/app_values.dart';

class DialogHelper{


  static void onButtonPermissionSheet(BuildContext context,IconData iconData, String title, String body,VoidCallback onPressed){
      showModalBottomSheet(
        context: context, backgroundColor: Colors.white,isDismissible: false, enableDrag: false,
        shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        builder: (context){
          return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
                height: 350,
                padding: const EdgeInsets.only(top: 8),
                child: Stack(
                  children: [
                    Positioned(left: 0,right: 0,top: 0,
                      child: FractionallySizedBox(
                        widthFactor: 0.1,
                        child: Container(margin: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Container(height: 5.0,
                            decoration: BoxDecoration(color: AppColors.grayLight,
                              borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(right: 4,top: 0,
                        child: IconButton(
                          icon: const Icon(Icons.clear,size: 32),
                          onPressed: () { Get.back();},
                        )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(iconData, size: 40),
                          const SizedBox(height: 16),
                          Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Padding(padding: const EdgeInsets.all(16),
                              child: Text(body,textAlign: TextAlign.center, style: const TextStyle(fontSize: 14,color: Colors.black54))),
                          const SizedBox(height: 32),
                          SizedBox( height: 50,width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed:onPressed,
                              style: ElevatedButton.styleFrom(backgroundColor:AppColors.primary, textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                              child: const Text('Give Permission', style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
          );

        }
      );
  }

  static void showErrorDialog (String title, String message, { IconData icon = Icons.error_rounded, Color iconColor = AppColors.red}){
    showDialog(
      context: Get.context!,
      builder: (BuildContext cxt) {
        return Align( alignment: Alignment.center,
          child: Padding( padding: const EdgeInsets.all(16),
            child: Material( color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(right: 4, top: 2, child: IconButton(icon: const Icon(Icons.clear, size: 32), onPressed: () =>Get.back())),
                    Positioned(left: 16,right: 16,bottom: 20,top:60,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(icon, color: iconColor, size: 60),
                            const SizedBox(height: 24),
                            Text(title,textAlign: TextAlign.center, style: TextStyle(fontSize: 18,color: iconColor, fontWeight: FontWeight.w600),),
                            Text(message,textAlign: TextAlign.center,maxLines: 3, style: const TextStyle(fontSize: 14,overflow: TextOverflow.ellipsis)).paddingOnly(top: 16,left: 32, right: 32, bottom: 16),
                          ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static void showSuccessDialog (Widget widget,{double? dialogHeight, bool cancelBtnHide = true, Function? function }){
    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext cxt) {
        return Align( alignment: Alignment.center,
          child: Padding( padding: const EdgeInsets.all(16),
            child: Material( color: Colors.white,
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
              child: SizedBox(
                height: dialogHeight ?? 300,
                width: double.infinity,
                child: Stack(
                  children: [
                     Positioned(right: 4, top: 0,
                         child: Visibility(
                             visible:cancelBtnHide,
                             child: IconButton(icon: const Icon(Icons.clear, size: 32), onPressed: () => Get.back())
                         )
                     ),
                     Positioned(left: 16,right: 16,bottom: 0,top: 0,
                         child: widget),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    ).then((value){ if (function != null) function();});
  }


  static void showWarningDialog({
  required String title,
  required String body,
  String image = AppImages.warning,
  required VoidCallback? onPressed,
  String buttonName = 'Try Again'
  }) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext cxt) {
        return Align(alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Material( color: Colors.white,
              shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(15)),
              child: Padding( padding: const EdgeInsets.all(16),
                child: Column( mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(image,height: 100,),
                    const SizedBox(height: 40,),
                    Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Padding(padding: const EdgeInsets.all(16), child: Text(body,textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14,color: Colors.black54),),),
                    const SizedBox(height: 40),
                    SizedBox( height: 50,width: double.maxFinite,
                      child: ElevatedButton(onPressed: onPressed,
                        style: ElevatedButton.styleFrom(backgroundColor:AppColors.primary,
                            textStyle: const TextStyle(fontWeight: FontWeight.bold)),
                        child:Text(buttonName, style: const TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  static onDefaultButtonSheet(Widget widget, {double? dialogHeight , Function? function }){
    showModalBottomSheet(
      useSafeArea: true,
      context: Get.context!,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30))
        ),
      builder: (context){
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: dialogHeight,
            padding: const EdgeInsets.only(top: 8),
            child: Stack(
              children: [
                 Positioned(left: 0,right: 0,top: 0,
                      child: FractionallySizedBox(
                      widthFactor: 0.1,
                      child: Container(margin: const EdgeInsets.symmetric(vertical: 12.0),
                        child: Container(height: 5.0,
                          decoration: BoxDecoration(color: AppColors.grayLight,
                            borderRadius: BorderRadius.circular(2.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                 Positioned(right: 4,top: 0,
                   child: IconButton(
                      icon: const Icon(Icons.clear,size: 32),
                     onPressed: () { Get.back();},
                     )
                   ),
                 widget,
                ],
              )
          ),
        );
      }
    ).then((value){ if (function != null) function();});
  }

}