import 'dart:convert';

import 'package:eimunisasi_nakes/core/common/constan.dart';
import 'package:eimunisasi_nakes/features/appointment/data/models/appointment_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_form_cubit/checkup_form_cubit.dart';
import 'package:eimunisasi_nakes/routers/medical_record_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class PatientVerificationScreenExtra {
  final PatientModel? patient;
  final PatientAppointmentModel? appointment;

  const PatientVerificationScreenExtra({
    this.appointment,
    this.patient,
  });
}

class PatientVerificationScreen extends StatelessWidget {
  final PatientAppointmentModel? appointment;
  final PatientModel? patient;
  final Barcode? result;
  const PatientVerificationScreen({
    super.key,
    this.result,
    required this.patient,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final String? dataBarcode = result?.code;
    final String? nama =
        dataBarcode != null ? jsonDecode(dataBarcode)["nama"] : patient?.nama;
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
                umurAnak: patient?.umur.toString(),
                namaOrangTua: patient?.nik,
                alamat: patient?.tempatLahir,
              ),
              const SizedBox(height: 10),
              _JenisVaksin(
                namaVaksin: appointment?.note,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: _NextButton(),
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
                    child: BlocBuilder<CheckupFormCubit, CheckupFormState>(
                      builder: (context, state) {
                        return DropdownButton(
                          underline: const SizedBox(),
                          value: state.checkup.month != null
                              ? int.tryParse(state.checkup.month!)
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
                                .read<CheckupFormCubit>()
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
                child: BlocBuilder<CheckupFormCubit, CheckupFormState>(
                  builder: (context, state) {
                    return DropdownButton(
                      value: state.checkup.vaccineType,
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
                            .read<CheckupFormCubit>()
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
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: BlocBuilder<CheckupFormCubit, CheckupFormState>(
        builder: (context, formState) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            child: const Text("Lanjut"),
            onPressed: () {
              if ((formState.checkup.vaccineType == null ||
                      formState.checkup.vaccineType?.isEmpty == true) ||
                  (formState.checkup.month == null ||
                      formState.checkup.month?.isEmpty == true)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Jenis Vaksin dan Bulan Kunjungan tidak boleh kosong,',
                    ),
                  ),
                );
                return;
              }
              context.pushNamed(
                MedicalRecordRouter.checkupFormRoute.name,
                extra: context.read<CheckupFormCubit>(),
              );
            },
          );
        },
      ),
    );
  }
}
