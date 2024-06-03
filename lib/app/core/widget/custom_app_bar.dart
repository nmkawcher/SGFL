import 'package:flutter/material.dart';
import '/app/core/values/app_colors.dart';

//Default appbar customized with the design of our app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => AppBar().preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColors.colorWhite),
      title: Text(title, style: const TextStyle(color: AppColors.colorWhite)),
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
    );
  }
}
