import 'package:eimunisasi_nakes/core/widgets/search_bar_widget.dart';
import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/registrasi/qrcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PemeriksaanScreen extends StatelessWidget {
  const PemeriksaanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemeriksaan Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            QRScanButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QRViewExample()));
              },
            ),
            const SizedBox(height: 10),
            const _SearchBar(),
            const SizedBox(height: 10),
            const Expanded(
              child: _ListPasien(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListPasien extends StatelessWidget {
  const _ListPasien({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...List.generate(20, (index) {
            return ListTile(
              title: Text(
                'Pasien $index',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                  'NIK $index${index + 1}${index + 2}${index + 3}${index + 4}'),
              onTap: () {
                Navigator.of(context).pop();
              },
            );
          }),
        ],
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
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
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
                      Navigator.of(context).pop();
                    },
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

class QRScanButton extends StatelessWidget {
  final void Function()? onTap;
  const QRScanButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.qrcode,
                size: MediaQuery.of(context).size.width / 5,
                color: Colors.blue,
              ),
              const SizedBox(height: 5),
              const Text(
                'Scan QR Code',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
