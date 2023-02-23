import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';

// boy
//method lineChartBarData of y = 0 + -0,0002501x4 + 0,0150547x3 - 0,3376376x2 + 4,3399430x + 46,9700427
//method lineChartBarData of y = 0,0000180x5 - 0,0013348x4 + 0,0381623x3 - 0,5429746x2 + 5,0483717x + 48,1241895
//method lineChartBarData of y = 0,0000184x5 - 0,0013628x4 + 0,0389492x3 - 0,5514154x2 + 5,1166274x + 50,1041928
//method lineChartBarData of y = 0,0000192x5 - 0,0014133x4 + 0,0401177x3 - 0,5620420x2 + 5,1877005x + 52,0832685
//method lineChartBarData of y = 0,0000189x5 - 0,0013986x4 + 0,0399272x3 - 0,5613172x2 + 5,2210823x + 53,6888801

// girl
//method lineChartBarData of y = 0,0000174x5 - 0,0012670x4 + 0,0354700x3 - 0,4918635x2 + 4,7666046x + 53,0871778
//method lineChartBarData of y = 0,0000169x5 - 0,0012335x4 + 0,0346578x3 - 0,4829910x2 + 4,6774520x + 51,5412374
//method lineChartBarData of y = 0,0000165x5 - 0,0012051x4 + 0,0338645x3 - 0,4733287x2 + 4,5726876x + 49,6252014
//method lineChartBarData of y = 0,0000165x5 - 0,0012013x4 + 0,0335757x3 - 0,4672027x2 + 4,4715740x + 47,7060634
//method lineChartBarData of y = 0,0000164x5 - 0,0011908x4 + 0,0332493x3 - 0,4632810x2 + 4,4101066x + 46,0943392
class LineDataBodyHeightModel {
  static final _listConstantBoy1 = [
    0,
    0.0000180,
    0.0000184,
    0.0000192,
    0.0000189,
  ];
  static final _listConstantBoy2 = [
    -0.0002501,
    -0.0013348,
    -0.0013628,
    -0.0014133,
    -0.0013986,
  ];
  static final _listConstantBoy3 = [
    0.0150547,
    0.0381623,
    0.0389492,
    0.0401177,
    0.0399272,
  ];
  static final _listConstantBoy4 = [
    -0.3376376,
    -0.5429746,
    -0.5514154,
    -0.5620420,
    -0.5613172,
  ];
  static final _listConstantBoy5 = [
    4.3399430,
    5.0483717,
    5.1166274,
    5.1877005,
    5.2210823,
  ];
  static final _listConstantBoy6 = [
    46.9700427,
    48.1241895,
    50.1041928,
    52.0832685,
    53.6888801,
  ];
  static final _listConstantGirl1 = [
    0.0000174,
    0.0000169,
    0.0000165,
    0.0000165,
    0.0000164,
  ];
  static final _listConstantGirl2 = [
    -0.0012670,
    -0.0012335,
    -0.0012051,
    -0.0012013,
    -0.0011908,
  ];
  static final _listConstantGirl3 = [
    0.0354700,
    0.0346578,
    0.0338645,
    0.0335757,
    0.0332493,
  ];
  static final _listConstantGirl4 = [
    -0.4918635,
    -0.4829910,
    -0.4733287,
    -0.4672027,
    -0.4632810,
  ];
  static final _listConstantGirl5 = [
    4.7666046,
    4.6774520,
    4.5726876,
    4.4715740,
    4.4101066,
  ];
  static final _listConstantGirl6 = [
    53.0871778,
    51.5412374,
    49.6252014,
    47.7060634,
    46.0943392,
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
      final exp = const1 * Power(x, 5) +
          const2 * Power(x, 4) +
          const3 * Power(x, 3) +
          const4 * Power(x, 2) +
          const5 * x +
          const6;
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
