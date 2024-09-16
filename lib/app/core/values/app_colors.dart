import 'package:flutter/material.dart';

abstract class AppColors {

  static const Color pageBackground = Color(0xFFF9F9F9);
  static const bgColor2 = Color(0xFFE6E6E6);
  static const bgColor = Color(0xFFFFFFFF);
  static const bgColorLight = Color(0xFFf2f2f2);
  static const bgColor1 = Color(0xFFF9F9F9);
  static const Color primary = Color(0xFF000000);
  static const Color grayShed = Color(0xFFf7f7f7);
  static const Color primary15 = bgColor;//Color(0xffe3fff2);
  static const Color borderColor=Color(0xFFEFEFEF);
  static const Color textColor = Colors.black;
  static const Color tileColor=Color(0xFF131722);
  static const Color cBlackColor=Color(0xFF1C1E2A);
  static const Color bodyTextColor=Color(0xFF747475);
  static const Color blueGrey = Colors.blueGrey;
  static const Color primaryLight = Color(0xFFf5f9f8);
  static const Color accentPrimary = Color(0xff000000);
  static const Color grayLight = Color(0xFFBBBFCD);
  static const Color grayLight1 = Color(0xFFE3DFDF);
  static const Color grayLight2 = Color(0xFFC4C6D0);
  static const Color gray = Color(0xFF838383);
  static const Color grayDark = Color(0xFF8A9FB0);
  static const Color gray58 = Color(0xFF989898);
  static const Color green= bgColor;
  static const Color greenLight= Color(0xFFE6FFE6);
  static const Color red= Color(0xFFF54748);
  static const Color orange= Color(0xFFFFA621);
  static const Color Yellow= Color(0xFFFFEA00);

  static const Color colorPrimarySwatch = Color(0xFF000000);
  static const Color colorPrimary = Color(0xFF000000);
  static const Color colorAccent = Color(0xFF000000);
  static const Color colorLightGreen = Color(0xFF00EFA7);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color lightGreyColor = Color(0xFFC4C4C4);
  static const Color errorColor = Color(0xFFAB0B0B);
  static const Color colorDark = Color(0xFF353638);
  static const Color colorTeal = Color(0xFF00EDFF);
  static const Color colorGrayBG = Color(0xFFFAF9F9);
  static const Color lShadowColor = Color(0xffEAEAEA);
  static Color getShadowColor() {
    return lShadowColor;
  }

  static Color greyColorWithShadeFiveHundred = Colors.grey.shade500;

  static Color getGreyColorwithShade500() {
    return greyColorWithShadeFiveHundred;
  }

  static const Color greyColor = Color(0xff808080);
  static Color getGreyColor() {
    return AppColors.greyColor;
  }
  static Color statusColor(String value) => statusColorMap[value] ?? primary;
  static const Map<String, Color> statusColorMap = {
    'confirmed': primary,
    'processing': orange,
    'shipped': gray
  };

  static defaultDecoration({
    Color color = grayLight1,
    Color bgColor = Colors.transparent,
    double radius = 12,
    bool isSelected = false
  }) =>  BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: isSelected ? AppColors.orange: color),
      color: bgColor
  );
  static fillDecoration({
    Color color = grayLight1,
    Color bgColor = Colors.transparent,
    double radius = 12,
    bool isSelected = false
  }) =>  BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: isSelected ? AppColors.orange: color),
      color: bgColor
  );

  static circleIconBG(Color color, IconData icon, {double? radius, double? iconSize}) => CircleAvatar(
    radius: radius ,
    backgroundColor: color.withOpacity(0.20),
    child: Icon(icon, color: color, size:iconSize),
  );

  static circleImageBG(Color color, String icon, {double? radius, double? iconSize}) => CircleAvatar(
    radius: radius ,
    backgroundColor: color.withOpacity(0.20),
    child: Image.asset(icon, color: color, height: iconSize,width: iconSize),
  );

  static tableHeaderStyle() => const TextStyle(fontWeight: FontWeight.w600, fontSize:12,color: AppColors.textColor);
  static tableCallStyle() => const TextStyle(fontSize:14,color: AppColors.colorDark);


  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }

}
