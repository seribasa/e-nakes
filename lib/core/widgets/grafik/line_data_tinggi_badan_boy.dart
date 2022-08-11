import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

class LineDataTinggiBadanBoyModel {
  //method lineChartBarData of y = -0,0408x2 + 2,4416x + 57,286
  List<FlSpot> listDataLine1() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0408);
      Number const2 = Number(2.4416);
      Number const3 = Number(57.286);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0413x2 + 2,414x + 55,678
  List<FlSpot> listDataLine2() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0413);
      Number const2 = Number(2.414);
      Number const3 = Number(55.678);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0423x2 + 2,3877x + 53,652
  List<FlSpot> listDataLine3() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0423);
      Number const2 = Number(2.3877);
      Number const3 = Number(53.652);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0431x2 + 2,3589x + 51,644
  List<FlSpot> listDataLine4() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0431);
      Number const2 = Number(2.3589);
      Number const3 = Number(51.644);
      final exp = (const1 * x * x) + (const2 * x) + const3;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method lineChartBarData of y = -0,0439x2 + 2,3398x + 49,978
  List<FlSpot> listDataLine5() {
    List<FlSpot> list = [];
    for (int i = 1; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(-0.0439);
      Number const2 = Number(2.3398);
      Number const3 = Number(49.978);
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
      list.add(
          FlSpot(i.toDouble(), listData[i - 1].tinggiBadan?.toDouble() ?? 0.0));
    }
    return list;
  }
}
