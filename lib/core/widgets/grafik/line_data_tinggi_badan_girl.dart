// ignore_for_file: file_names

import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

class LineDataTinggiBadanGirlModel {
  //method lineChartBarData of y=-0,0382x2 + 2,3875x + 56,098
  List<FlSpot> listDataLine1() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0382);
      Number const2 = Number(2.3875);
      Number const3 = Number(56.098);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,038x2 + 2,3339x + 54,522
  List<FlSpot> listDataLine2() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.038);
      Number const2 = Number(2.3339);
      Number const3 = Number(54.522);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0377x2 + 2,2696x + 52,583
  List<FlSpot> listDataLine3() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0377);
      Number const2 = Number(2.2696);
      Number const3 = Number(52.583);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0375x2 + 2,2102x + 50,6
  List<FlSpot> listDataLine4() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0375);
      Number const2 = Number(2.2102);
      Number const3 = Number(50.6);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0378x2 + 2,172x + 48,94
  List<FlSpot> listDataLine5() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0378);
      Number const2 = Number(2.172);
      Number const3 = Number(48.94);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method data pasien
  List<FlSpot> listDataPasienLine(List<PemeriksaanModel> listData) {
    List<FlSpot> list = [];
    for (int i = 1; i <= listData.length; i++) {
      list.add(
          FlSpot(i.toDouble(), listData[i - 1].beratBadan?.toDouble() ?? 0.0));
    }
    return list;
  }
}
