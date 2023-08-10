import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

//
class ReadCompletePieChart extends StatefulWidget {
  const ReadCompletePieChart({
    super.key,
    required this.goalReadCount,
    required this.nowReadCount,
  });

  final int goalReadCount;
  final int nowReadCount;

  @override
  State<ReadCompletePieChart> createState() => ReadCompletePieChartState();
}

class ReadCompletePieChartState extends State<ReadCompletePieChart> {
  ColorScheme? colorScheme;
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    // 画面幅 / 5のサイズにするが、タブレットを考慮しmaxは300とする
    double centerSpaceRadius = MediaQuery.of(context).size.width / 6;
    if (centerSpaceRadius > 100) {
      centerSpaceRadius = 100;
    }

    return PieChart(
      PieChartData(
        pieTouchData: PieTouchData(
          touchCallback: (FlTouchEvent event, pieTouchResponse) {
            setState(() {
              if (!event.isInterestedForInteractions ||
                  pieTouchResponse == null ||
                  pieTouchResponse.touchedSection == null) {
                touchedIndex = -1;
                return;
              }
              touchedIndex =
                  pieTouchResponse.touchedSection!.touchedSectionIndex;
            });
          },
        ),
        borderData: FlBorderData(
          show: false,
        ),
        sectionsSpace: 0, // セクション表示させない
        startDegreeOffset: 270, // 開始回転位置を12時からにする
        centerSpaceRadius: centerSpaceRadius, // 中心の穴あきサイズ
        sections: showingSections(context),
      ),
    );
  }

  List<PieChartSectionData> showingSections(context) {
    int goal = widget.goalReadCount;
    int now = widget.nowReadCount;

    int unRead = goal - now;

    if (unRead < 0) {
      // 目標を超えていてマイナスになる場合
      unRead = 0;
    }

    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 70.0 : 60.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: colorScheme?.inversePrimary,
            value: now.toDouble(),
            title: '$now冊',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.black12,
            value: unRead.toDouble(),
            title: '$unRead冊',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          );
        default:
          throw Error();
      }
    });
  }
}
