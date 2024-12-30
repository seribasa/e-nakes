import 'package:eimunisasi_nakes/core/widgets/custom_text_field.dart';
import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_form_cubit/checkup_form_cubit.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/pemeriksaan/grafik_pemeriksaan_screen.dart';
import 'package:eimunisasi_nakes/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FormPemeriksaanScreen extends StatelessWidget {
  const FormPemeriksaanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    final pasien = pemeriksaanBloc.state.pasien;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemeriksaan Pasien'),
      ),
      body: BlocListener<FormPemeriksaanVaksinasiCubit,
          FormPemeriksaanVaksinasiState>(
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Form tidak valid'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PasienCard(
                  nama: pasien?.nama,
                  umur: pasien?.umur,
                  jenisKelamin: pasien?.jenisKelamin,
                ),
                const SizedBox(height: 10),
                const _PemeriksaanFisik(),
                const SizedBox(height: 10),
                const _RiwayatKeluhan()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _NextButton(),
    );
  }
}

class _BeratBadanForm extends StatelessWidget {
  const _BeratBadanForm();

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    return BlocBuilder<FormPemeriksaanVaksinasiCubit,
        FormPemeriksaanVaksinasiState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Berat Badan')),
                const SizedBox(width: 5),
                Expanded(
                    flex: 2,
                    child: MyTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: '10',
                      onChanged: (value) {
                        pemeriksaanBloc.changeBeratBadan(int.parse(value));
                      },
                    )),
                const SizedBox(width: 5),
                const Expanded(flex: 1, child: Text('kg')),
              ],
            ),
            () {
              if (pemeriksaanBloc.state.status ==
                  FormzSubmissionStatus.failure) {
                if (pemeriksaanBloc.state.beratBadan == null) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'Berat badan harus diisi!',
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  );
                }
              }
              return Container();
            }(),
          ],
        );
      },
    );
  }
}

class TinggiBadanForm extends StatelessWidget {
  const TinggiBadanForm({super.key});

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    return BlocBuilder<FormPemeriksaanVaksinasiCubit,
        FormPemeriksaanVaksinasiState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Tinggi Badan')),
                const SizedBox(width: 5),
                Expanded(
                    flex: 2,
                    child: MyTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: '50',
                      onChanged: (value) {
                        pemeriksaanBloc.changeTinggiBadan(int.parse(value));
                      },
                    )),
                const SizedBox(width: 5),
                const Expanded(flex: 1, child: Text('cm')),
              ],
            ),
            () {
              if (pemeriksaanBloc.state.status ==
                  FormzSubmissionStatus.failure) {
                if (pemeriksaanBloc.state.tinggiBadan == null) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Tinggi badan harus diisi!',
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  );
                }
              }
              return Container();
            }(),
          ],
        );
      },
    );
  }
}

class LingkarKepalaForm extends StatelessWidget {
  const LingkarKepalaForm({super.key});

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    return BlocBuilder<FormPemeriksaanVaksinasiCubit,
        FormPemeriksaanVaksinasiState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Lingkar Kepala')),
                const SizedBox(width: 5),
                Expanded(
                    flex: 2,
                    child: MyTextFormField(
                      keyboardType: TextInputType.number,
                      hintText: '15',
                      onChanged: (value) {
                        pemeriksaanBloc.changeLingkarKepala(int.parse(value));
                      },
                    )),
                const SizedBox(width: 5),
                const Expanded(flex: 1, child: Text('cm')),
              ],
            ),
            () {
              if (pemeriksaanBloc.state.status ==
                  FormzSubmissionStatus.failure) {
                if (pemeriksaanBloc.state.lingkarKepala == null) {
                  return Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Lingkar kepala harus diisi!',
                      style: TextStyle(color: Colors.red[400]),
                    ),
                  );
                }
              }
              return Container();
            }(),
          ],
        );
      },
    );
  }
}

class _PemeriksaanFisik extends StatelessWidget {
  const _PemeriksaanFisik();

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
  const _RiwayatKeluhan();

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
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
          child: TextField(
            onChanged: (value) => pemeriksaanBloc.changeRiwayatKeluhan(value),
            minLines: 1,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Tidak ada riwayat keluhan',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    final pasien = pemeriksaanBloc.state.pasien;
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: const Text("Simpan dan Lanjutkan"),
        onPressed: () {
          pemeriksaanBloc.validateForm();
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, auth) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: pemeriksaanBloc,
                    ),
                    BlocProvider(
                      create: (context) => getIt<CheckupCubit>()
                        ..getCheckupByPatientId(pasien?.nik),
                    ),
                  ],
                  child: const GrafikPemeriksaanScreen(),
                );
              },
            );
          }));
        },
      ),
    );
  }
}
