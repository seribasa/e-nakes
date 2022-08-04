import 'package:eimunisasi_nakes/core/widgets/grafik/grafik_berat_badan.dart';
import 'package:eimunisasi_nakes/core/widgets/grafik/line_data_berat_badan_boy.dart';
import 'package:flutter/material.dart';

class RekamMedisScreen extends StatelessWidget {
  const RekamMedisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Halaman Grafik')),
      // body: const GrafikBeratBadan(spotsDataBeratPasien: LineDataModel().listDataPasienLine(listData),),
    );
  }
}
