import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF4233B6), // primaryColor
          ),
        ),
        const SizedBox(height: 10),
        PieChart(
          dataMap: dataMap,
          animationDuration: const Duration(milliseconds: 1200),
          chartType: ChartType.ring,
          chartRadius: 120,
          ringStrokeWidth: 22,
          colorList: colorList,
          legendOptions: const LegendOptions(
            showLegendsInRow: false,
            legendPosition: LegendPosition.right,
            showLegends: true,
          ),
          chartValuesOptions: const ChartValuesOptions(
            showChartValuesInPercentage: true,
            showChartValues: true,
            decimalPlaces: 1,
          ),
        ),
      ],
    );
  }
}
