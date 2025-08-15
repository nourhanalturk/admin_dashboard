import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tender/core/cache/app_cache.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_icons.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/widgets/text_field.dart';
import 'package:tender/features/messages/domain/di/di.dart';
import 'package:tender/features/messages/presentation/controller/messages_controller.dart';
import 'package:tender/features/messages/presentation/view/widget/message_item.dart';

import '../../../../core/resources/manager_font_size.dart';
import '../../../../core/resources/manager_height.dart';
import '../../../../core/resources/manager_radius.dart';
import '../../../../core/resources/manager_styles.dart';

class MessagesView extends StatelessWidget {
  const MessagesView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return GetBuilder<MessagesController>(
      builder: (controller) {
        return Scaffold(
          body: Column(
            children: [
              Container(
                height: size.height * ManagerOpacity.op0_09,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ManagerColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      ManagerRadius.r25,
                    ),
                    bottomRight: Radius.circular(
                      ManagerRadius.r25,
                    ),
                  ),
                ),
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            disposeMessages();
                            Get.back();
                          },
                          icon: Icon(
                            ManagerIcons.arrowBackIos,
                            color: ManagerColors.white,
                          )),
                      Text(
                        CacheData.patientName,
                        style: getBoldTextStyle(
                          fontSize: ManagerFontSize.s25,
                          color: ManagerColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.messages.length,
                  itemBuilder: (context, index) {
                    var model = controller.messages[index];
                    return messageItem(
                      isSender: model.isSender,
                      message: model.message,
                    );
                  },
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * ManagerOpacity.op0_1,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      ManagerRadius.r50,
                    ),
                    topRight: Radius.circular(
                      ManagerRadius.r50,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: size.width * ManagerOpacity.op0_7,
                      height: size.height * ManagerOpacity.op0_09,
                      child: textField(
                        controller: controller.messageController,
                        borderColor: ManagerColors.primaryColor,
                      ),
                    ),
                    Container(
                      width: size.width * ManagerOpacity.op0_2,
                      height: size.height * ManagerOpacity.op0_05,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: ManagerColors.primaryColor,
                      ),
                      child: IconButton(
                        onPressed: () {
                          controller.sendMessage();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: ManagerColors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
