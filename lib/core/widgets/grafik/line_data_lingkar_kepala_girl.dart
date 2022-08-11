// ignore_for_file: file_names

import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

class LineDataLingkarKepalaGirlModel {
  //method lineChartBarData of y = -0,028x2 + 1,1177x + 35,405
  List<FlSpot> listDataLine1() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.028);
      Number const2 = Number(1.1177);
      Number const3 = Number(35.405);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0298x2 + 1,1873x + 39,082
  List<FlSpot> listDataLine2() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0298);
      Number const2 = Number(1.1873);
      Number const3 = Number(39.082);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0292x2 + 1,1645x + 37,86
  List<FlSpot> listDataLine3() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0292);
      Number const2 = Number(1.1645);
      Number const3 = Number(37.86);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0287x2 + 1,1414x + 36,63
  List<FlSpot> listDataLine4() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0287);
      Number const2 = Number(1.1414);
      Number const3 = Number(36.63);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0272x2 + 1,0903x + 34,193
  List<FlSpot> listDataLine5() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0272);
      Number const2 = Number(1.0903);
      Number const3 = Number(34.193);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0269x2 + 1,0756x + 32,922
  List<FlSpot> listDataLine6() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0269);
      Number const2 = Number(1.0756);
      Number const3 = Number(32.922);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0263x2 + 1,0515x + 31,705
  List<FlSpot> listDataLine7() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0263);
      Number const2 = Number(1.0515);
      Number const3 = Number(31.705);
      final exp = (const1 * x * x) + (const2 * x) + const3;
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
