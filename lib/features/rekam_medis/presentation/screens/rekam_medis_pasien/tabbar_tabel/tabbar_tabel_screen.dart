import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TabbarTabelScreen extends StatelessWidget {
  const TabbarTabelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
      builder: (context, state) {
        final List<PemeriksaanModel> _pemeriksaan =
            (state is PemeriksaanLoaded) ? state.pemeriksaan ?? [] : [];

        final List<TableRow> listBodyTable =
            List.generate(_pemeriksaan.length, (index) {
          final data = _pemeriksaan[index];
          return TableRow(
            children: <Widget>[
              Text(DateFormat('dd/MM/yyyy')
                  .format(data.createdAt ?? DateTime.now())),
              Text(data.beratBadan?.toString() ?? ''),
              Text(data.tinggiBadan?.toString() ?? ''),
              Text(data.lingkarKepala?.toString() ?? ''),
            ],
          );
        });

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Table(
              border: TableBorder.all(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey,
                width: 1,
              ),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                const TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  children: [
                    Text('Hari/Bulan'),
                    Text('BB (KG)'),
                    Text('TB (CM)'),
                    Text('LK (CM)'),
                  ],
                ),
                ...listBodyTable.map((e) => e),
              ],
            ),
          ),
        );
      },
    );
  }
}
