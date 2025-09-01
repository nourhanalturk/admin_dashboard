import 'package:get/get.dart';

import '../../presentation/controller/appointment_controller.dart';

initAppointments(){
  if(!Get.isRegistered<AppointmentController>()) {
    Get.put<AppointmentController>(AppointmentController());
  }
}
disposeAppointments(){
  if(Get.isRegistered<AppointmentController>()) {
    Get.delete<AppointmentController>();
  }
}