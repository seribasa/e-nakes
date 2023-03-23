// ignore_for_file: use_key_in_widget_constructors

import 'package:eimunisasi_nakes/core/widgets/grafik/line_data_berat_badan.dart';
import 'package:eimunisasi_nakes/core/widgets/grafik/line_data_lingkar_kepala.dart';
import 'package:eimunisasi_nakes/core/widgets/grafik/line_data_tinggi_badan.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../features/rekam_medis/data/models/pemeriksaan_model.dart';

enum LineChartType {
  beratBadan,
  tinggiBadan,
  lingkarKepala,
}

class LineChartTemplate extends StatelessWidget {
  final LineChartType type;
  final double? minX;
  final double? maxX;
  final double? minY;
  final double? maxY;
  final bool? isBoy;
  final List<PemeriksaanModel> listData;
  const LineChartTemplate({
    Key? key,
    required this.type,
    required this.isShowingMainData,
    required this.minX,
    required this.maxX,
    this.minY,
    this.maxY,
    required this.isBoy,
    required this.listData,
  });

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return LineChart(
      sampleData,
      swapAnimationDuration: const Duration(milliseconds: 100),
    );
  }

  List<FlSpot> spots({required int lineTo}) {
    if (type == LineChartType.beratBadan) {
      return LineDataBodyWeightModel.listDataLine(
        lineTo: lineTo,
        isBoy: isBoy ?? true,
      );
    } else if (type == LineChartType.tinggiBadan) {
      return LineDataBodyHeightModel.listDataLine(
        lineTo: lineTo,
        isBoy: isBoy ?? true,
      );
    } else if (type == LineChartType.lingkarKepala) {
      return LineDataHeadCircumferenceModel.listDataLine(
        lineTo: lineTo,
        isBoy: isBoy ?? true,
      );
    }
    return [];
  }

  LineChartData get sampleData => LineChartData(
        minX: 0,
        maxX: maxX,
        maxY: maxY != null ? (maxY! + maxY! * 0.1) : null,
        clipData: FlClipData.all(),
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
      );

  LineTouchData get lineTouchData => LineTouchData(
        touchCallback: (event, res) {
          if (event is FlTapDownEvent) {
            //show modal flutter

            // res?.lineBarSpots?.forEach((spot) {
            //   print('x: ${spot.x} y: ${spot.y}');
            //   print(spot.bar.color);
            // });
          }
        },
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> indicators) {
          return indicators.map(
            (int index) {
              final line = FlLine(
                  color: Colors.black, strokeWidth: 1, dashArray: [4, 2]);
              return TouchedSpotIndicatorData(
                line,
                FlDotData(show: false),
              );
            },
          ).toList();
        },
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          fitInsideHorizontally: true,
          tooltipMargin: 0,
          tooltipRoundedRadius: 20,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((LineBarSpot touchedSpot) {
              if (touchedSpot.bar.color == Colors.black) {
                return LineTooltipItem(
                  '(${touchedSpot.y})',
                  TextStyle(
                    color: touchedSpot.bar.gradient?.colors.first ??
                        touchedSpot.bar.color ??
                        Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                );
              }
            }).toList();
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData {
    List<LineChartBarData> barDataList = [
      lineChartBarData_1,
      lineChartBarData_2,
      lineChartBarData_3,
      lineChartBarData_4,
      lineChartBarData_5,
      lineChartDataPasien,
    ];

    if (type != LineChartType.tinggiBadan) {
      barDataList.addAll([lineChartBarData_6, lineChartBarData_7]);
    }
    return barDataList;
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    return Text(value.toInt().toString(),
        style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 10,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    return Padding(
        child: Text(value.toInt().toString(), style: style),
        padding: const EdgeInsets.only(top: 10.0));
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(width: 2),
          left: BorderSide(width: 2),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData_1 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color.fromARGB(108, 136, 32, 255),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots(lineTo: 1),
      );

  LineChartBarData get lineChartBarData_2 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color.fromARGB(199, 25, 0, 255),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots(lineTo: 2),
      );

  LineChartBarData get lineChartBarData_3 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color.fromARGB(68, 0, 170, 255),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots(lineTo: 3),
      );

  LineChartBarData get lineChartBarData_4 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color.fromARGB(68, 0, 255, 98),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots(lineTo: 4),
      );

  LineChartBarData get lineChartBarData_5 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color.fromARGB(68, 255, 251, 0),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: spots(lineTo: 5),
      );

  LineChartBarData get lineChartBarData_6 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color.fromARGB(68, 255, 174, 0),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: type == LineChartType.tinggiBadan ? null : spots(lineTo: 6),
      );

  LineChartBarData get lineChartBarData_7 => LineChartBarData(
        isCurved: true,
        curveSmoothness: 0,
        color: const Color.fromARGB(68, 255, 39, 23),
        barWidth: 1,
        isStrokeCapRound: true,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: type == LineChartType.tinggiBadan ? null : spots(lineTo: 7),
      );

  LineChartBarData get lineChartDataPasien => LineChartBarData(
      isCurved: true,
      curveSmoothness: 0,
      color: Colors.black,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: () {
        switch (type) {
          case LineChartType.tinggiBadan:
            return LineDataBodyHeightModel.listDataPasienLine(listData);
          case LineChartType.beratBadan:
            return LineDataBodyWeightModel.listDataPasienLine(listData);
          default:
            return LineDataHeadCircumferenceModel.listDataPasienLine(listData);
        }
      }());
}
