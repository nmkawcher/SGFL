import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_colors.dart';
import '../../routes/app_pages.dart';
import '../home/home_view.dart';
import '../order/order_view.dart';
import '/app/core/base/base_view.dart';
import 'main_controller.dart';


class MainView extends BaseView<MainController> {
  MainView(){controller.loadInitialData();}

  @override
  PreferredSizeWidget? appBar(BuildContext context) => null;

  @override
  Widget body(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: Obx((){
        return pageView(controller.bottomNavIndex.value);
      }),
    );
  }

  @override
  Widget? floatingActionButton(){
    return Obx((){
      return controller.isContractor.value
          ? const SizedBox()
          : FloatingActionButton(
              onPressed: () {
                controller.isAdmin.value
                    ? Get.toNamed(Routes.CONTRACTOR_ASSIGN)
                    : Get.toNamed(Routes.DEPOT);
                },
              backgroundColor: AppColors.orange,
              child: controller.isAdmin.value
                  ? const Icon(Icons.person_add_rounded)
                  : const Icon(Icons.add),
            );
    });
  }

  @override
  Widget? bottomNavigationBar() {
    return Obx((){
      return AnimatedBottomNavigationBar.builder(
        tabBuilder: (int index, bool isActive) {
          final color = isActive ? AppColors.primary : AppColors.grayDark;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(controller.iconList[index], color: color),
              const SizedBox(height: 4),
              Text(controller.pageList[index], style: TextStyle(color: color, fontSize: 12))
            ],
          );
        },
        itemCount: controller.iconList.length,
        activeIndex: controller.bottomNavIndex.value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        height: 60,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index){controller.bottomNavIndex.value = index;},
      );
    });
  }

  final HomeView homeView = HomeView();
  OrderView? favoriteView;

  Widget pageView(int menuCode) {
    switch (menuCode) {
      case 0:
        return homeView;
      case 1:
        favoriteView ??= OrderView();
        return favoriteView!;
      default:
        return homeView;
    }
  }

}
