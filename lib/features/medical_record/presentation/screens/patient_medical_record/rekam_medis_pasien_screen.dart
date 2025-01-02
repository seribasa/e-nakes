import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/patient_medical_record/tabbar_diagnosa/tabbar_diagnosa_screen.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/patient_medical_record/tabbar_grafik/tabbar_grafik_screen.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/patient_medical_record/tabbar_tabel/tabbar_tabel_screen.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/patient_medical_record/tabbar_tindakan/tabbar_tindakan_screen.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/patient_medical_record/tabbar_vaksin/tabbar_vaksin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection.dart';

class RekamMedisPasienScreenExtra {
  final PatientModel? pasien;

  RekamMedisPasienScreenExtra({this.pasien});
}

class RekamMedisPasienScreen extends StatelessWidget {
  final PatientModel? pasien;

  const RekamMedisPasienScreen({super.key, required this.pasien});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CheckupCubit>(
      create: (context) =>
          getIt<CheckupCubit>()..getCheckupByPatientId(pasien?.nik),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Pemeriksaan'),
        ),
        body: BlocBuilder<CheckupCubit, CheckupState>(
          builder: (context, state) {
            if (state is CheckupLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is CheckupLoaded) {
              if (state.checkupResult == null ||
                  state.checkupResult?.data?.isEmpty == true) {
                return const Center(
                  child: Text('Tidak ada data'),
                );
              } else {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PasienCard(
                        nama: pasien?.nama,
                        umur: pasien?.umur,
                        jenisKelamin: pasien?.jenisKelamin,
                      ),
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 5,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: Colors.blue,
                              child: const TabBar(
                                indicatorColor: Colors.white,
                                isScrollable: true,
                                tabs: [
                                  Tab(text: 'Vaksin'),
                                  Tab(text: 'Tabel'),
                                  Tab(text: 'Grafik'),
                                  Tab(text: 'Diagnosa'),
                                  Tab(text: 'Tindakan'),
                                ],
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  const TabbarVaksinScreen(),
                                  const TabbarTabelScreen(),
                                  TabbarGrafikScreen(
                                    pasien: pasien,
                                  ),
                                  const TabbarDiagnosaScreen(),
                                  const TabbarTindakanScreen(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
      ),
    );
  }
}
