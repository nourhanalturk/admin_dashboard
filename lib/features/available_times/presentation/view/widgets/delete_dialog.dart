import 'package:flutter/material.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icon_size.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/features/available_times/presentation/controller/available_times_controller.dart';

class DeleteDateDialog extends StatelessWidget {
  final AvailableTimesController controller;
  final dynamic item;

  const DeleteDateDialog({
    super.key,
    required this.controller,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    // تحدد عرض Dialog ثابت أو كنسبة صغيرة من الشاشة
    final dialogWidth = MediaQuery.of(context).size.width < 500
        ? MediaQuery.of(context).size.width * 0.9
        : 400.0;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Container(
        width: dialogWidth,
        padding: EdgeInsets.all(ManagerWidth.w15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.warning,
              size: ManagerIconSize.s40,
              color: ManagerColors.redColor,
            ),
            SizedBox(height: ManagerHeight.h15),
            Text(
              ManagerStrings.confirmDeletion,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s20,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: ManagerHeight.h15),
            Text(
              ManagerStrings.areYouSureDeleteDateAppointments,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.grayColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ManagerHeight.h24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: ManagerHeight.h12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ManagerRadius.r12),
                      ),
                      side: const BorderSide(color: ManagerColors.primaryColor),
                    ),
                    child: Text(
                      ManagerStrings.cancel,
                      style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: ManagerWidth.w15),
                Expanded(
                  child: mainButton(
                    onPressed: () {
                      controller.deleteDate(item);
                      Navigator.of(context).pop();
                    },
                    minWidth: dialogWidth * 0.4, // عرض الزر مناسب
                    buttonText: ManagerStrings.confirm,
                    color: ManagerColors.redColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
