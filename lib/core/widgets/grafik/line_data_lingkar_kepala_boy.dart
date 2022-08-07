// ignore_for_file: file_names

import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

class LineDataLingkarKepalaBoyModel {
  //method lineChartBarData of y = -0,0307x^2 + 1.2168x + 39.792
  List<FlSpot> listDataLine1() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0307);
      Number const2 = Number(1.2168);
      Number const3 = Number(39.792);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0305x^2 + 1.2059x + 38.565
  List<FlSpot> listDataLine2() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0305);
      Number const2 = Number(1.2059);
      Number const3 = Number(38.565);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData ofy = -0,0304x2 + 1,1935x + 37,36
  List<FlSpot> listDataLine3() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0304);
      Number const2 = Number(1.1935);
      Number const3 = Number(37.36);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0303x2 + 1,1827x + 36,133
  List<FlSpot> listDataLine4() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0303);
      Number const2 = Number(1.1827);
      Number const3 = Number(36.133);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData ofy = -0,0303x2 + 1,1713x + 34,955
  List<FlSpot> listDataLine5() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0303);
      Number const2 = Number(1.1713);
      Number const3 = Number(34.955);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0303x2 + 1,1642x + 33,702
  List<FlSpot> listDataLine6() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0303);
      Number const2 = Number(1.1642);
      Number const3 = Number(33.702);
      final exp = ((const1 * x) * (const1 * x)) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0303x2 + 1,1565x + 32,502
  List<FlSpot> listDataLine7() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0303);
      Number const2 = Number(1.1565);
      Number const3 = Number(32.502);
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
      list.add(FlSpot(
          i.toDouble(), listData[i - 1].lingkarKepala?.toDouble() ?? 0.0));
    }
    return list;
  }
}
