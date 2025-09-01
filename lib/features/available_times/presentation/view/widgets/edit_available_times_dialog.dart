import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/features/available_times/domain/model/available_times_model.dart';
import 'package:tender/features/available_times/presentation/controller/available_times_controller.dart';

import '../../../../../core/widgets/responsive.dart';

class EditAvailableTimesDialog extends StatelessWidget {
  final AvailableTimesModel item;
  final AvailableTimesController controller;

  const EditAvailableTimesDialog({
    super.key,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AvailableTimesController>(
      builder: (_) {
        return Container(
          width: Responsive.isMobile(context)
              ? double.infinity
              : MediaQuery.sizeOf(context).width * 0.9,
          child: AlertDialog(
            title: Text(
              item.availableDate.toLocal().toString().split(" ")[0],
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s20,
                color: ManagerColors.black,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: item.availableTimes.map((t) {
                      return Chip(
                        label: Text(t),
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () {
                          controller.removeTime(item, t);
                        },
                        backgroundColor:
                        ManagerColors.primaryColor.withOpacity(0.2),
                        labelStyle: getMediumTextStyle(
                          fontSize: ManagerFontSize.s15,
                          color: ManagerColors.black,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: () => controller.toggleAddTimeField(),
                    child: Text(ManagerStrings.addNewTime,),
                  ),

                  if (controller.showAddTimeField) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller.timeController,
                            decoration: InputDecoration(
                              hintText: ManagerStrings.enterTime,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            final newTime =
                            controller.timeController.text.trim();
                            if (newTime.isNotEmpty &&
                                !item.availableTimes.contains(newTime)) {
                              controller.addTime(item, newTime);
                            }
                          },
                          child: Text(ManagerStrings.add),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  ManagerStrings.close,
                  style: getMediumTextStyle(
                    fontSize: ManagerFontSize.s16,
                    color: ManagerColors.primaryColor,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
