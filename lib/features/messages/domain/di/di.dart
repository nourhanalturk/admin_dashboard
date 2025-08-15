import 'package:get/get.dart';
import 'package:tender/features/messages/presentation/controller/messages_controller.dart';

initMessages() {
  if (!Get.isRegistered<MessagesController>()) {
    Get.put<MessagesController>(MessagesController());
  }
}

disposeMessages() {
  if (Get.isRegistered<MessagesController>()) {
    Get.delete<MessagesController>();
  }
}