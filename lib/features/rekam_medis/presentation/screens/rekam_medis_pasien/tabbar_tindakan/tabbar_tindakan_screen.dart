import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabbarTindakanScreen extends StatelessWidget {
  const TabbarTindakanScreen({Key? key}) : super(key: key);

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
                  child: ListTile(
                    title: Text(
                        'Tindakan ${data.createdAt.toString().split(' ')[0]}'),
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
