import 'package:get/get.dart';
import 'package:sgfl_sales/app/modules/order/order_binding.dart';
import 'package:sgfl_sales/app/modules/order/order_view.dart';
import 'package:sgfl_sales/app/modules/product/product_binding.dart';
import 'package:sgfl_sales/app/modules/product/product_view.dart';
import 'package:sgfl_sales/app/modules/profile/profile_binding.dart';
import 'package:sgfl_sales/app/modules/profile/profile_view.dart';
import 'package:sgfl_sales/app/modules/requisition/requisition_binding.dart';
import 'package:sgfl_sales/app/modules/requisition/requisition_information_view.dart';
import '../modules/home/home_binding.dart';
import '../modules/home/customer_home/customer_home_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/main/main_binding.dart';
import '../modules/main/main_view.dart';
import '../modules/notification/notification_binding.dart';
import '../modules/notification/notification_view.dart';
import '../modules/order_details/order_details_binding.dart';
import '../modules/order_details/order_details_view.dart';
import '../modules/requisition/requisition_quantity_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.MAIN,
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.HOME_Customer,
      page: () => CustomerHomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REQUISITION_Quantity,
      page: () => RequisitionQuantityView(),
      binding: RequisitionBinding(),
    ),
    GetPage(
      name: _Paths.REQUISITION_Information,
      page: () => RequisitionInformationView(),
      binding: RequisitionBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCTS,
      page: () => ProductView(),
      binding: ProductBinding(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: _Paths.ORDER,
      page: () => OrderView(),
      binding: OrderBinding(),
    ),
    GetPage(
      name: _Paths.ORDERDetails,
      page: () => OrderDetailsView(),
      binding: OrderDetailsBinding(),
    ),
    GetPage(
        name: _Paths.NOTIFICATION,
        page: () => NotificationView(),
        binding: NotificationBinding(),
        transition: Transition.rightToLeft,
        transitionDuration: 200.milliseconds
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

  ];
}
