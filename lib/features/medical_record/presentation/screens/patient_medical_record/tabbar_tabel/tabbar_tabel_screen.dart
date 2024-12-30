import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TabbarTabelScreen extends StatelessWidget {
  const TabbarTabelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckupCubit, CheckupState>(
      builder: (context, state) {
        final List<CheckupModel> pemeriksaan =
            (state is CheckupLoaded) ? state.checkupResult?.data ?? [] : [];

        final List<DataRow> listBodyTable =
            List.generate(pemeriksaan.length, (index) {
          final data = pemeriksaan[index];
          return DataRow(cells: [
            DataCell(Text(DateFormat('dd/MM/yyyy')
                .format(data.createdAt ?? DateTime.now()))),
            DataCell(Text(data.weight?.toString() ?? '')),
            DataCell(Text(data.height?.toString() ?? '')),
            DataCell(Text(data.headCircumference?.toString() ?? '')),
          ]);
        });

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: DataTable(
              headingTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Nunito',
                color: Colors.black,
              ),
              border: TableBorder.all(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey,
                width: 1,
              ),
              columns: const [
                DataColumn(
                  label: Text('Tanggal'),
                ),
                DataColumn(
                  label: Text('BB (KG)'),
                ),
                DataColumn(
                  label: Text('TB (CM)'),
                ),
                DataColumn(
                  label: Text('LK (CM)'),
                ),
              ],
              rows: [
                ...listBodyTable,
              ],
            ),
          ),
        );
      },
    );
  }
}
