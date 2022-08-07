import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TabbarVaksinScreen extends StatelessWidget {
  const TabbarVaksinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
      builder: (context, state) {
        final List<PemeriksaanModel> _pemeriksaan =
            (state is PemeriksaanLoaded) ? state.pemeriksaan ?? [] : [];
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_pemeriksaan.length + 1, (index) {
                    if (index == 0) {
                      // Title
                      return const Text(
                        'Tanggal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    } else {
                      final data = _pemeriksaan[index - 1];
                      // Body
                      return Text(DateFormat('dd/MM/yyyy')
                          .format(data.createdAt ?? DateTime.now()));
                    }
                  }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_pemeriksaan.length + 1, (index) {
                    if (index == 0) {
                      // Title
                      return const Text(
                        'Jenis Vaksin',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    } else {
                      final data = _pemeriksaan[index - 1];
                      // Body
                      return Text(data.jenisVaksin ?? '');
                    }
                  }),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
