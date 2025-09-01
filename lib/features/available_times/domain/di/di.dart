import 'package:get/get.dart';
import '../../presentation/controller/available_times_controller.dart';

initAvailableTimes() {
  if (!Get.isRegistered<AvailableTimesController>()) {
    Get.put<AvailableTimesController>(AvailableTimesController());
  }
}

disposeAvailableTimes() {
  if (Get.isRegistered<AvailableTimesController>()) {
    Get.delete<AvailableTimesController>();
  }
}
