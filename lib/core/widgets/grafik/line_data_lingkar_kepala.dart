// ignore_for_file: file_names

import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';
// Boy
//method lineChartBarData of y = 0,00000721x5 - 0,00055096x4 + 0,01688394x3 - 0,27192347x2 + 2,63126903x + 37,78553641
//method lineChartBarData of y = 0,00000819x5 - 0,00061770x4 + 0,01854033x3 - 0,28971686x2 + 2,69602649x + 36,49431684
//method lineChartBarData of y = 0,00000906x5 - 0,00067693x4 + 0,02002894x3 - 0,30609367x2 + 2,75838731x + 35,19629667
//method lineChartBarData of y = 0,00000973x5 - 0,00071813x4 + 0,02095051x3 - 0,31507558x2 + 2,78335970x + 33,94425959
//method lineChartBarData of y = 0,00000977x5 - 0,00071947x4 + 0,02098946x3 - 0,31613969x2 + 2,78348667x + 32,73469469
//method lineChartBarData of y = 0,00001121x5 - 0,00081471x4 + 0,02326989x3 - 0,33948538x2 + 2,86775428x + 31,40958799
//method lineChartBarData of y = 0,00001113x5 - 0,00081778x4 + 0,02355179x3 - 0,34454875x2 + 2,88741952x + 30,15595154

// Girl
//method lineChartBarData of y = 0,00000818x5 - 0,00061260x4 + 0,01816480x3 - 0,27842781x2 + 2,53981612x + 33,44617271
//method lineChartBarData of y = 0,00000767x5 - 0,00058298x4 + 0,01765221x3 - 0,27850528x2 + 2,62746400x + 37,06022569 R² = 0,99976359
//method lineChartBarData of y = 0,00000838x5 - 0,00062466x4 + 0,01849628x3 - 0,28462621x2 + 2,62032518x + 35,84568666
//method lineChartBarData of y = 0,00000911x5 - 0,00067119x4 + 0,01952798x3 - 0,29314885x2 + 2,62238884x + 34,61361672
//method lineChartBarData of y = 0,00000847x5 - 0,00062752x4 + 0,01836595x3 - 0,27725656x2 + 2,49592593x + 32,27184983
//method lineChartBarData of y = 0,00000955x5 - 0,00069062x4 + 0,01965735x3 - 0,28787021x2 + 2,51369006x + 30,98830812
//method lineChartBarData of y = 0,00000955x5 - 0,00069061x4 + 0,01961847x3 - 0,28582585x2 + 2,47565050x + 29,79702364

class LineDataHeadCircumferenceModel {
  static final _listConstantBoy1 = [
    0.00000721,
    0.00000819,
    0.00000906,
    0.00000973,
    0.00000977,
    0.00001121,
    0.00001113
  ];
  static final _listConstantBoy2 = [
    0.00055096,
    0.00061770,
    0.00067693,
    0.00071813,
    0.00071947,
    0.00081471,
    0.00081778
  ];
  static final _listConstantBoy3 = [
    0.01688394,
    0.01854033,
    0.02002894,
    0.02095051,
    0.02098946,
    0.02326989,
    0.02355179
  ];
  static final _listConstantBoy4 = [
    0.27192347,
    0.28971686,
    0.30609367,
    0.31507558,
    0.31613969,
    0.33948538,
    0.34454875
  ];
  static final _listConstantBoy5 = [
    2.63126903,
    2.69602649,
    2.75838731,
    2.78335970,
    2.78348667,
    2.86775428,
    2.88741952
  ];
  static final _listConstantBoy6 = [
    37.78553641,
    36.49431684,
    35.19629667,
    33.94425959,
    32.73469469,
    31.40958799,
    30.15595154
  ];

  static final _listConstantGirl1 = [
    0.00000818,
    0.00000767,
    0.00000838,
    0.00000911,
    0.00000847,
    0.00000955,
    0.00000955
  ];
  static final _listConstantGirl2 = [
    0.00061260,
    0.00058298,
    0.00062466,
    0.00067119,
    0.00062752,
    0.00069062,
    0.00069061
  ];
  static final _listConstantGirl3 = [
    0.01816480,
    0.01765221,
    0.01849628,
    0.01952798,
    0.01836595,
    0.01965735,
    0.01961847
  ];
  static final _listConstantGirl4 = [
    0.27842781,
    0.27850528,
    0.28462621,
    0.29314885,
    0.27725656,
    0.28787021,
    0.28582585
  ];
  static final _listConstantGirl5 = [
    2.53981612,
    2.62746400,
    2.62032518,
    2.62238884,
    2.49592593,
    2.51369006,
    2.47565050
  ];
  static final _listConstantGirl6 = [
    35.84568666,
    37.06022569,
    35.84568666,
    34.61361672,
    32.27184983,
    30.98830812,
    29.79702364
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
    final constant3 = isBoy
        ? (_listConstantBoy3[lineTo - 1])
        : (_listConstantGirl3[lineTo - 1]);
    final constant4 = isBoy
        ? (_listConstantBoy4[lineTo - 1])
        : (_listConstantGirl4[lineTo - 1]);
    final constant5 = isBoy
        ? (_listConstantBoy5[lineTo - 1])
        : (_listConstantGirl5[lineTo - 1]);
    final constant6 = isBoy
        ? (_listConstantBoy6[lineTo - 1])
        : (_listConstantGirl6[lineTo - 1]);

    for (int i = 0; i <= 24; i++) {
      Variable x = Variable('x');
      final xValue = Number(i);
      ContextModel cm = ContextModel()..bindVariable(x, xValue);
      Number const1 = Number(constant1);
      Number const2 = Number(constant2);
      Number const3 = Number(constant3);
      Number const4 = Number(constant4);
      Number const5 = Number(constant5);
      Number const6 = Number(constant6);
      final exp = const1 * Power(x, 5) -
          const2 * Power(x, 4) +
          const3 * Power(x, 3) -
          const4 * Power(x, 2) +
          const5 * x +
          const6;
      final double yvalue = exp.evaluate(EvaluationType.REAL, cm);
      list.add(FlSpot(i.toDouble(), double.parse(yvalue.toStringAsFixed(2))));
    }

    return list;
  }

  //method data pasien
  static List<FlSpot> listDataPasienLine(List<PemeriksaanModel> listData) {
    List<FlSpot> list = [];
    for (int i = 1; i <= listData.length; i++) {
      list.add(FlSpot(
          i.toDouble(), listData[i - 1].lingkarKepala?.toDouble() ?? 0.0));
    }
    return list;
  }
}
