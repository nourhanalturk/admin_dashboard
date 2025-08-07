import 'package:flutter/material.dart';
import 'package:tender/features/dashboard/presentation/view/widgets/custom_pie_chart.dart';

import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../controller/dashboard_controller.dart';

class ResponsivePieCharts extends StatelessWidget {
  final bool isColumn;
  final DashboardController controller;

  const ResponsivePieCharts({
    super.key,
    required this.isColumn,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final pieCharts = [
      CustomPieChart(
        title: ManagerStrings.patientsWhoBooked,
        dataMap: {
          "Booked": controller.totalPatientsWithAppointments.toDouble(),
          "Not Booked": (controller.totalPatients - controller.totalPatientsWithAppointments).toDouble(),
        },
        colorList: const [
          ManagerColors.primaryColor,
          ManagerColors.redColor,
        ],
      ),
      CustomPieChart(
        title: ManagerStrings.patientsWithUpcomingAppointments,
        dataMap: {
          "Upcoming": controller.totalPatientsWithUpcomingAppointments.toDouble(),
          "None": (controller.totalPatients - controller.totalPatientsWithUpcomingAppointments).toDouble(),
        },
        colorList: const [
          ManagerColors.greenColor,
          ManagerColors.lightGrey,
        ],
      ),
      CustomPieChart(
        title: ManagerStrings.patientsWhoMessagedDoctor,
        dataMap: {
          "Messaged": controller.totalPatientsWithMessages.toDouble(),
          "Did Not Message": (controller.totalPatients - controller.totalPatientsWithMessages).toDouble(),
        },
        colorList: const [
          ManagerColors.darkOrange,
          ManagerColors.grey,
        ],
      ),
    ];

    if (isColumn) {
      return Column(
        children: pieCharts
            .map((chart) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: chart,
        ))
            .toList(),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: pieCharts
            .map((chart) => Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: chart,
          ),
        ))
            .toList(),
      );
    }
  }
}
