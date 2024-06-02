import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '/app/core/base/base_view.dart';
import 'home_controller.dart';

class HomeView extends BaseView<HomeController> {


  @override
  PreferredSizeWidget? appBar(BuildContext context) {
    return null;
  }

  @override
  Widget body(BuildContext context) {
    return ElevatedButton(
        onPressed: (){
          Get.toNamed(Routes.REQUISITION_Quantity);
        }, child: const Text('Requisition')
    );
  }

}
