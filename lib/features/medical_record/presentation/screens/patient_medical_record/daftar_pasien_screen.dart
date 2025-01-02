import 'package:eimunisasi_nakes/core/widgets/search_bar_widget.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/patient_cubit/patient_cubit.dart';
import 'package:eimunisasi_nakes/features/medical_record/presentation/screens/patient_medical_record/rekam_medis_pasien_screen.dart';
import 'package:eimunisasi_nakes/injection.dart';
import 'package:eimunisasi_nakes/routers/medical_record_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/error.dart';

class DaftarPasienScreen extends StatelessWidget {
  const DaftarPasienScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PatientCubit>(
      create: (context) => getIt<PatientCubit>()..getPasien(),
      child: Scaffold(
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
        }
        if (state is PatientError) {
          return ErrorContainer(
            title: state.message,
            message: 'Coba Lagi',
            onRefresh: () {
              context.read<PatientCubit>().getPasien();
            },
          );
        }
        if (state is PatientLoaded) {
          if (state.patientPagination?.data?.isEmpty ?? true) {
            return const Center(
              child: Text('Tidak ada pasien'),
            );
          }
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: state.patientPagination?.data?.length ?? 0,
            itemBuilder: (context, index) {
              final pasien = state.patientPagination?.data?[index];
              return ListTile(
                key: ValueKey(pasien?.id),
                title: Text(
                  '${pasien?.nik}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text('${pasien?.nama}'),
                onTap: () {
                  context.pushNamed(
                    MedicalRecordRouter.medicalRecordDetailRoute.name,
                    extra: RekamMedisPasienScreen(
                      pasien: pasien,
                    ),
                  );
                },
              );
            },
          );
        }
        return const Center(
          child: Text('Tidak ada data'),
        );
      },
    );
  }
}
