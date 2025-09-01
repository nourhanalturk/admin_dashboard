import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_font_size.dart';
import '../../../../../core/resources/manager_radius.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../core/widgets/main_button.dart';
import '../../../domain/model/available_times_model.dart';

class TimesDialog extends StatelessWidget {
  final AvailableTimesModel item;

  const TimesDialog({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${ManagerStrings.availableTimes} ${item.availableDate.toLocal().toString().split(" ")[0]}",
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s20,
                color: ManagerColors.black,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: item.availableTimes.map<Widget>((t) {
                return Chip(
                  label: Text(
                    t,
                    style: getMediumTextStyle(
                      fontSize: ManagerFontSize.s14,
                      color: ManagerColors.white,
                    ),
                  ),
                  backgroundColor: ManagerColors.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r12),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            mainButton(
              onPressed: () => Get.back(),
              buttonText: ManagerStrings.close,
              color: ManagerColors.primaryColor,
              minWidth: 100,
            ),
          ],
        ),
      ),
    );
  }
}