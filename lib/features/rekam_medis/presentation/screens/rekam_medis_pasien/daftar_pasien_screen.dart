import 'package:eimunisasi_nakes/core/widgets/search_bar_widget.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/rekam_medis_pasien_screen.dart';
import 'package:flutter/material.dart';

class DaftarPasienScreen extends StatelessWidget {
  const DaftarPasienScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            _SearchBar(),
            Expanded(child: _ListPasien()),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      hintText: 'Cari Pasien ...',
      onPressed: () {},
    );
  }
}

class _ListPasien extends StatelessWidget {
  const _ListPasien({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(20, (index) {
          return ListTile(
            title: Text(
              'Pasien $index',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
                'NIK $index${index + 1}${index + 2}${index + 3}${index + 4}'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const RekamMedisPasienScreen()),
              );
            },
          );
        }),
      ),
    );
  }
}
