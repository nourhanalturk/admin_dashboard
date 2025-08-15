import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';
import 'package:tender/core/resources/manager_height.dart';
import 'package:tender/core/resources/manager_opacity.dart';
import 'package:tender/core/resources/manager_width.dart';
import 'package:tender/core/widgets/main_button.dart';
import '../resources/manager_styles.dart';

class EmptyStateWidget extends StatelessWidget {
  final String appBarTitle;
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;
  final String svgAssetPath;

  const EmptyStateWidget({
    super.key,
    required this.appBarTitle,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
    required this.svgAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(Get.context!).size;

    return Scaffold(
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.s,
          children: [
            Padding(
              padding: EdgeInsets.only(
               top: ManagerHeight.h20,
                left:ManagerHeight.h20,
                right:ManagerHeight.h20,
              ),
              child: Container(
                // appBarTitle: appBarTitle,
              ),
            ),
            Container(
              width: size.width * ManagerOpacity.op0_7,
              height: size.height * ManagerOpacity.op0_5,
              decoration: BoxDecoration(
                color: ManagerColors.primaryColor
                    .withOpacity(ManagerOpacity.op0_2),
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                svgAssetPath,
                width: size.width * 0.4,
                height: size.width * 0.4,
              ),
            ),
            Text(
              title,
              style: getBoldTextStyle(
                fontSize: ManagerFontSize.s30,
                color: ManagerColors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: ManagerHeight.h15,
            ),
            Text(
              subtitle,
              style: getRegularTextStyle(
                fontSize: ManagerFontSize.s15,
                color: ManagerColors.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(ManagerWidth.w20),
              child: mainButton(
                height: size.height * ManagerOpacity.op0_07,
                onPressed: onPressed,
                buttonText: buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
