import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TabbarTindakanScreen extends StatelessWidget {
  const TabbarTindakanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
      builder: (context, state) {
        final List<PemeriksaanModel> pemeriksaan =
            (state is PemeriksaanLoaded) ? state.pemeriksaan ?? [] : [];

        return SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(pemeriksaan.length, (index) {
                final data = pemeriksaan[index];
                return Card(
                  child: ListTile(
                    title: Text(
                        'Tindakan ${DateFormat('dd/MM/yyyy').format(data.createdAt ?? DateTime.now())}'),
                    subtitle: Text(
                        data.tindakan ?? 'Tidak ada tindakan yang dilakukan'),
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
