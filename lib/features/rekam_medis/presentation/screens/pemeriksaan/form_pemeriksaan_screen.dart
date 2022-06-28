import 'package:eimunisasi_nakes/core/widgets/custom_text_field.dart';
import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/grafik_pemeriksaan_screen.dart';
import 'package:flutter/material.dart';

class FormPemeriksaanScreen extends StatelessWidget {
  const FormPemeriksaanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemeriksaan Pasien'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              PasienCard(
                nama: 'Rizky faturriza',
                umur: '1 bulan 2 tahun',
              ),
              SizedBox(height: 10),
              _PemeriksaanFisik(),
              SizedBox(height: 10),
              _RiwayatKeluhan()
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _NextButton(),
    );
  }
}

class _BeratBadanForm extends StatelessWidget {
  const _BeratBadanForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(flex: 3, child: Text('Berat Badan')),
        SizedBox(width: 5),
        Expanded(flex: 2, child: MyTextFormField()),
        SizedBox(width: 5),
        Expanded(flex: 1, child: Text('kg')),
      ],
    );
  }
}

class TinggiBadanForm extends StatelessWidget {
  const TinggiBadanForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(flex: 3, child: Text('Tinggi Badan')),
        SizedBox(width: 5),
        Expanded(flex: 2, child: MyTextFormField()),
        SizedBox(width: 5),
        Expanded(flex: 1, child: Text('cm')),
      ],
    );
  }
}

class LingkarKepalaForm extends StatelessWidget {
  const LingkarKepalaForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(flex: 3, child: Text('Lingkar Kepala')),
        SizedBox(width: 5),
        Expanded(flex: 2, child: MyTextFormField()),
        SizedBox(width: 5),
        Expanded(flex: 1, child: Text('cm')),
      ],
    );
  }
}

class SuhuForm extends StatelessWidget {
  const SuhuForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Text('Suhu'),
        SizedBox(width: 5),
        Expanded(child: MyTextFormField()),
        SizedBox(width: 5),
        Text('°C'),
      ],
    );
  }
}

class _PemeriksaanFisik extends StatelessWidget {
  const _PemeriksaanFisik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Pemeriksaan Fisik',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        _BeratBadanForm(),
        SizedBox(height: 10),
        TinggiBadanForm(),
        SizedBox(height: 10),
        LingkarKepalaForm(),
      ],
    );
  }
}

class _RiwayatKeluhan extends StatelessWidget {
  const _RiwayatKeluhan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Riwayat dan Keluhan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: const TextField(
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: const Text("Simpan dan Lanjutkan"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const GrafikPemeriksaanScreen();
          }));
        },
      ),
    );
  }
}
