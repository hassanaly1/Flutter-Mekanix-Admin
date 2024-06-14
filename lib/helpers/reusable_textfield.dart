import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mechanix_admin/helpers/appcolors.dart';
import 'package:mechanix_admin/helpers/reusable_container.dart';

class ReUsableTextField extends StatelessWidget {
  final String? hintText;
  final bool? readOnly;
  final VoidCallback? onTap;
  int? maxLines;
  Widget? prefixIcon;
  Widget? suffixIcon;
  TextInputType? keyboardType;
  TextEditingController? controller;
  void Function(String)? onChanged;
  bool obscureText;
  final String? Function(String?)? validator;
  final bool showBackgroundShadow;
  Iterable<String>? autofillHints;

  ReUsableTextField(
      {super.key,
      this.hintText,
      this.onTap,
      this.readOnly,
      this.prefixIcon,
      this.suffixIcon,
      this.maxLines = 1,
      this.keyboardType,
      this.controller,
      this.onChanged,
      this.obscureText = false,
      this.showBackgroundShadow = true,
      this.validator,
      this.autofillHints});

  @override
  Widget build(BuildContext context) {
    return ReUsableContainer(
      showBackgroundShadow: showBackgroundShadow,
      verticalPadding: context.height * 0.015,
      child: TextFormField(
        autofillHints: autofillHints,
        readOnly: readOnly ?? false,
        onTap: onTap,
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
        obscureText: obscureText,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: AppColors.textColor,
        ),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          // contentPadding: EdgeInsets.symmetric(vertical: 4.0),
          // isCollapsed: true,
          isDense: true,
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,

          hintText: hintText,
          hintStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w300,
            color: AppColors.lightTextColor,
          ),
          errorStyle: const TextStyle(
            fontSize: 8.0,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
