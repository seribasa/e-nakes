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
