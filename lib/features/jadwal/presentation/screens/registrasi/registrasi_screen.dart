import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/registrasi/qrcode_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrasiScreen extends StatelessWidget {
  const RegistrasiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            QRScanButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QrRegistrasiPemeriksaan()));
              },
            ),
            const SizedBox(height: 10),
            const _Header(),
            Expanded(
              child: _ListYears(onTap: (index) => debugPrint(index.toString())),
            ),
          ],
        ),
      ),
    );
  }
}

class QRScanButton extends StatelessWidget {
  final void Function()? onTap;
  const QRScanButton({super.key, required this.onTap});

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

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      color: Colors.blue,
      child: const Text(
        'Daftar Tamu',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class _ListYears extends StatelessWidget {
  final void Function(int)? onTap;
  const _ListYears({required this.onTap});

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
