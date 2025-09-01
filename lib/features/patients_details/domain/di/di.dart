import 'package:get/get.dart';
import 'package:tender/features/patients_details/presentation/controller/patients_details_controller.dart';

initPatientsDetails() {
  if (!Get.isRegistered<PatientsDetailsController>()) {
    Get.put<PatientsDetailsController>(PatientsDetailsController());
  }
}

disposePatientsDetails() {
  if (Get.isRegistered<PatientsDetailsController>()) {
    Get.delete<PatientsDetailsController>();
  }
}
