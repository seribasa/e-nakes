import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_diagnosa/tabbar_diagnosa_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_grafik/tabbar_grafik_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_tabel/tabbar_tabel_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_tindakan/tabbar_tindakan_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/tabbar_vaksin/tabbar_vaksin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RekamMedisPasienScreen extends StatelessWidget {
  final PasienModel pasien;
  const RekamMedisPasienScreen({Key? key, required this.pasien})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Pemeriksaan'),
      ),
      body: BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
        builder: (context, state) {
          if (state is PemeriksaanLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PemeriksaanLoaded) {
            if (state.pemeriksaan == null || state.pemeriksaan!.isEmpty) {
              return const Center(
                child: Text('Tidak ada data'),
              );
            } else {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PasienCard(
                      nama: pasien.nama,
                      umur: pasien.umur,
                      jenisKelamin: pasien.jenisKelamin,
                    ),
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
              );
            }
          } else {
            return const Center(
              child: Text('Terjadi kesalahan'),
            );
          }
        },
      ),
    );
  }
}
