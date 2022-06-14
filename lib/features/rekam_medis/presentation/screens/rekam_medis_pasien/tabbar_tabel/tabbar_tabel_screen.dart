import 'package:flutter/material.dart';

class TabbarTabelScreen extends StatelessWidget {
  const TabbarTabelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TableRow> listBodyTable = List.generate(100, (index) {
      return TableRow(
        children: <Widget>[
          Text('Minggu/${index + 1}'),
          Text('1${index + 1}'),
          Text('5${index + 1}'),
          Text('1${index + 1}'),
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
            const TableRow(
              children: <Widget>[
                Text('Minggu/1'),
                Text('10'),
                Text('50'),
                Text('15'),
              ],
            ),
            ...listBodyTable.map((e) => e),
          ],
        ),
      ),
    );
  }
}
