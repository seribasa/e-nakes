import 'dart:convert';

import 'package:eimunisasi_nakes/core/common/constan.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/appointment/data/models/appointment_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/form_pemeriksaan/form_pemeriksaan_vaksinasi_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/form_pemeriksaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class VerifikasiPasienScreen extends StatelessWidget {
  final PatientAppointmentModel? jadwalPasienModel;
  final PatientModel? pasien;
  final Barcode? result;
  const VerifikasiPasienScreen(
      {super.key,
      this.result,
      required this.pasien,
      required this.jadwalPasienModel});

  @override
  Widget build(BuildContext context) {
    final String? dataBarcode = result?.code;
    final String? nama =
        dataBarcode != null ? jsonDecode(dataBarcode)["nama"] : pasien?.nama;
    return BlocProvider(
      create: (context) => FormPemeriksaanVaksinasiCubit(
        userData: context.read<AuthenticationBloc>().state.user,
      ),
      child: Scaffold(
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
                  umurAnak: pasien?.umur.toString(),
                  namaOrangTua: pasien?.nik,
                  alamat: pasien?.tempatLahir,
                ),
                const SizedBox(height: 10),
                _JenisVaksin(
                  namaVaksin: jadwalPasienModel?.note,
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: _NextButton(pasien: pasien ?? const PatientModel()),
      ),
    );
  }
}

class _IdentitasPasien extends StatelessWidget {
  final String? namaAnak;
  final String? umurAnak;
  final String? namaOrangTua;
  final String? alamat;
  const _IdentitasPasien(
      {this.namaAnak, this.umurAnak, this.namaOrangTua, this.alamat});

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
  const _JenisVaksin({this.namaVaksin});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Deskripsi',
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
              Text(namaVaksin ?? ''),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bulan Kunjungan',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[200],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: BlocBuilder<FormPemeriksaanVaksinasiCubit,
                        FormPemeriksaanVaksinasiState>(
                      builder: (context, state) {
                        return DropdownButton(
                          underline: const SizedBox(),
                          value: state.bulanKe != null
                              ? int.parse(state.bulanKe!)
                              : null,
                          items: List.generate(
                            24,
                            (index) => DropdownMenuItem(
                              value: index + 1,
                              child: Text('${index + 1}'),
                            ),
                          ),
                          onChanged: (value) {
                            context
                                .read<FormPemeriksaanVaksinasiCubit>()
                                .changeMonthOfVisit(value.toString());
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Jenis Vaksin',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: BlocBuilder<FormPemeriksaanVaksinasiCubit,
                    FormPemeriksaanVaksinasiState>(
                  builder: (context, state) {
                    return DropdownButton(
                      value: state.jenisVaksin,
                      isExpanded: true,
                      underline: const SizedBox(),
                      items: List.generate(
                        Constant.listTypeOfVaccine.length,
                        (index) => DropdownMenuItem(
                          value: Constant.listTypeOfVaccine[index],
                          child: Text(Constant.listTypeOfVaccine[index]),
                        ),
                      ),
                      onChanged: (value) {
                        context
                            .read<FormPemeriksaanVaksinasiCubit>()
                            .changeTypeOfVaccine(value.toString());
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  final PatientModel pasien;
  const _NextButton({required this.pasien});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          final user = state is Authenticated ? state.user : null;
          return BlocBuilder<FormPemeriksaanVaksinasiCubit,
              FormPemeriksaanVaksinasiState>(
            builder: (context, formState) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero)),
                child: const Text("Lanjut"),
                onPressed: () {
                  if ((formState.jenisVaksin == null ||
                          formState.jenisVaksin!.isEmpty) &&
                      (formState.bulanKe == null ||
                          formState.bulanKe!.isEmpty)) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Jenis Vaksin dan Bulan Kunjungan tidak boleh kosong,'),
                      ),
                    );
                    return;
                  }
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return BlocProvider.value(
                      value: context.read<FormPemeriksaanVaksinasiCubit>()
                        ..providePasienData(pasien.nik, user?.id, pasien),
                      child: const FormPemeriksaanScreen(),
                    );
                  }));
                },
              );
            },
          );
        },
      ),
    );
  }
}
