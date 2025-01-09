import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

// boy
//method lineChartBarData of y=3.8182*ln(x)+3.782
//method lineChartBarData of y=3.4693*ln(x)+3.4059
//method lineChartBarData of y=3.1113*ln(x)+3.0207
//method lineChartBarData of y=2.8107*ln(x)+2.6236
//method lineChartBarData of y=2.561*ln(x)+2.1886
//method lineChartBarData of y=2.3198*ln(x)+1.8911
//method lineChartBarData of y=2.1049*ln(x)+1.6098

// girl
//method lineChartBarData of y=3.8646*ln(x)+3.3047
//method lineChartBarData of y=3.4426*ln(x)+2.9676
//method lineChartBarData of y=3.0044*ln(x)+2.6595
//method lineChartBarData of y=2.6692*ln(x)+2.3008
//method lineChartBarData of y=2.4146*ln(x)+1.9394
//method lineChartBarData of y=2.157*ln(x)+1.6846
//method lineChartBarData of y=1.9491*ln(x)+1.3961

class LineDataBodyWeightModel {
  static final _listConstantBoy1 = [
    3.8182,
    3.4693,
    3.1113,
    2.8107,
    2.561,
    2.3198,
    2.1049,
  ];

  static final _listConstantBoy2 = [
    3.782,
    3.4059,
    3.0207,
    2.6236,
    2.1886,
    1.8911,
    1.6098,
  ];

  static final _listConstantGirl1 = [
    3.8646,
    3.4426,
    3.0044,
    2.6692,
    2.4146,
    2.157,
    1.9491,
  ];

  static final _listConstantGirl2 = [
    3.3047,
    2.9676,
    2.6595,
    2.3008,
    1.9394,
    1.6846,
    1.3961,
  ];

  static List<FlSpot> listDataLine({
    required int lineTo,
    bool isBoy = true,
  }) {
    List<FlSpot> list = [];
    final constant1 = isBoy
        ? (_listConstantBoy1[lineTo - 1])
        : (_listConstantGirl1[lineTo - 1]);
    final constant2 = isBoy
        ? (_listConstantBoy2[lineTo - 1])
        : (_listConstantGirl2[lineTo - 1]);
    for (int i = 0; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(constant1);
      Number const2 = Number(constant2);
      final exp = (const1 * Ln(x + Number(1))) + const2;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }
    return list;
  }

  //method data pasien
  static List<FlSpot> listDataPasienLine(List<CheckupModel> listData) {
    List<FlSpot> list = [];
    for (int i = 0; i < listData.length; i++) {
      final sumbuX = listData[i].month;
      if (sumbuX != null) {
        list.add(FlSpot(
            double.parse(sumbuX), listData[i].weight?.toDouble() ?? 0.0));
      }
    }
    list.sort((a, b) => a.x.compareTo(b.x));
    return list;
  }
}
