import 'package:eimunisasi_nakes/core/widgets/error.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:eimunisasi_nakes/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../logic/jadwal/jadwal_cubit.dart';

class RiwayatJanjiDetailScreen extends StatelessWidget {
  final String id;

  const RiwayatJanjiDetailScreen({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<JadwalCubit>()..getSelectedDetail(id),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Riwayat Janji'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const _Header(),
              Expanded(
                child: BlocBuilder<JadwalCubit, JadwalState>(
                  builder: (context, state) {
                    if (state is JadwalLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is JadwalLoaded) {
                      return _DetailJanjiCard(
                        onTap: (index) => debugPrint(index.toString()),
                        jadwalPasienModel: state.selectedAppointment,
                      );
                    }
                    if (state is JadwalError) {
                      return ErrorContainer(
                        title: state.message,
                        message: 'Coba lagi',
                        onRefresh: () {
                          context.read<JadwalCubit>().getSelectedDetail(id);
                        },
                      );
                    }

                    return const SizedBox();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: Colors.blue,
      child: const Text(
        'Detail Janji',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _DetailJanjiCard extends StatelessWidget {
  final void Function(int)? onTap;
  final JadwalPasienModel? jadwalPasienModel;

  const _DetailJanjiCard({required this.onTap, this.jadwalPasienModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tanggal Kunjung'),
                const SizedBox(width: 10),
                Text(DateFormat('dd MMMM yyyy')
                    .format(jadwalPasienModel?.date ?? DateTime.now())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nama Orangtua'),
                const SizedBox(width: 10),
                Text(jadwalPasienModel?.parent?.nama ?? '-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nama Anak'),
                const SizedBox(width: 10),
                Text(jadwalPasienModel?.child?.nama ?? '-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Umur Anak'),
                const SizedBox(width: 10),
                Text(jadwalPasienModel?.child?.umur ?? '-'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
