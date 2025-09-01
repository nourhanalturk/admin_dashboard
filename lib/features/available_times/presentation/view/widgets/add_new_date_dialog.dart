import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/features/available_times/presentation/controller/available_times_controller.dart';

class AddNewDateDialog extends StatelessWidget {
  final AvailableTimesController controller;

  const AddNewDateDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      insetPadding: EdgeInsets.all(ManagerWidth.w15),
      backgroundColor: Colors.white,
      child: Container(
        width: size.width * 0.75,
        height: size.height * 0.55, // أصغر
        padding: EdgeInsets.all(ManagerWidth.w15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 12,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: GetBuilder<AvailableTimesController>(
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  ManagerStrings.addNewDate,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s20,
                    color: ManagerColors.primaryColor,
                  ),
                ),
                const SizedBox(height: 20),

                // Date Picker
                Text(
                  ManagerStrings.selectDate,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                _styledButton(
                  text: controller.selectedDate != null
                      ? controller.selectedDate!.toLocal().toString().split(' ')[0]
                      : ManagerStrings.pickDate,
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: Theme.of(context).copyWith(
                            colorScheme: ColorScheme.light(
                              primary: ManagerColors.primaryColor,
                              onPrimary: Colors.white,
                              onSurface: ManagerColors.black,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );
                    if (pickedDate != null) {
                      controller.selectedDate = pickedDate;
                      controller.update();
                    }
                  },
                ),
                const SizedBox(height: 20),

                // Time Picker
                Text(
                  ManagerStrings.addTimes,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: [
                    ...controller.newTimes.map(
                          (t) => Chip(
                        label: Text(
                          t,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.black,
                          ),
                        ),
                        backgroundColor: ManagerColors.primaryColor.withOpacity(0.15),
                        deleteIcon: const Icon(Icons.close, size: 16),
                        onDeleted: () => controller.removeNewTime(t),
                      ),
                    ),
                    _styledButton(
                      text: ManagerStrings.addNewTime,
                      onPressed: () async {
                        TimeOfDay? pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                          builder: (context, child) {
                            return Theme(
                              data: Theme.of(context).copyWith(
                                timePickerTheme: TimePickerThemeData(
                                  dialBackgroundColor: ManagerColors.primaryColor.withOpacity(0.1),
                                  dialHandColor: ManagerColors.primaryColor,
                                  hourMinuteTextColor: ManagerColors.black,
                                  entryModeIconColor: ManagerColors.primaryColor,
                                ),
                                colorScheme: ColorScheme.light(
                                  primary: ManagerColors.primaryColor,
                                  onPrimary: Colors.white,
                                  onSurface: ManagerColors.black,
                                ),
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedTime != null) {
                          String formatted =
                              '${pickedTime.hour.toString().padLeft(2, '0')}:${pickedTime.minute.toString().padLeft(2, '0')}';
                          controller.addNewTime(formatted);
                        }
                      },
                      isSecondary: true,
                    )
                  ],
                ),
                const Spacer(),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _styledButton(
                      text: ManagerStrings.cancel,
                      onPressed: () => Navigator.of(context).pop(),
                      isSecondary: true,
                    ),
                    const SizedBox(width: 12),
                    _styledButton(
                      text: ManagerStrings.save,
                      onPressed: () {
                        if (controller.selectedDate != null &&
                            controller.newTimes.isNotEmpty) {
                          controller.saveNewDate();
                          Navigator.of(context).pop();
                        } else {
                          Get.snackbar(
                            ManagerStrings.errorOccurred,
                            ManagerStrings.selectDateAndTime,
                            backgroundColor: ManagerColors.redColor.withOpacity(0.9),
                            colorText: Colors.white,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  /// Styled Main Button (Primary / Secondary)
  Widget _styledButton({
    required String text,
    required VoidCallback onPressed,
    bool isSecondary = false,
  }) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: isSecondary ? ManagerColors.grayColor : ManagerColors.primaryColor,
        foregroundColor: isSecondary ? Colors.black87 : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: isSecondary ? 0 : 3,
        minimumSize: const Size(100, 40),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s14,
          color: isSecondary ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
