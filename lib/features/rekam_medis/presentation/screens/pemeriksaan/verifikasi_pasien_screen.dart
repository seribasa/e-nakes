import 'dart:convert';

import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/form_pemeriksaan/form_pemeriksaan_vaksinasi_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/form_pemeriksaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class VerifikasiPasienScreen extends StatelessWidget {
  final PasienModel pasien;
  final Barcode? result;
  const VerifikasiPasienScreen({Key? key, this.result, required this.pasien})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String? dataBarcode = result?.code;
    final String? nama =
        dataBarcode != null ? jsonDecode(dataBarcode)["nama"] : pasien.nama;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifikasi Pasien'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IdentitasPasien(
                namaAnak: '$nama',
                umurAnak: pasien.umur.toString(),
                namaOrangTua: pasien.nik,
                alamat: pasien.tempatLahir,
              ),
              const SizedBox(height: 10),
              const _JenisVaksin(
                namaVaksin: 'Tahap 1 Vaksin Polio',
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _NextButton(pasien: pasien),
    );
  }
}

class _IdentitasPasien extends StatelessWidget {
  final String? namaAnak;
  final String? umurAnak;
  final String? namaOrangTua;
  final String? alamat;
  const _IdentitasPasien(
      {Key? key, this.namaAnak, this.umurAnak, this.namaOrangTua, this.alamat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Identitas Pasien',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nama Anak: $namaAnak'),
              Text('Umur Anak: $umurAnak'),
              Text('Nama Orang Tua: $namaOrangTua'),
              Text('Alamat: $alamat'),
            ],
          ),
        ),
      ],
    );
  }
}

class _JenisVaksin extends StatelessWidget {
  final String? namaVaksin;
  const _JenisVaksin({Key? key, this.namaVaksin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jenis Vaksin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('$namaVaksin'),
            ],
          ),
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  final PasienModel pasien;
  const _NextButton({Key? key, required this.pasien}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final _user = state is Authenticated ? state.user : null;
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            child: const Text("Lanjut"),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return BlocProvider(
                  create: (context) => FormPemeriksaanVaksinasiCubit(
                    userData: _user,
                  )..providePasienData(pasien.nik, _user?.id, pasien),
                  child: const FormPemeriksaanScreen(),
                );
              }));
            },
          );
        },
      ),
    );
  }
}
