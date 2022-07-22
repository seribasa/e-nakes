import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_screen.dart';
import 'package:flutter/material.dart';

class TabbarGrafikScreen extends StatelessWidget {
  const TabbarGrafikScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: DefaultTabController(
      length: 3,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: 'Berat Badan'),
                Tab(text: 'Tinggi Badan'),
                Tab(text: 'Lingkar Kepala'),
              ],
            ),
          ),
          const Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                LineChartSample1(),
                LineChartSample1(),
                LineChartSample1(),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
