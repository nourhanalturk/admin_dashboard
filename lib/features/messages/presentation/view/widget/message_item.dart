import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_width.dart';
import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_font_size.dart';
import '../../../../../core/resources/manager_styles.dart';

Widget messageItem({
  required bool isSender,
  required String message,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ManagerWidth.w6,
          vertical: ManagerHeight.h4,
        ),
        decoration: BoxDecoration(
          color: isSender ? ManagerColors.primaryColor : ManagerColors.primaryColor.withOpacity(ManagerOpacity.op0_2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s18,
            color: ManagerColors.white,
          ),
        ),
      ),
    ),
  );
}
