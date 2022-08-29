import 'package:eimunisasi_nakes/features/jadwal/logic/jadwal/jadwal_cubit.dart';
import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/riwayat%20janji/riwayat_janji_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RiwayatJanjiScreen extends StatelessWidget {
  const RiwayatJanjiScreen({Key? key}) : super(key: key);

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
  const _Header({Key? key}) : super(key: key);

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
  const _ListDate({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JadwalCubit, JadwalState>(
      builder: (context, state) {
        if (state is JadwalLoaded) {
          final data = state.jadwalPasienModel;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                if ((index == 0) ||
                    (DateFormat('dd MMMM yyyy')
                            .format(data[index].tanggal ?? DateTime.now()) !=
                        DateFormat('dd MMMM yyyy').format(
                            data[index - 1].tanggal ?? DateTime.now()))) {
                  return ExpansionTile(
                    title: Text(DateFormat('dd MMMM yyyy')
                        .format(data[index].tanggal ?? DateTime.now())),
                    children: [
                      for (final jadwalPasienModel in data)
                        if (DateFormat('dd-MM-yyyy').format(
                                jadwalPasienModel.tanggal ?? DateTime.now()) ==
                            DateFormat('dd-MM-yyyy')
                                .format(data[index].tanggal ?? DateTime.now()))
                          ListTile(
                            title: Text(DateFormat('hh:mm').format(
                                jadwalPasienModel.tanggal ?? DateTime.now())),
                            subtitle: Text(jadwalPasienModel.notes ?? '-'),
                            // trailing: IconButton(
                            //   icon: FaIcon(
                            //     FontAwesomeIcons.trash,
                            //     color: Colors.red[500],
                            //   ),
                            //   onPressed: () {
                            //     showDialog(
                            //       context: context,
                            //       builder: (context) => AlertDialog(
                            //         title: const Text('Hapus Janji'),
                            //         content: const Text(
                            //             'Apakah anda yakin ingin menghapus janji ini?'),
                            //         actions: [
                            //           TextButton(
                            //             child: const Text('Tidak'),
                            //             onPressed: () => Navigator.pop(context),
                            //           ),
                            //           TextButton(
                            //             child: const Text('Ya'),
                            //             style: TextButton.styleFrom(
                            //               backgroundColor: Colors.red[500],
                            //               primary: Colors.white,
                            //             ),
                            //             onPressed: () {
                            //               Navigator.pop(context);
                            //               // BlocProvider.of<JadwalCubit>(context)
                            //               //     .add(DeleteJadwal(
                            //               //         jadwalPasienModel:
                            //               //             jadwalPasienModel));
                            //             },
                            //           ),
                            //         ],
                            //       ),
                            //     );
                            //   },
                            // ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RiwayatJanjiDetailScreen(
                                          jadwalPasienModel: jadwalPasienModel,
                                        )),
                              );
                            },
                          ),
                    ],
                  );
                } else {
                  return Container();
                }
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
