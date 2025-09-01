import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icon_size.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/main_button.dart';
import 'package:tender/features/available_times/presentation/controller/available_times_controller.dart';
import 'package:tender/features/available_times/presentation/view/widgets/add_new_date_dialog.dart';
import 'package:tender/features/available_times/presentation/view/widgets/delete_dialog.dart';
import 'package:tender/features/available_times/presentation/view/widgets/edit_available_times_dialog.dart';
import 'package:intl/intl.dart';
import 'package:tender/features/available_times/presentation/view/widgets/view_times_dialog.dart';

class AvailableTimesView extends StatelessWidget {
  const AvailableTimesView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.sizeOf(context);
    return GetBuilder<AvailableTimesController>(
      builder: (controller) {
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.all(
              ManagerWidth.w20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        ManagerStrings.manageYourAvailability,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s16,
                          color: ManagerColors.grey,
                        ),
                      ),
                    ),
                    mainButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AddNewDateDialog(controller: controller);
                          },
                        );
                      },
                      buttonText: ManagerStrings.addNewDate,
                      color: ManagerColors.primaryColor,
                      minWidth: size.width * ManagerOpacity.op0_1,
                      height: size.height * ManagerOpacity.op0_07,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.white,
                      ),
                      elevation: 2,
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * ManagerOpacity.op0_03,
                ),
                Expanded(
                  child: controller.availableTimesList.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: ManagerIconSize.s60,
                          color: ManagerColors.grey.withOpacity(
                            ManagerOpacity.op0_5,
                          ),
                        ),
                        SizedBox(
                          height: ManagerHeight.h16,
                        ),
                        Text(
                          ManagerStrings.noAvailableTimes,
                          style: getMediumTextStyle(
                            fontSize: ManagerFontSize.s18,
                            color: ManagerColors.grey,
                          ),
                        ),
                        SizedBox(
                          height: ManagerHeight.h8,
                        ),
                        Text(
                          ManagerStrings.addYourFirstDate,
                          style: getRegularTextStyle(
                            fontSize: ManagerFontSize.s14,
                            color: ManagerColors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )
                      : GridView.builder(
                    itemCount: controller.availableTimesList.length,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: size.width > 900
                          ? 3
                          : size.width > 600
                          ? 2
                          : 1,
                      crossAxisSpacing: ManagerWidth.w15,
                      mainAxisSpacing: ManagerWidth.w15,
                      childAspectRatio: size.width > 600 ? 1.8 : 1.6,
                    ),
                    itemBuilder: (context, index) {
                      final item = controller.availableTimesList[index];
                      final date = item.availableDate.toLocal();
                      final formattedDate =
                      DateFormat('EEE, MMM d').format(date);

                      return Container(
                        decoration: BoxDecoration(
                          color: ManagerColors.white,
                          borderRadius:
                          BorderRadius.circular(ManagerRadius.r16),
                          boxShadow: [
                            BoxShadow(
                              color: ManagerColors.grayColor
                                  .withOpacity(ManagerOpacity.op0_1),
                              blurRadius: ManagerRadius.r16,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 12,
                              right: 12,
                              child: Container(
                                padding: EdgeInsets.all(
                                  ManagerWidth.w4,
                                ),
                                decoration: BoxDecoration(
                                  color: ManagerColors.primaryColor
                                      .withOpacity(ManagerOpacity.op0_1),
                                  borderRadius: BorderRadius.circular(
                                    ManagerRadius.r12,
                                  ),
                                ),
                                child: Text(
                                  '${item.availableTimes
                                      .length} ${ManagerStrings.times}',
                                  style: getMediumTextStyle(
                                    fontSize: ManagerFontSize.s12,
                                    color: ManagerColors.primaryColor,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  color: ManagerColors.primaryColor
                                      .withOpacity(
                                    ManagerOpacity.op0_05,
                                  ),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(
                                      ManagerRadius.r16,
                                    ),
                                    bottomRight: Radius.circular(
                                      ManagerRadius.r16,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.remove_red_eye,
                                        size: ManagerIconSize.s20,
                                        color: ManagerColors.primaryColor,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return TimesDialog(
                                              item: item,
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        size: ManagerIconSize.s20,
                                        color: ManagerColors.primaryColor,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) =>
                                              EditAvailableTimesDialog(
                                                item: item,
                                                controller: controller,
                                              ),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        size: ManagerIconSize.s20,
                                        color: ManagerColors.redColor,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) =>
                                              DeleteDateDialog(
                                                controller: controller,
                                                item: item,
                                              ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(
                                ManagerWidth.w15,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formattedDate,
                                    style: getBoldTextStyle(
                                      fontSize: ManagerFontSize.s20,
                                      color: ManagerColors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ManagerHeight.h8,
                                  ),
                                  Text(
                                    DateFormat('yyyy').format(date),
                                    style: getRegularTextStyle(
                                      fontSize: ManagerFontSize.s14,
                                      color: ManagerColors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ManagerHeight.h12,
                                  ),
                                  Expanded(
                                    child: Wrap(
                                      spacing: ManagerHeight.h6,
                                      runSpacing: ManagerHeight.h6,
                                      children: item.availableTimes
                                          .take(3)
                                          .map(
                                            (t) =>
                                            Container(
                                              padding:
                                              EdgeInsets.symmetric(
                                                horizontal:
                                                ManagerHeight.h8,
                                                vertical:
                                                ManagerHeight.h4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: ManagerColors
                                                    .primaryColor
                                                    .withOpacity(
                                                  ManagerOpacity.op0_1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(
                                                  ManagerRadius.r12,
                                                ),
                                              ),
                                              child: Text(
                                                t,
                                                style: getMediumTextStyle(
                                                  fontSize:
                                                  ManagerFontSize.s12,
                                                  color: ManagerColors
                                                      .primaryColor,
                                                ),
                                              ),
                                            ),
                                      )
                                          .toList(),
                                    ),
                                  ),
                                  if (item.availableTimes.length > 3)
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '+${item.availableTimes.length -
                                            3} ${ManagerStrings.more}',
                                        style: getRegularTextStyle(
                                          fontSize: ManagerFontSize.s12,
                                          color: ManagerColors.grey,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
