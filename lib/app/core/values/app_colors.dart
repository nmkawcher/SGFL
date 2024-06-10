import 'package:flutter/material.dart';

abstract class AppColors {

  static const Color pageBackground = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFF3c887e);
  static const Color grayShed = Color(0xFFf7f7f7);
  static const Color primary15 = Color(0xffe3fff2);
  static const Color textColor = Color(0xFF3c4046);

  static const Color primaryLight = Color(0xFFf5f9f8);
  static const Color accentPrimary = Color(0xff00a058);
  static const Color accentPrimary2 = Color(0xFF00D21C);
  static const Color accentPrimary3 = Color(0xFF1AFF12);
  static const Color neviBlue= Color(0xFF4DB635);
  static const Color colorDarkBlue = Color(0xFF13A203);
  static const Color colorDarkBlue2 = Color(0xFF38D620);
  static const Color grayLight = Color(0xFFBBBFCD);
  static const Color grayLight1 = Color(0xFFE3DFDF);
  static const Color grayLight2 = Color(0xFFC4C6D0);
  static const Color gray = Color(0xFF838383);
  static const Color gray58 = Color(0xFF989898);
  static const Color green29= Color(0xFFA0FF7F);
  static const Color greenDark= Color(0xFF086100);
  static const Color green= Color(0xFF34B829);
  static const Color greenLight= Color(0xFFE6FFE6);
  static const Color red= Color(0xFFF54748);
  static const Color orange= Color(0xFFFFA621);
  static const Color Yellow= Color(0xFFFFEA00);

  static const MaterialColor colorPrimarySwatch = Colors.teal;
  static const Color colorPrimary = Color(0xFF38686A);
  static const Color colorAccent = Color(0xFF38686A);
  static const Color colorLightGreen = Color(0xFF00EFA7);
  static const Color colorWhite = Color(0xFFFFFFFF);
  static const Color lightGreyColor = Color(0xFFC4C4C4);
  static const Color errorColor = Color(0xFFAB0B0B);
  static const Color colorDark = Color(0xFF353638);
  static const Color colorTeal = Color(0xFF00EDFF);

  static Color statusColor(String value) => statusColorMap[value] ?? primary;
  static const Map<String, Color> statusColorMap = {
    'pending': orange,
    'approved': primary,
    'processing': orange,
    'shipping': gray
  };

  static defaultDecoration({
    Color color = grayLight1,
    Color bgColor = Colors.transparent,
    double radius = 12,
    bool isSelected = false
  }) =>  BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(color: isSelected ? AppColors.red: color),
      color: bgColor
  );

  static circleIconBG(Color color, IconData icon) => CircleAvatar(
    backgroundColor: color.withOpacity(0.20),
    child: Icon(icon, color: color),
  );

}
