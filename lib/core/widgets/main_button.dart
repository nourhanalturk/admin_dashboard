import 'package:flutter/material.dart';
import 'package:tender/core/extensions/extensions.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_styles.dart';

Widget mainButton({
  required Function()? onPressed,
  String? buttonText,
  Color? color,
  BorderRadiusGeometry? borderRadius,
  double? minWidth,
  double? height,
  TextStyle? style,
  Widget? child,
  Color? textColor,
  double? elevation,
  double? buttonRadius ,
}) {
  return Container(
    height: height ?? ManagerHeight.h35,
    decoration: BoxDecoration(
      color: color ?? ManagerColors.primaryColor,
      borderRadius: borderRadius ??
          BorderRadius.all(
            Radius.circular(
              buttonRadius?? ManagerRadius.r12,
            ),
          ),
    ),
    child: MaterialButton(
      elevation: elevation??0,
      minWidth: minWidth ?? double.infinity,
      onPressed: onPressed,
      child:child?? Text(
        buttonText.onNull(),
        style: style ??
            getBoldTextStyle(
              fontSize: ManagerFontSize.s18,
              color:textColor?? ManagerColors.white,
            ),
      ),
    ),
  );
}
