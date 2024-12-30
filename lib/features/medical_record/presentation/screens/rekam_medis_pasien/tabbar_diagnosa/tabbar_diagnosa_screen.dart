import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TabbarDiagnosaScreen extends StatelessWidget {
  const TabbarDiagnosaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckupCubit, CheckupState>(
      builder: (context, state) {
        final List<CheckupModel> pemeriksaan =
            (state is CheckupLoaded) ? state.checkupResult?.data ?? [] : [];

        return SingleChildScrollView(
          child: Column(
            children: [
              ...List.generate(pemeriksaan.length, (index) {
                final data = pemeriksaan[index];
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        title: Text(
                            'Keluhan ${DateFormat('dd/MM/yyyy').format(data.createdAt ?? DateTime.now())}'),
                        subtitle: Text(data.complaint ?? 'Tidak ada keluhan'),
                      ),
                      ListTile(
                        title: const Text('Diagnosa'),
                        subtitle: Text(data.diagnosis ?? 'Tidak ada diagnosa'),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}
