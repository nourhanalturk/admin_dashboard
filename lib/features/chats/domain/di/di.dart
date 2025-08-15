import 'package:get/get.dart';

import '../../presentation/controller/chats_controller.dart';

initChats(){
  if(!Get.isRegistered<ChatsController>()) {
    Get.put<ChatsController>(ChatsController());
  }
}

disposeChats() {
  if(Get.isRegistered<ChatsController>()) {
    Get.delete<ChatsController>();
  }
}