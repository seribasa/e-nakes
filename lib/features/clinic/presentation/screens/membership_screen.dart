import 'package:eimunisasi_nakes/core/extension/context_ext.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_member_model.dart';
import 'package:eimunisasi_nakes/features/clinic/logic/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';

class ClinicMembershipScreen extends StatelessWidget {
  final String clinicId;
  const ClinicMembershipScreen({super.key, required this.clinicId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ClinicBloc>()
        ..add(ClinicMembershipSelected(clinicId: clinicId)),
      child: const _ClinicMembershipScaffold(),
    );
  }
}

class _ClinicMembershipScaffold extends StatelessWidget {
  const _ClinicMembershipScaffold();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keanggotaan Klinik'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<ClinicBloc, ClinicState>(
          builder: (context, state) {
            if (state is ClinicLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ClinicFailure) {
              return const Center(
                child: Text('Data gagal dimuat'),
              );
            } else if (state is ClinicMemberDataFetched) {
              return _RowAnggotaKlinik(data: state.data);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )),
    );
  }
}

class _RowAnggotaKlinik extends StatelessWidget {
  final List<ClinicMemberModel>? data;
  const _RowAnggotaKlinik({this.data});

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            TableCell(
              child: Text(
                'Anggota',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TableCell(
              child: Text(
                'Profesi',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        for (final member in data ?? [])
          TableRow(
            children: [
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(member.healthWorkerName ?? ''),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(member.healthWorkerProfession ?? ''),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
