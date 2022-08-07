import 'package:eimunisasi_nakes/core/widgets/grafik/grafik_berat_badan.dart';
import 'package:eimunisasi_nakes/core/widgets/grafik/grafik_tinggi_badan.dart';
import 'package:eimunisasi_nakes/core/widgets/grafik/grafik_lingkar_kepala.dart';
import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/form_pemeriksaan/form_pemeriksaan_vaksinasi_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/form_diagnosa_tindakan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GrafikPemeriksaanScreen extends StatelessWidget {
  const GrafikPemeriksaanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pemeriksaanBloc =
        BlocProvider.of<FormPemeriksaanVaksinasiCubit>(context);
    final _pasien = _pemeriksaanBloc.state.pasien;
    return Scaffold(
      appBar: AppBar(title: const Text('Grafik Pemeriksaan')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PasienCard(
              nama: _pasien?.nama,
              umur: _pasien?.umur,
              jenisKelamin: _pasien?.jenisKelamin,
            ),
          ),
          Expanded(
            child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.blue,
                      child: const TabBar(
                        indicatorColor: Colors.white,
                        tabs: [
                          Tab(
                            text: 'Berat badan',
                          ),
                          Tab(
                            text: 'Tinggi badan',
                          ),
                          Tab(
                            text: 'Lingkar kepala',
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
                      builder: (context, state) {
                        final List<PemeriksaanModel> data =
                            (state is PemeriksaanLoaded)
                                ? state.pemeriksaan ?? []
                                : [];
                        return Expanded(
                          child: TabBarView(
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              GrafikBeratBadan(
                                listData: data,
                                isBoy: _pasien?.jenisKelamin == "Laki-laki"
                                    ? true
                                    : false,
                              ),
                              GrafikTinggiBadan(
                                listData: data,
                                isBoy: _pasien?.jenisKelamin == "Laki-laki"
                                    ? true
                                    : false,
                              ),
                              GrafikLingkarKepala(
                                listData: data,
                                isBoy: _pasien?.jenisKelamin == "Laki-laki"
                                    ? true
                                    : false,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
      bottomNavigationBar: const _NextButton(),
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
        child: const Text("Lanjut"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider.value(
              value: _pemeriksaanBloc,
              child: const FormDiagnosaTindakanScreen(),
            );
          }));
        },
      ),
    );
  }
}
