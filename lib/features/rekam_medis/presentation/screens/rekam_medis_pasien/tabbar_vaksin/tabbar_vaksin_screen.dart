import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TabbarVaksinScreen extends StatelessWidget {
  const TabbarVaksinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PemeriksaanCubit, PemeriksaanState>(
      builder: (context, state) {
        final List<PemeriksaanModel> _pemeriksaan =
            (state is PemeriksaanLoaded) ? state.pemeriksaan ?? [] : [];
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                DataColumn(label: Text('Tanggal')),
                DataColumn(label: Text('Vaksin')),
              ],
              rows: [
                ..._pemeriksaan.map((data) {
                  return DataRow(cells: [
                    DataCell(Text(DateFormat('dd/MM/yyyy')
                        .format(data.createdAt ?? DateTime.now()))),
                    DataCell(Text(data.jenisVaksin ?? '')),
                  ]);
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
