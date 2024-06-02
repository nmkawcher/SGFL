import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/values/app_colors.dart';

class DefaultTextBtn extends GetView {

  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final GestureTapCallback? onClick;


  const DefaultTextBtn({
    super.key,
    required this.onClick,
    required this.title,
    this.fontSize = 16,
    this.fontWeight = FontWeight.normal


  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: onClick,
       child: Text( title,
         style: TextStyle(
              fontSize: fontSize,
              color: AppColors.primary,
              fontWeight: fontWeight
            ),
          ),
    );
  }
}
