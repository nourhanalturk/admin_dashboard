import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_images.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_radius.dart';
import 'package:tender/core/resources/manager_strings.dart';
import 'package:tender/core/resources/manager_styles.dart';
import 'package:tender/core/widgets/responsive.dart';
import 'package:tender/features/login/presentation/controller/login_controller.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
        return Scaffold(
          body: Center(
            child: Responsive(
              mobile: _buildLoginCard(context,
                  widthFactor: ManagerOpacity.op0_9, controller: controller),
              tablet: _buildLoginCard(context,
                  widthFactor: ManagerOpacity.op0_6, controller: controller),
              desktop: _buildLoginCard(context,
                  widthFactor: ManagerOpacity.op0_4, controller: controller),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginCard(BuildContext context,
      {required double widthFactor, required LoginController controller}) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * widthFactor,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: ManagerColors.white,
        borderRadius: BorderRadius.circular(ManagerRadius.r20),
        boxShadow: [
          BoxShadow(
            color: ManagerColors.grayColor.withOpacity(0.2),
            blurRadius: ManagerRadius.r12,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SvgPicture.asset(
              ManagerImages.logo,
            ),
            SizedBox(
              height: ManagerHeight.h20,
            ),
            Text(
              ManagerStrings.login,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s24,
                color: ManagerColors.black,
              ),
            ),
            SizedBox(
              height: ManagerHeight.h30,
            ),
            TextField(
              controller: controller.idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: ManagerStrings.enterYourId,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ManagerRadius.r12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ManagerHeight.h16,
            ),
            TextField(
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: ManagerStrings.enterYourPhone,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    ManagerRadius.r12,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: ManagerHeight.h24,
            ),
            ElevatedButton(
              onPressed: controller.isLoading
                  ? null
                  : () async {
                      final success = await controller.loginDoctor();
                      if (success) {
                        controller.navigateToDashboard();
                      } else {
                        Get.snackbar(ManagerStrings.cacheError,
                            ManagerStrings.invalidPhoneOrId);
                      }
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    ManagerRadius.r12,
                  ),
                ),
                backgroundColor: ManagerColors.primaryColor,
              ),
              child: controller.isLoading
                  ? const CircularProgressIndicator(
                      color: ManagerColors.white,
                    )
                  : Text(
                      ManagerStrings.login,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s18,
                        color: ManagerColors.white,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
