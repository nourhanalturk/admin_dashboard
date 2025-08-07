import 'package:flutter/material.dart';
import 'package:tender/core/extensions/extensions.dart';

import '../resources/manager_colors.dart';
import '../resources/manager_font_size.dart';
import '../resources/manager_radius.dart';
import '../resources/manager_styles.dart';

Widget textField({
  required TextEditingController controller,
  InputDecoration? decoration,
  double? borderRadius,
  Color? borderColor,
  Color? fillColor,
  TextStyle? hintStyle,
  String? Function(String?)? validator,
  bool? obSecure,
  TextInputType? keyboardType,
  void Function(String)? onChanged,
  Widget? suffixIcon,
  Widget? prefixIcon,
  TextStyle? style,
  String? hintText,
  FocusNode? focusNode,
  Color? hintColor,
  Widget? label,
  void Function(String)? onFieldSubmitted
}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    obscureText: obSecure.onNull(),
    keyboardType: keyboardType,
    onChanged: onChanged ?? (val) {},
    textInputAction: TextInputAction.next,
    focusNode: focusNode,
    style: getMediumTextStyle(
      fontSize: ManagerFontSize.s18,
      color: ManagerColors.primaryColor,
    ),
    onFieldSubmitted: onFieldSubmitted,
    decoration: decoration ??
        InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? ManagerRadius.r12,
            ),
            borderSide: BorderSide(
              color: borderColor ?? ManagerColors.primaryColor.withOpacity(0.0003),
            ),
          ),
          fillColor: fillColor ?? ManagerColors.transparent,
          hintStyle: hintStyle ??
              getRegularTextStyle(
                fontSize: ManagerFontSize.s16,
                color:hintColor?? ManagerColors.grayColor,
              ),
          hintText: hintText ,
          label: label?? null,
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ManagerRadius.r12,
            ),
            borderSide: const BorderSide(
              color: ManagerColors.redColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ManagerRadius.r12,
            ),
            borderSide: const BorderSide(
              color: ManagerColors.primaryColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              ManagerRadius.r12,
            ),
            borderSide: const BorderSide(
              color: ManagerColors.primaryColor,
            ),
          ),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        ),
  );
}
