import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_diagnosa/tabbar_diagnosa_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_grafik/tabbar_grafik_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_tabel/tabbar_tabel_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_tindakan/tabbar_tindakan_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_vaksin/tabbar_vaksin_screen.dart';
import 'package:flutter/material.dart';

class RekamMedisPasienScreen extends StatelessWidget {
  const RekamMedisPasienScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pemeriksaan'),
      ),
      body: Column(
        children: [
          const ListTile(
            title: Text(
              'Rizky Faturriza',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Umur 10 bulan'),
          ),
          Expanded(
            child: DefaultTabController(
                length: 5,
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      child: const TabBar(
                        indicatorColor: Colors.white,
                        isScrollable: true,
                        tabs: [
                          Tab(
                            text: 'Vaksin',
                          ),
                          Tab(
                            text: 'Tabel',
                          ),
                          Tab(
                            text: 'Grafik',
                          ),
                          Tab(
                            text: 'Diagnosa',
                          ),
                          Tab(
                            text: 'Tindakan',
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          TabbarVaksinScreen(),
                          TabbarTabelScreen(),
                          TabbarGrafikScreen(),
                          TabbarDiagnosaScreen(),
                          TabbarTindakanScreen(),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class asdad extends StatelessWidget {
  const asdad({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabs Example'),
      ),
      body: Container(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20.0),
              const Text('Tabs Inside Body',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 22)),
              DefaultTabController(
                  length: 4, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          child: const TabBar(
                            labelColor: Colors.green,
                            unselectedLabelColor: Colors.black,
                            tabs: [
                              Tab(text: 'Tab 1'),
                              Tab(text: 'Tab 2'),
                              const Tab(text: 'Tab 3'),
                              const Tab(text: 'Tab 4'),
                            ],
                          ),
                        ),
                        Container(
                            height: 400, //height of TabBarView
                            decoration: const BoxDecoration(
                                border: Border(
                                    top: BorderSide(
                                        color: Colors.grey, width: 0.5))),
                            child: TabBarView(children: <Widget>[
                              Container(
                                child: const Center(
                                  child: const Text('Display Tab 1',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                child: const Center(
                                  child: Text('Display Tab 2',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                child: const Center(
                                  child: Text('Display Tab 3',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              Container(
                                child: const Center(
                                  child: Text('Display Tab 4',
                                      style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ]))
                      ])),
            ]),
      ),
    );
  }
}
