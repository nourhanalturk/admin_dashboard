import 'package:get/get.dart';
import 'package:tender/features/dashboard/presentation/controller/dashboard_controller.dart';

initDashboard(){
  if(!Get.isRegistered<DashboardController>()) {
    Get.put(DashboardController());
  }
}
disableDashboard() {
  if(Get.isRegistered<DashboardController>()) {
    Get.delete<DashboardController>();
  }
}