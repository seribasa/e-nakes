import 'package:eimunisasi_nakes/core/widgets/custom_text_field.dart';
import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/cubit/form_pemeriksaan_vaksinasi_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/grafik_pemeriksaan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class FormPemeriksaanScreen extends StatelessWidget {
  const FormPemeriksaanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Pemeriksaan Pasien'),
      ),
      body: BlocListener<FormPemeriksaanVaksinasiCubit,
          FormPemeriksaanVaksinasiState>(
        listener: (context, state) {
          if (state.status == FormzStatus.valid) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider.value(
                value: _pemeriksaanBloc,
                child: const GrafikPemeriksaanScreen(),
              );
            }));
          }
        },
        child: SingleChildScrollView(
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
      ),
      bottomNavigationBar: const _NextButton(),
    );
  }
}

class _BeratBadanForm extends StatelessWidget {
  const _BeratBadanForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pemeriksaanBloc =
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
                        _pemeriksaanBloc.changeBeratBadan(int.parse(value));
                      },
                    )),
                const SizedBox(width: 5),
                const Expanded(flex: 1, child: Text('kg')),
              ],
            ),
            () {
              if (_pemeriksaanBloc.state.status == FormzStatus.invalid) {
                if (_pemeriksaanBloc.state.beratBadan == null) {
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
  const TinggiBadanForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pemeriksaanBloc =
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
                        _pemeriksaanBloc.changeTinggiBadan(int.parse(value));
                      },
                    )),
                const SizedBox(width: 5),
                const Expanded(flex: 1, child: Text('cm')),
              ],
            ),
            () {
              if (_pemeriksaanBloc.state.status == FormzStatus.invalid) {
                if (_pemeriksaanBloc.state.tinggiBadan == null) {
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
  const LingkarKepalaForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pemeriksaanBloc =
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
                        _pemeriksaanBloc.changeLingkarKepala(int.parse(value));
                      },
                    )),
                const SizedBox(width: 5),
                const Expanded(flex: 1, child: Text('cm')),
              ],
            ),
            () {
              if (_pemeriksaanBloc.state.status == FormzStatus.invalid) {
                if (_pemeriksaanBloc.state.lingkarKepala == null) {
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
    final _pemeriksaanBloc =
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
            onChanged: (value) => _pemeriksaanBloc.changeRiwayatKeluhan(value),
            minLines: 1,
            maxLines: 10,
            decoration: const InputDecoration(
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
    final _pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: const Text("Simpan dan Lanjutkan"),
        onPressed: () {
          _pemeriksaanBloc.validateForm();
        },
      ),
    );
  }
}
