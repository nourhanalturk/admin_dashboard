import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/resources/manager_colors.dart';
import '../../../../../core/resources/manager_font_size.dart';
import '../../../../../core/resources/manager_height.dart';
import '../../../../../core/resources/manager_opacity.dart';
import '../../../../../core/resources/manager_strings.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../core/resources/manager_width.dart';
import '../../controller/dashboard_controller.dart';

Widget sideBar({
  required Size size,
  required DashboardController controller,
  double scale = 1.0,
}) {
  return Container(
    width: size.width * ManagerOpacity.op0_16 * scale,
    color: ManagerColors.primaryColor,
    child: Padding(
      padding: EdgeInsets.only(
        top: size.width * ManagerOpacity.op0_02 * scale,
        bottom: size.width * ManagerOpacity.op0_02 * scale,
      ),
      child: Column(
        children: [
          SizedBox(
            width: size.width * ManagerOpacity.op0_15 * scale,
            height: size.height * ManagerOpacity.op0_1 * scale,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: size.width * ManagerOpacity.op0_01 * scale,
                  child: Container(
                    width: size.width * ManagerOpacity.op0_03 * scale,
                    height: size.width * ManagerOpacity.op0_03 * scale,
                    decoration: const BoxDecoration(
                      color: ManagerColors.darkOrange,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * ManagerOpacity.op0_025 * scale,
                  child: Container(
                    width: size.width * ManagerOpacity.op0_04 * scale,
                    height: size.width * ManagerOpacity.op0_04 * scale,
                    decoration: const BoxDecoration(
                      color: ManagerColors.yellow,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Positioned(
                  left: size.width * 0.033 * scale,
                  child: Text(
                    ManagerStrings.doctorHunt,
                    style: TextStyle(
                      color: ManagerColors.white,
                      fontSize: ManagerFontSize.s30 * scale,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * ManagerOpacity.op0_03 * scale),
          Container(
            width: size.width * ManagerOpacity.op0_13 * scale,
            height: ManagerHeight.h1 * scale,
            color: ManagerColors.white.withOpacity(ManagerOpacity.op0_1),
          ),
          SizedBox(height: size.height * ManagerOpacity.op0_05 * scale),
          Expanded(
            child: ListView.builder(
              itemCount: controller.tabs.length,
              itemBuilder: (context, index) {
                bool isSelected = controller.selectedTabIndex == index;
                return Padding(
                  padding: EdgeInsets.all(8.0 * scale),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.white : Colors.transparent,
                      borderRadius: BorderRadius.circular(12 * scale),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          SvgPicture.asset(
                            controller.tabs[index].icon,
                            width: 20 * scale,
                            height: 20 * scale,
                            color: isSelected
                                ? ManagerColors.secondaryColor
                                : ManagerColors.white,
                          ),
                          SizedBox(width: ManagerWidth.w8 * scale),
                          Text(
                            controller.tabs[index].title,
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s15 * scale,
                              color: isSelected
                                  ? ManagerColors.secondaryColor
                                  : ManagerColors.white,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        controller.changeTabIndex(index);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
