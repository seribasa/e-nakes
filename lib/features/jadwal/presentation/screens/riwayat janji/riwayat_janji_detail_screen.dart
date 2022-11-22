import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatJanjiDetailScreen extends StatelessWidget {
  final JadwalPasienModel? jadwalPasienModel;
  const RiwayatJanjiDetailScreen({Key? key, this.jadwalPasienModel})
      : super(key: key);

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
                child: _DetailJanjiCard(
              onTap: null,
              jadwalPasienModel: jadwalPasienModel,
            )),
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
        'Detail Janji',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _DetailJanjiCard extends StatelessWidget {
  final void Function(int)? onTap;
  final JadwalPasienModel? jadwalPasienModel;
  const _DetailJanjiCard(
      {Key? key, required this.onTap, this.jadwalPasienModel})
      : super(key: key);

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
                    .format(jadwalPasienModel?.tanggal ?? DateTime.now())),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nama Orangtua'),
                const SizedBox(width: 10),
                Text(jadwalPasienModel?.orangtua?.nama ?? '-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Nama Anak'),
                const SizedBox(width: 10),
                Text(jadwalPasienModel?.anak?.nama ?? '-'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Umur Anak'),
                const SizedBox(width: 10),
                Text(jadwalPasienModel?.anak?.umur ?? '-'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
