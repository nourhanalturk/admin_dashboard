import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:tender/features/dashboard/presentation/view/widgets/side_bar.dart';

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
          key: _scaffoldKey, // Add key to scaffold
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
                  child: Center(
                    child: Text(
                      'Dashboard Content',
                      style: TextStyle(
                        color: ManagerColors.black,
                        fontSize: 24,
                      ),
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