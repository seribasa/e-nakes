import 'package:eimunisasi_nakes/core/widgets/grafik/grafik_tumbuh_kembang.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/grafik/line_chart_template.dart';
import '../../../../data/models/pasien_model.dart';

class TabbarGrafikScreen extends StatelessWidget {
  final PasienModel pasien;
  const TabbarGrafikScreen({
    super.key,
    required this.pasien,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
          BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
            builder: (context, state) {
              final List<PemeriksaanModel> data =
                  (state is PemeriksaanLoaded) ? state.pemeriksaan ?? [] : [];
              return Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GrafikPertumbuhan(
                      type: LineChartType.beratBadan,
                      listData: data,
                      isBoy: pasien.jenisKelamin == "Laki-laki" ? true : false,
                    ),
                    GrafikPertumbuhan(
                      type: LineChartType.tinggiBadan,
                      listData: data,
                      isBoy: pasien.jenisKelamin == "Laki-laki" ? true : false,
                    ),
                    GrafikPertumbuhan(
                      type: LineChartType.lingkarKepala,
                      listData: data,
                      isBoy: pasien.jenisKelamin == "Laki-laki" ? true : false,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
