import 'package:eimunisasi_nakes/features/klinik/data/models/anggota_klinik.dart';
import 'package:eimunisasi_nakes/features/klinik/logic/bloc/klinik_bloc/klinik_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class KeanggotaanKlinikScreen extends StatelessWidget {
  const KeanggotaanKlinikScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keanggotaan Klinik'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<KlinikBloc, KlinikState>(
          builder: (context, state) {
            if (state is KlinikLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is KlinikFailure) {
              return const Center(
                child: Text('Data gagal dimuat'),
              );
            } else if (state is KlinikFetchDataAnggota) {
              return Column(
                children: [
                  _RowAnggotaKlinik(
                    data: state.data,
                  ),
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )),
    );
  }
}

class _RowAnggotaKlinik extends StatelessWidget {
  final List<AnggotaKlinik>? data;
  const _RowAnggotaKlinik({this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [
          Text('Anggota',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text('Profesi',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 10),
        const Divider(
          thickness: 2,
        ),
        for (final AnggotaKlinik? anggota in data ?? [])
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(anggota?.uid ?? '', style: const TextStyle(fontSize: 15)),
            const Text('bidan', style: TextStyle(fontSize: 15)),
          ]),
        const Divider(),
      ],
    );
  }
}
