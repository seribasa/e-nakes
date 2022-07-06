import 'package:eimunisasi_nakes/core/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class UpdateEventKalenderScreen extends StatelessWidget {
  const UpdateEventKalenderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Update Kegiatan'),
        elevation: 0.0,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                SizedBox(height: 5.0),
                _TanggalForm(
                  initialValue: 'yyyy-MM-dd',
                ),
                SizedBox(height: 10.0),
                _ActivityForm(
                  initialValue: 'Periksa bayi dan imunisasi',
                ),
                SizedBox(
                  height: 20.0,
                ),
              ]),
        ),
      ),
      bottomNavigationBar: const _SaveButton(),
    );
  }
}

class _TanggalForm extends StatelessWidget {
  final String? initialValue;
  const _TanggalForm({Key? key, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pilih Tanggal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          // onTap: () {
          //   DatePicker.showDatePicker(context,
          //       theme: DatePickerTheme(
          //         doneStyle: TextStyle(
          //             color: Theme.of(context).accentColor),
          //       ),
          //       showTitleActions: true,
          //       minTime: kFirstDay,
          //       maxTime: kLastDay, onConfirm: (val) {
          //     String formattedDate =
          //         DateFormat('yyyy-MM-dd').format(val);
          //     setState(() {
          //       _dateTimeCtrl.text = formattedDate.toString();
          //     });
          //   },
          //       currentTime: DateTime.now(),
          //       locale: LocaleType.id);
          // },
          readOnly: true,
          initialValue: initialValue,
        ),
      ],
    );
  }
}

class _ActivityForm extends StatelessWidget {
  final String? initialValue;
  const _ActivityForm({Key? key, this.initialValue}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Deskripsi Kegiatan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          initialValue: initialValue,
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: const Text("Simpan"),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return GrafikPemeriksaanScreen();
          // }));
        },
      ),
    );
  }
}
