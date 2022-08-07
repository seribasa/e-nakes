import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TabbarDiagnosaScreen extends StatelessWidget {
  const TabbarDiagnosaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
      builder: (context, state) {
        final List<PemeriksaanModel> _pemeriksaan =
            (state is PemeriksaanLoaded) ? state.pemeriksaan ?? [] : [];

        return SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(_pemeriksaan.length, (index) {
                final data = _pemeriksaan[index];
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            'Keluhan ${DateFormat('dd/MM/yyyy').format(data.createdAt ?? DateTime.now())}'),
                        subtitle:
                            Text(data.riwayatKeluhan ?? 'Tidak ada keluhan'),
                      ),
                      ListTile(
                        title: const Text('Diagnosa'),
                        subtitle: Text(data.diagnosa ?? 'Tidak ada diagnosa'),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
