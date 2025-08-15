import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:tender/core/resources/manager_colors.dart';
import 'package:tender/core/resources/manager_font_size.dart';

import '../../../../../core/resources/manager_height.dart';
import '../../../../../core/resources/manager_icon_size.dart';
import '../../../../../core/resources/manager_opacity.dart';
import '../../../../../core/resources/manager_radius.dart';
import '../../../../../core/resources/manager_styles.dart';
import '../../../../../core/resources/manager_width.dart';

class CustomPieChart extends StatelessWidget {
  final Map<String, double> dataMap;
  final String title;
  final List<Color> colorList;

  const CustomPieChart({
    super.key,
    required this.dataMap,
    required this.title,
    required this.colorList,
  });

  @override
  Widget build(BuildContext context) {
    final totalValue = dataMap.values.reduce((a, b) => a + b);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ManagerRadius.r16),
        side: BorderSide(
          color: ManagerColors.lightPurple2.withOpacity(ManagerOpacity.op0_1),
          width: 1,
        ),
      ),
      shadowColor: ManagerColors.primaryColor.withOpacity(ManagerOpacity.op0_2),
      child: Padding(
        padding: EdgeInsets.all(ManagerWidth.w15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w15,
                      vertical: ManagerHeight.h6,
                    ),
                    decoration: BoxDecoration(
                      color: ManagerColors.primaryColor
                          .withOpacity(ManagerOpacity.op0_1),
                      borderRadius: BorderRadius.circular(ManagerRadius.r12),
                    ),
                    child: Text(
                      title,
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.more_vert,
                    color: ManagerColors.grey, size: ManagerIconSize.s20),
              ],
            ),
            SizedBox(height: ManagerHeight.h16),
            Center(
              child: SizedBox(
                width: 180,
                height: 180,
                child: Stack(
                  children: [
                    PieChart(
                      dataMap: dataMap,
                      animationDuration: const Duration(milliseconds: 1200),
                      chartType: ChartType.ring,
                      chartRadius: 90,
                      ringStrokeWidth: 22,
                      colorList: colorList,
                      legendOptions: const LegendOptions(showLegends: false),
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesInPercentage: true,
                        showChartValues: true,
                        decimalPlaces: 1,
                        chartValueStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            totalValue.toStringAsFixed(0),
                            style: getBoldTextStyle(
                              fontSize: ManagerFontSize.s24,
                              color: ManagerColors.primaryColor,
                            ),
                          ),
                          Text(
                            'Total',
                            style: getRegularTextStyle(
                              fontSize: ManagerFontSize.s14,
                              color: ManagerColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ManagerHeight.h16),
            // FIXED LEGEND SECTION - No more overflow
            ...dataMap.entries.map((entry) {
              final percentage =
                  (entry.value / totalValue * 100).toStringAsFixed(1);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: ManagerHeight.h6),
                child: Row(
                  children: [
                    Container(
                      width: ManagerWidth.w15,
                      height: ManagerHeight.h12,
                      decoration: BoxDecoration(
                        color:
                            colorList[dataMap.keys.toList().indexOf(entry.key)],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: ManagerWidth.w8),
                    Expanded(
                      child: Text(
                        entry.key,
                        style: getMediumTextStyle(
                          fontSize: ManagerFontSize.s14,
                          color: ManagerColors.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$percentage%',
                      style: getBoldTextStyle(
                        fontSize: ManagerFontSize.s14,
                        color: ManagerColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
