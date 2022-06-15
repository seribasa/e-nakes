import 'package:flutter/material.dart';

class RiwayatJanjiDetailScreen extends StatelessWidget {
  const RiwayatJanjiDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Janji'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: const [
            _Header(),
            Expanded(child: _DetailJanjiCard(onTap: null)),
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
  const _DetailJanjiCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Tanggal Kunjung'),
                SizedBox(width: 10),
                Text('12/12/2020'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Nama Orangtua'),
                SizedBox(width: 10),
                Text('Aisyah'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Nama Anak'),
                SizedBox(width: 10),
                Text('Rahmat Kurniawan'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text('Umur Anak'),
                SizedBox(width: 10),
                Text('20'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
