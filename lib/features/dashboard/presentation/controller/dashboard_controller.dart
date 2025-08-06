import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/features/dashboard/domain/model/tab_model.dart';

import '../../../../core/resources/manager_strings.dart';

class DashboardController extends GetxController{

  int selectedTabIndex = 0;
  bool isSidebarOpen = false;
  List<TabModel> tabs = [
    TabModel(
      icon: ManagerImages.home,
      title: ManagerStrings.home,
    ),
    TabModel(
      icon: ManagerImages.chat,
      title: ManagerStrings.chat,
    ),
    TabModel(
      icon: ManagerImages.appointment,
      title: ManagerStrings.viewAppointments,
    ),
    TabModel(
      icon: ManagerImages.clock,
      title: ManagerStrings.editAvailableTimes,
    ),
    TabModel(
      icon: ManagerImages.data,
      title: ManagerStrings.patientsData,
    ),
  ];



  void changeTabIndex(int index) {
    selectedTabIndex = index;
    update();
  }


  void toggleSidebar() {
    isSidebarOpen = !isSidebarOpen;
    update();
  }

  void closeSidebar() {
    isSidebarOpen = false;
    update();
  }

  @override
  void dispose() {
    super.dispose();
  }



}