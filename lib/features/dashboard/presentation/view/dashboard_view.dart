import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/features/appointment/domain/di/di.dart';
import 'package:tender/features/appointment/presentation/view/appointment_view.dart';
import 'package:tender/features/available_times/domain/di/di.dart';
import 'package:tender/features/available_times/presentation/view/available_times_view.dart';
import 'package:tender/features/chats/domain/di/di.dart';
import 'package:tender/features/chats/presentation/view/chats_view.dart';
import 'package:tender/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:tender/features/dashboard/presentation/view/widgets/over_view.dart';
import 'package:tender/features/dashboard/presentation/view/widgets/side_bar.dart';
import 'package:tender/features/patients_details/domain/di/di.dart';
import 'package:tender/features/patients_details/presentation/view/patients_details_view.dart';
import '../../../../core/widgets/responsive.dart';

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
                child: GetBuilder<DashboardController>(
                  builder: (controller) {
                    Widget content;
                    switch (controller.selectedTabIndex) {
                      case 0:
                        content = const OverviewView();
                        break;
                      case 1:
                        initChats();
                        content = const ChatsView();
                        break;
                      case 2:
                        initAppointments();
                        content = const AppointmentsView();
                        break;
                      case 3:
                        initAvailableTimes();
                        content = const AvailableTimesView();
                      case 4:
                        initPatientsDetails();
                        content = const PatientsDetailsView();
                        break;
                      default:
                        content = const Center(child: Text("Coming Soon"));
                    }

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Container(
                        key: ValueKey(controller.selectedTabIndex),
                        decoration: BoxDecoration(
                          color: ManagerColors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ManagerRadius.r25),
                            bottomLeft: Radius.circular(ManagerRadius.r25),
                          ),
                        ),
                        padding: EdgeInsets.all(ManagerWidth.w20),
                        child: content,
                      ),
                    );
                  },
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
