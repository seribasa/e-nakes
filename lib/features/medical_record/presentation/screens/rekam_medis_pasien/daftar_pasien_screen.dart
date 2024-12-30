import 'package:eimunisasi_nakes/core/widgets/search_bar_widget.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/patient_cubit/patient_cubit.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/rekam_medis_pasien/rekam_medis_pasien_screen.dart';
import 'package:eimunisasi_nakes/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaftarPasienScreen extends StatelessWidget {
  const DaftarPasienScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            _SearchBar(),
            Expanded(child: _ListPasien()),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final pasienBloc = BlocProvider.of<PatientCubit>(context);
    return SearchBarPeltops(
      hintText: 'Cari Pasien (NIK) ...',
      onChanged: (val) {
        pasienBloc.getPasienBySearch(val);
      },
      onPressed: () {},
    );
  }
}

class _ListPasien extends StatelessWidget {
  const _ListPasien();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PatientCubit, PatientState>(
      builder: (context, state) {
        if (state is PatientLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PatientLoaded) {
          if (state.patientPagination?.data?.isEmpty ?? true) {
            return const Center(
              child: Text('Tidak ada pasien'),
            );
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, auth) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        state.patientPagination?.data?.length ?? 0, (index) {
                      final pasien = state.patientPagination?.data?[index];
                      return ListTile(
                        title: Text(
                          '${pasien?.nik}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('${pasien?.nama}'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => getIt<CheckupCubit>()
                                  ..getCheckupByPatientId(pasien?.nik),
                                child: RekamMedisPasienScreen(
                                  pasien: pasien,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: Text('Tidak ada data'),
          );
        }
      },
    );
  }
}
