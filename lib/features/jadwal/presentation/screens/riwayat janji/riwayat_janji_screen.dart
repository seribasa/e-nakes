import 'package:eimunisasi_nakes/core/widgets/error.dart';
import 'package:eimunisasi_nakes/features/jadwal/logic/jadwal/jadwal_cubit.dart';
import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/riwayat%20janji/riwayat_janji_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../data/models/jadwal_model.dart';

class RiwayatJanjiScreen extends StatelessWidget {
  const RiwayatJanjiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Janji'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: _ListDate(onTap: (index) => debugPrint(index.toString())),
            ),
          ],
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
        'Daftar Janji',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _ListDate extends StatelessWidget {
  final void Function(int)? onTap;

  const _ListDate({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JadwalCubit, JadwalState>(
      builder: (context, state) {
        if (state is JadwalLoaded) {
          if (state.paginationAppointment?.data?.isEmpty ?? true) {
            return const Center(
              child: Text('Tidak ada janji'),
            );
          }
          final data = state.paginationAppointment?.data;
          return ListView.builder(
            itemCount: data?.length,
            itemBuilder: (context, index) {
              if ((index == 0) ||
                  (DateFormat('dd MMMM yyyy').format(
                        data?[index].date ?? DateTime.now(),
                      ) !=
                      DateFormat('dd MMMM yyyy')
                          .format(data?[index - 1].date ?? DateTime.now()))) {
                return ExpansionTile(
                  title: Text(
                    DateFormat('dd MMMM yyyy').format(
                      data?[index].date ?? DateTime.now(),
                    ),
                  ),
                  children: [
                    for (final appointment in data ?? <JadwalPasienModel>[])
                      if (DateFormat('dd-MM-yyyy')
                              .format(appointment.date ?? DateTime.now()) ==
                          DateFormat('dd-MM-yyyy')
                              .format(data?[index].date ?? DateTime.now()))
                        ListTile(
                          title: Text(
                            DateFormat('hh:mm').format(
                              appointment.date ?? DateTime.now(),
                            ),
                          ),
                          subtitle: Text(appointment.note ?? '-'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RiwayatJanjiDetailScreen(
                                  id: appointment.id ?? '',
                                ),
                              ),
                            );
                          },
                        ),
                  ],
                );
              }
              return Container();
            },
          );
        }
        if (state is JadwalLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is JadwalError) {
          return ErrorContainer(
            title: state.message,
            message: 'Coba lagi',
            onRefresh: () {
              BlocProvider.of<JadwalCubit>(context).getAllJadwal();
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}
