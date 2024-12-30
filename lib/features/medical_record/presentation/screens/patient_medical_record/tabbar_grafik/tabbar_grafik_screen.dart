import 'package:eimunisasi_nakes/core/widgets/grafik/grafik_tumbuh_kembang.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/grafik/line_chart_template.dart';
import '../../../../data/models/patient_model.dart';

class TabbarGrafikScreen extends StatelessWidget {
  final PatientModel? pasien;
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
          BlocBuilder<CheckupCubit, CheckupState>(
            builder: (context, state) {
              final List<CheckupModel> data = (state is CheckupLoaded)
                  ? state.checkupResult?.data ?? []
                  : [];
              return Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GrafikPertumbuhan(
                      type: LineChartType.beratBadan,
                      listData: data,
                      isBoy: pasien?.jenisKelamin == "Laki-laki" ? true : false,
                    ),
                    GrafikPertumbuhan(
                      type: LineChartType.tinggiBadan,
                      listData: data,
                      isBoy: pasien?.jenisKelamin == "Laki-laki" ? true : false,
                    ),
                    GrafikPertumbuhan(
                      type: LineChartType.lingkarKepala,
                      listData: data,
                      isBoy: pasien?.jenisKelamin == "Laki-laki" ? true : false,
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
