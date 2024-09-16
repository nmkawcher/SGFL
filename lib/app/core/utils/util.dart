import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgfl_sales/app/core/values/app_colors.dart';

class MyUtils {

  // static splashScreen() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: MyColor.getPrimaryColor(), statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.getPrimaryColor(), systemNavigationBarIconBrightness: Brightness.light));
  // }
  //
  // static allScreen() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: MyColor.getPrimaryColor(), statusBarIconBrightness: Brightness.light, systemNavigationBarColor: MyColor.getWhiteColor(), systemNavigationBarIconBrightness: Brightness.dark));
  // }

  static dynamic getShadow({
    Color? color,
    Offset? offset,
    double? blurRadius,
    double? spreadRadius,
  }) {
    return [
      BoxShadow(
        blurRadius: blurRadius ?? 15.0,
        offset: offset ?? const Offset(0, 25),
        color: color ?? AppColors.getGreyColorwithShade500().withOpacity(0.6),
        spreadRadius: spreadRadius ?? -35.0,
      ),
    ];
  }

  static dynamic getShadow2({
    double blurRadius = 8,
    Color? color,
    Offset? offset,
    double? spreadRadius,
  }) {
    return [
      BoxShadow(
        blurRadius: blurRadius,
        offset: offset ?? const Offset(0, 25),
        color: color ?? AppColors.getGreyColorwithShade500().withOpacity(0.6),
        spreadRadius: spreadRadius ?? -35.0,
      ),
      BoxShadow(
        blurRadius: blurRadius,
        offset: offset ?? const Offset(0, 1),
        color: color ?? AppColors.getGreyColorwithShade500().withOpacity(0.6),
        spreadRadius: spreadRadius ?? 1,
      ),
    ];
  }

  static dynamic getBottomSheetShadow() {
    return [
      BoxShadow(
        color: AppColors.getGreyColorwithShade500().withOpacity(0.08),
        spreadRadius: 3,
        blurRadius: 4,
        offset: const Offset(0, 3),
      ),
    ];
  }

  static dynamic getCardShadow() {
    return [
      BoxShadow(
        color: AppColors.getShadowColor().withOpacity(0.05),
        spreadRadius: 2,
        blurRadius: 2,
        offset: const Offset(0, 3),
      ),
    ];
  }





  String maskSensitiveInformation(String input) {
    if (input.isEmpty) {
      return '';
    }

    final int maskLength = input.length ~/ 2; // Mask half of the characters.
    final String mask = '*' * maskLength;
    final String maskedInput = maskLength > 4 ? input.replaceRange(5, maskLength, mask) : input.replaceRange(0, maskLength, mask);
    return maskedInput;
  }


  static bool isImage(String path) {
    if (path.contains('.jpg')) {
      return true;
    }
    if (path.contains('.png')) {
      return true;
    }
    if (path.contains('.jpeg')) {
      return true;
    }
    return false;
  }

  static bool isXlsx(String path) {
    if (path.contains('.xlsx')) {
      return true;
    }
    if (path.contains('.xls')) {
      return true;
    }
    if (path.contains('.xlx')) {
      return true;
    }
    return false;
  }

  static bool isDoc(String path) {
    if (path.contains('.doc')) {
      return true;
    }
    if (path.contains('.docs')) {
      return true;
    }
    return false;
  }

  static bool isURL(String urlString) {
    Uri? uri = Uri.tryParse(urlString);
    return uri != null && uri.hasScheme && uri.hasAuthority;
  }

}
