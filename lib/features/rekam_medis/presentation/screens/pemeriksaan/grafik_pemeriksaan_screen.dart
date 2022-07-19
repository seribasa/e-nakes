import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/cubit/form_pemeriksaan_vaksinasi_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/form_diagnosa_tindakan_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GrafikPemeriksaanScreen extends StatelessWidget {
  const GrafikPemeriksaanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grafik Pemeriksaan')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: PasienCard(
              nama: 'Rizky Faturriza',
              umur: '1 bulan',
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
                    const Expanded(
                      child: TabBarView(
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          LineChartSample1(),
                          LineChartSample1(),
                          LineChartSample1(),
                        ],
                      ),
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
