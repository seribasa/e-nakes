import 'package:eimunisasi_nakes/core/widgets/grafik/grafik_tumbuh_kembang.dart';
import 'package:eimunisasi_nakes/core/widgets/grafik/line_chart_template.dart';
import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_form_cubit/checkup_form_cubit.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:eimunisasi_nakes/routers/medical_record_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/error.dart';
import '../../../../../injection.dart';

class CheckupChartScreen extends StatelessWidget {
  const CheckupChartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final patient = context.read<CheckupFormCubit>().state.patient;
    return BlocProvider(
      create: (context) {
        return getIt<CheckupCubit>()..getCheckupByPatientId(patient?.id);
      },
      child: _CheckupChartScaffold(),
    );
  }
}

class _CheckupChartScaffold extends StatelessWidget {
  const _CheckupChartScaffold();

  @override
  Widget build(BuildContext context) {
    final checkupBloc = BlocProvider.of<CheckupFormCubit>(context);
    final patient = checkupBloc.state.patient;
    return Scaffold(
      appBar: AppBar(title: const Text('Grafik Pemeriksaan')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: PasienCard(
              nama: patient?.nama,
              umur: patient?.umur,
              jenisKelamin: patient?.jenisKelamin,
            ),
          ),
          BlocBuilder<CheckupCubit, CheckupState>(
            builder: (context, state) {
              if (state is CheckupError) {
                return ErrorContainer(
                  title: state.message,
                  message: 'Coba Lagi',
                  onRefresh: () {
                    context
                        .read<CheckupCubit>()
                        .getCheckupByPatientId(patient?.id);
                  },
                );
              } else if (state is CheckupLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is CheckupLoaded) {
                return Expanded(
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
                        BlocBuilder<CheckupCubit, CheckupState>(
                          builder: (context, state) {
                            List<CheckupModel> data = (state is CheckupLoaded)
                                ? state.checkupResult?.data ?? []
                                : [];
                            CheckupModel pemeriksaanModel = CheckupModel(
                              month: checkupBloc.state.checkup.month,
                              weight: checkupBloc.state.checkup.weight,
                              height: checkupBloc.state.checkup.height,
                              headCircumference:
                                  checkupBloc.state.checkup.headCircumference,
                            );
                            data.add(pemeriksaanModel);
                            return Expanded(
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                                  GrafikPertumbuhan(
                                    type: LineChartType.beratBadan,
                                    listData: data,
                                    isBoy: patient?.jenisKelamin == "Laki-laki"
                                        ? true
                                        : false,
                                  ),
                                  GrafikPertumbuhan(
                                    type: LineChartType.tinggiBadan,
                                    listData: data,
                                    isBoy: patient?.jenisKelamin == "Laki-laki"
                                        ? true
                                        : false,
                                  ),
                                  GrafikPertumbuhan(
                                    type: LineChartType.lingkarKepala,
                                    listData: data,
                                    isBoy: patient?.jenisKelamin == "Laki-laki"
                                        ? true
                                        : false,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      bottomNavigationBar: const _NextButton(),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc = BlocProvider.of<CheckupFormCubit>(context);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: const Text("Lanjut"),
        onPressed: () {
          context.pushNamed(
            MedicalRecordRouter.checkupDiagnosisActionRoute.name,
            extra: pemeriksaanBloc,
          );
        },
      ),
    );
  }
}
