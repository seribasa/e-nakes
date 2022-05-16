import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RiwayatJanjiTahunScreen extends StatelessWidget {
  const RiwayatJanjiTahunScreen({Key? key}) : super(key: key);

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
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return ExpansionTile(
              title: Text('Kamis, ${index + 1} Jan 2020'),
              children: <Widget>[
                ListTile(
                  trailing: const FaIcon(FontAwesomeIcons.arrowRight),
                  onTap: () => onTap!(index),
                  title: const Text('08.00 - 09.00'),
                  subtitle: const Text('Imunisasi TT'),
                ),
              ]);
        });
  }
}
