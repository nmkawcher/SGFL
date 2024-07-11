import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/values/app_colors.dart';

class DefaultInputFiled extends GetView {
  const DefaultInputFiled(
      {
        Key? key,
        required this.txtController,
        required this.onChanged,
        required this.labelText,
        this.hintText,
        this.keyboardType,
        this.maxLine,
        this.autofocus = false,
        this.marginBottom = 16,
        this.validator,
        this.prefixText,
        this.maxLength,
        this.fontSize = 16

      }) : super(key: key);

  final TextEditingController? txtController;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final String labelText;
  final String? hintText;
  final bool autofocus;
  final int? maxLine;
  final double marginBottom;
  final FormFieldValidator? validator;
  final String?prefixText;
  final int?maxLength;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: marginBottom),
      child: TextFormField(
          style: TextStyle(color: Colors.black, fontSize: fontSize),
          controller: txtController,
          keyboardType: keyboardType,
          onChanged: onChanged,
          autofocus: autofocus,
          maxLines: maxLine,
          maxLength: maxLength,
          validator: validator ?? (value) {return value!.isEmpty ? 'Required Field' : null;},
          decoration: InputDecoration(
              labelText: labelText,
              hintStyle: const TextStyle(color: AppColors.gray),
              hintText: hintText,
              alignLabelWithHint: true,
              contentPadding: const EdgeInsets.all(18),
              prefixText: prefixText,
              counterText: '',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)))),
    );
  }
}

