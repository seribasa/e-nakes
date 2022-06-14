import 'package:flutter/material.dart';

class TabbarVaksinScreen extends StatelessWidget {
  const TabbarVaksinScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(100, (index) {
                if (index == 0) {
                  // Title
                  return const Text(
                    'Tanggal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                } else {
                  // Body
                  return Text(
                    '$index/${index + 1}/${index + 2000}',
                  );
                }
              }),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(100, (index) {
                if (index == 0) {
                  // Title
                  return const Text(
                    'Jenis Vaksin',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  );
                } else {
                  // Body
                  return Text(
                    'Vaksin $index',
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
