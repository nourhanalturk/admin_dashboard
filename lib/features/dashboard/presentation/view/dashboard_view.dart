import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_icon_size.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/text_field.dart';
import 'package:tender/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:tender/features/dashboard/presentation/view/widgets/custom_pie_chart.dart';
import 'package:tender/features/dashboard/presentation/view/widgets/responsive_pie_charts.dart';
import 'package:tender/features/dashboard/presentation/view/widgets/side_bar.dart';
import '../../../../core/widgets/responsive.dart';
import '../../../../core/widgets/shimmer/upcoming_appointment_shimmer.dart';

class DashboardView extends StatelessWidget {
  DashboardView({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: ManagerColors.primaryColor,
          drawer: Responsive.isMobile(context)
              ? Drawer(
                  child: sideBar(
                    size: size,
                    controller: controller,
                  ),
                )
              : null,
          body: Row(
            children: [
              Responsive.isMobile(context)
                  ? IconButton(
                      onPressed: () {
                        _scaffoldKey.currentState?.openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: ManagerColors.white,
                      ),
                    )
                  : Expanded(
                      flex: Responsive.isTablet(context) ? 2 : 1,
                      child: sideBar(size: size, controller: controller),
                    ),
              Expanded(
                flex: 4,
                child: Container(
                  decoration: BoxDecoration(
                    color: ManagerColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(ManagerRadius.r25),
                      bottomLeft: Radius.circular(ManagerRadius.r25),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      ManagerWidth.w20,
                    ),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_04,
                        ),
                        Row(
                          children: [
                            Text(
                              ManagerStrings.overView,
                              style: getBoldTextStyle(
                                fontSize: Responsive.isMobile(context)
                                    ? ManagerFontSize.s24
                                    : ManagerFontSize.s30,
                                color: ManagerColors.black,
                              ),
                            ),
                            const Spacer(),
                            if (Responsive.isDesktop(context)) ...[
                              Flexible(
                                child: Container(
                                  constraints: BoxConstraints(
                                    maxWidth: Responsive.isTablet(context)
                                        ? size.width * 0.35
                                        : size.width * 0.25,
                                  ),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        ManagerRadius.r25),
                                    color: ManagerColors.lightPurple2
                                        .withOpacity(ManagerOpacity.op0_5),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: ManagerWidth.w15),
                                    child: textField(
                                      controller: TextEditingController(),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: ManagerStrings.search,
                                        hintStyle: getRegularTextStyle(
                                          fontSize: ManagerFontSize.s15,
                                          color: ManagerColors.primaryColor,
                                        ),
                                        suffixIcon: Padding(
                                          padding:
                                              EdgeInsets.all(ManagerWidth.w5),
                                          child: SvgPicture.asset(
                                              ManagerImages.search),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: ManagerWidth.w15),
                            ] else ...[
                              IconButton(
                                icon: SvgPicture.asset(
                                  ManagerImages.search,
                                  width: ManagerIconSize.s20,
                                  height: ManagerIconSize.s20,
                                ),
                                onPressed: () {},
                              ),
                              SizedBox(width: ManagerWidth.w8),
                            ],
                            SvgPicture.asset(
                              ManagerImages.notification,
                              width: Responsive.isMobile(context)
                                  ? ManagerIconSize.s20
                                  : ManagerIconSize.s20,
                            ),
                            SizedBox(
                              width: ManagerWidth.w15,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: Responsive.isMobile(context)
                                      ? ManagerRadius.r20
                                      : ManagerRadius.r25,
                                ),
                                if (!Responsive.isMobile(context)) ...[
                                  SizedBox(width: ManagerWidth.w8),
                                  Text(
                                    "doctor name",
                                    style: getRegularTextStyle(
                                      fontSize: ManagerFontSize.s13,
                                      color: ManagerColors.lightBlue,
                                    ),
                                  ),
                                ],
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.arrow_drop_down,
                                    color: ManagerColors.primaryColor,
                                    size: Responsive.isMobile(context)
                                        ? ManagerIconSize.s20
                                        : ManagerIconSize.s30,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * ManagerOpacity.op0_03,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: ManagerHeight.h25,
                          ),
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
                                        ManagerStrings
                                            .noUpcomingAppointmentsYet,
                                        style: getBoldTextStyle(
                                          fontSize: ManagerFontSize.s18,
                                          color: ManagerColors.grey,
                                        ),
                                      ),
                                    ],
                                  )
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ManagerHeight.h17,
                                    ),
                                    child: Column(
                                      children: List.generate(
                                        controller.upcomingAppointments.length,
                                        (index) {
                                          var model = controller
                                              .upcomingAppointments[index];
                                          return Container(
                                            height: size.height *
                                                ManagerOpacity.op0_09,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    ManagerColors.lightPurple2,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                ManagerRadius.r25,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                ManagerWidth.w8,
                                              ),
                                              child: Expanded(
                                                child: Row(
                                                  children: [
                                                    CircleAvatar(
                                                      radius: ManagerRadius.r25,
                                                      backgroundImage:
                                                          NetworkImage(
                                                        model.dependentImageUrl,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width *
                                                          ManagerOpacity.op0_01,
                                                    ),
                                                    Text(
                                                      model.dependentName,
                                                      style: getBoldTextStyle(
                                                        fontSize:
                                                         Responsive.isDesktop(context) ? ManagerFontSize
                                                             .s18
                                                             : ManagerFontSize.s12,
                                                        color: ManagerColors
                                                            .lightBlue,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: size.width *
                                                          ManagerOpacity.op0_07,
                                                    ),
                                                    Text(
                                                      DateFormat(
                                                              'dd MMM yyyy, hh:mm a')
                                                          .format(DateTime
                                                              .parse(model
                                                                  .appointmentTime)),
                                                      style: getBoldTextStyle(
                                                        fontSize:
                                                        Responsive.isDesktop(context) ? ManagerFontSize
                                                            .s18
                                                            : ManagerFontSize.s14,
                                                        color:
                                                            ManagerColors.black,
                                                      ),
                                                    ),
                                                    const Spacer(),
                                                    IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons.settings,
                                                        color: ManagerColors
                                                            .lightBlue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                        ResponsivePieCharts(
                          isColumn: Responsive.isMobile(context) ||
                              Responsive.isTablet(context),
                          controller: controller,
                        )
                      ],
                    ),
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

// Center(
// child: Container(
// width: size.width * ManagerOpacity.op0_25,
// height: size.height * ManagerOpacity.op0_25,
// decoration: BoxDecoration(
// // border: Border.all(color: ManagerColors.grayColor,),
// borderRadius: BorderRadius.circular(
// ManagerRadius.r12,
// ),
// ),
// child: Card(
// elevation: 2,
// child: Padding(
// padding: const EdgeInsets.all(16.0),
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.start,
// children: [
// Text(
// 'Product sold',
// style: Theme.of(context)
//     .textTheme
//     .titleSmall
//     ?.copyWith(
// fontWeight: FontWeight.w500,
// ),
// ),
// const SizedBox(height: 8),
// Text(
// "soldCount",
// style: Theme.of(context)
//     .textTheme
//     .headlineMedium
//     ?.copyWith(
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// Column(
// crossAxisAlignment:
// CrossAxisAlignment.end,
// children: [
// Row(
// children: [
// // Icon(
// //   _getPercentageIcon(),
// //   color: _getPercentageColor(),
// //   size: 16,
// // ),
// const SizedBox(width: 4),
// Text(
// "percentage",
// style: TextStyle(
// // color: _getPercentageColor(),
// fontWeight: FontWeight.bold,
// ),
// ),
// ],
// ),
// const SizedBox(height: 8),
// TextButton(
// onPressed: () {},
// child: const Text('View Report'),
// ),
// ],
// ),
// ],
// ),
// ),
// ),
// ),
// ),
