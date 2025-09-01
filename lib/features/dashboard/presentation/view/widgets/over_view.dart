import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_font_size.dart';
import '../../../../../core/resources/manager_height.dart';
import '../../../../../core/resources/manager_images.dart';
import '../../../../../core/resources/manager_opacity.dart';
import '../../../../../core/resources/manager_radius.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../core/resources/manager_width.dart';
import '../../../../../core/widgets/responsive.dart';
import '../../../../../core/widgets/shimmer/upcoming_appointment_shimmer.dart';
import '../../controller/dashboard_controller.dart';
import 'responsive_pie_charts.dart';

class OverviewView extends StatelessWidget {
  const OverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return ListView(
          children: [
            SizedBox(height: size.height * ManagerOpacity.op0_04),
            Text(
              ManagerStrings.overView,
              style: getBoldTextStyle(
                fontSize: Responsive.isMobile(context)
                    ? ManagerFontSize.s24
                    : ManagerFontSize.s30,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(height: size.height * ManagerOpacity.op0_03),
            Padding(
              padding: EdgeInsets.only(bottom: ManagerHeight.h25),
              child: Text(
                ManagerStrings.nearestAppointments,
                style: getBoldTextStyle(
                  fontSize: ManagerFontSize.s18,
                  color: ManagerColors.black,
                ),
              ),
            ),
            controller.isUpcomingAppointmentsLoading
                ? const UpcomingAppointmentsShimmer()
                : controller.upcomingAppointments.isEmpty
                ? Column(
              children: [
                Image.asset(
                  ManagerImages.doctorDuty,
                  height: 180,
                ),
                const SizedBox(height: 20),
                Text(
                  ManagerStrings.noUpcomingAppointmentsYet,
                  style: getBoldTextStyle(
                    fontSize: ManagerFontSize.s18,
                    color: ManagerColors.grey,
                  ),
                ),
              ],
            )
                : Column(
              children: List.generate(
                controller.upcomingAppointments.length,
                    (index) {
                  var model = controller.upcomingAppointments[index];
                  return Container(
                    height: size.height * ManagerOpacity.op0_09,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: ManagerColors.lightPurple2),
                      borderRadius: BorderRadius.circular(ManagerRadius.r25),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(ManagerWidth.w8),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: ManagerRadius.r25,
                            backgroundImage: NetworkImage(model.dependentImageUrl),
                          ),
                          SizedBox(width: size.width * ManagerOpacity.op0_01),
                          Text(
                            model.dependentName,
                            style: getBoldTextStyle(
                              fontSize: Responsive.isDesktop(context)
                                  ? ManagerFontSize.s18
                                  : ManagerFontSize.s12,
                              color: ManagerColors.lightBlue,
                            ),
                          ),
                          SizedBox(width: size.width * ManagerOpacity.op0_07),
                          Text(
                            DateFormat('dd MMM yyyy, hh:mm a')
                                .format(DateTime.parse(model.appointmentTime)),
                            style: getBoldTextStyle(
                              fontSize: Responsive.isDesktop(context)
                                  ? ManagerFontSize.s18
                                  : ManagerFontSize.s14,
                              color: ManagerColors.black,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.settings,
                              color: ManagerColors.lightBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            ResponsivePieCharts(
              isColumn: Responsive.isMobile(context) || Responsive.isTablet(context),
              controller: controller,
            ),
          ],
        );
      },
    );
  }
}
