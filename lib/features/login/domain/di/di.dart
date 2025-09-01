import 'package:get/get.dart';
import 'package:tender/features/login/presentation/controller/login_controller.dart';

initLogin(){
  if(!Get.isRegistered<LoginController>()) {
    Get.put<LoginController>(LoginController());
  }
}
disableLogin() {
  if(Get.isRegistered<LoginController>()) {
    Get.delete<LoginController>();
  }
}