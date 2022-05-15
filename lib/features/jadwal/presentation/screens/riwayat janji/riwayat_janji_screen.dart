import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/riwayat%20janji/riwayat_janji_tahun_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RiwayatJanjiScreen extends StatelessWidget {
  const RiwayatJanjiScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Janji'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const _Header(),
            Expanded(
              child: _ListYears(
                  onTap: (i) => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => RiwayatJanjiTahunScreen()))),
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

class _ListYears extends StatelessWidget {
  final void Function(int)? onTap;
  const _ListYears({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: const FaIcon(
              FontAwesomeIcons.arrowRight,
              color: Colors.blue,
            ),
            onTap: () => onTap!(index),
            title: Text((2020 + index).toString()),
          );
        });
  }
}
