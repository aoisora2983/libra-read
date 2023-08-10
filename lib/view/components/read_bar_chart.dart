import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:libra_read/model/database/database.dart';
import 'package:provider/provider.dart';

class MonthlyReadBarChart extends StatefulWidget {
  const MonthlyReadBarChart({super.key});

  @override
  State<StatefulWidget> createState() => MonthlyReadBarChartState();
}

class MonthlyReadBarChartState extends State<MonthlyReadBarChart> {
  ColorScheme? colorScheme;
  List<String> months = [];

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    return FutureBuilder(
        future: getBarGroup(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data.length > 0) {
            double maxY = 0;

            for (BarChartGroupData barChartGroupData in snapshot.data) {
              for (BarChartRodData barChartRodData
                  in barChartGroupData.barRods) {
                maxY = max(barChartRodData.toY, maxY);
              }
            }

            return Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 350),
                child: AspectRatio(
                  aspectRatio: 1.6,
                  child: BarChart(
                    BarChartData(
                      barTouchData: barTouchData,
                      titlesData: titlesData,
                      borderData: borderData,
                      barGroups: snapshot.data,
                      gridData: const FlGridData(show: false),
                      alignment: BarChartAlignment.spaceAround,
                      maxY: maxY + 10,
                    ),
                  ),
                ),
              ),
            );
          }
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 36),
            child: Center(
              child: Text('まだ読んだ本がありません。\n読み終わった本を「+」ボタンを押して、\n登録してみましょう！'),
            ),
          );
        });
  }

  Future<List<BarChartGroupData>> getBarGroup() async {
    final database = Provider.of<AppDatabase>(context, listen: false);
    Map histories = await database.historiesReadDao.getHistoryReadList();

    List<BarChartGroupData> list = [];
    List<String> tmpMonths = [];

    histories.forEach((year, monthList) {
      String tmpYear = '$year年';
      for (int index = 0; index < monthList.length; index++) {
        var monthMap = monthList[index];
        monthMap.forEach((month, count) {
          String yearMonth = '$tmpYear$month月';
          tmpYear = '';
          tmpMonths.add(yearMonth);

          list.add(BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: count,
                gradient: _barsGradient,
              )
            ],
            showingTooltipIndicators: [0],
          ));
        });
      }
    });
    months = tmpMonths;

    return list;
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              TextStyle(
                color: colorScheme?.onPrimaryContainer,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: colorScheme?.onPrimaryContainer,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    String text;

    text = months[value.toInt()];

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          colorScheme?.inversePrimary ?? Colors.blue,
          colorScheme?.inversePrimary ?? Colors.cyan,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );
}
