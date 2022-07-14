import 'package:date_time_picker/date_time_picker.dart';
import 'package:eimunisasi_nakes/core/widgets/custom_text_field.dart';
import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/kalender/logic/form_calendar_activity/form_calendar_activity_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';

class UpdateEventKalenderScreen extends StatelessWidget {
  final CalendarModel calendarModel;
  const UpdateEventKalenderScreen({Key? key, required this.calendarModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formBloc = BlocProvider.of<FormCalendarActivityCubit>(context);
    formBloc.activityChange(calendarModel.activity!);
    formBloc.dateChange(calendarModel.date!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Kegiatan'),
      ),
      resizeToAvoidBottomInset: false,
      body: BlocListener<FormCalendarActivityCubit, FormCalendarActivityState>(
        listener: (context, state) {
          if (state.status == FormzStatus.submissionSuccess) {
            formBloc.reset();
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Kegiatan berhasil diubah'),
              ),
            );
          } else if (state.status == FormzStatus.submissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Kegiatan gagal diubah'),
              ),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(height: 5.0),
              DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: calendarModel.date.toString(),
                firstDate: DateTime.now().add(const Duration(days: -365)),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                icon: const Icon(FontAwesomeIcons.calendarXmark),
                dateLabelText: 'Tanggal',
                timeLabelText: "Jam",
                selectableDayPredicate: (date) {
                  // Disable weekend days to select from the calendar
                  if (date.weekday == 6 || date.weekday == 7) {
                    return false;
                  }
                  return true;
                },
                onChanged: (val) {
                  DateTime value = DateTime.parse(val);
                  formBloc.dateChange(value);
                  debugPrint(val);
                },
                onSaved: (val) {
                  DateTime value =
                      DateTime.parse(val ?? DateTime.now().toString());
                  formBloc.dateChange(value);
                  debugPrint(val);
                },
              ),
              const SizedBox(height: 10.0),
              _ActivityForm(
                  initialValue: '${calendarModel.activity}',
                  onChanged: (val) {
                    formBloc.activityChange(val);
                  }),
              const SizedBox(
                height: 20.0,
              ),
            ]),
          ),
        ),
      ),
      bottomNavigationBar: _SaveButton(
        docId: calendarModel.documentID,
      ),
    );
  }
}

class _ActivityForm extends StatelessWidget {
  final String? initialValue;
  final void Function(String)? onChanged;
  const _ActivityForm({Key? key, this.initialValue, this.onChanged})
      : super(key: key);

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
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _SaveButton extends StatelessWidget {
  final String? docId;
  const _SaveButton({Key? key, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formBloc = BlocProvider.of<FormCalendarActivityCubit>(context);
    return BlocBuilder<FormCalendarActivityCubit, FormCalendarActivityState>(
      builder: (context, state) {
        if (state.status == FormzStatus.submissionInProgress) {
          return SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Menyimpan...'),
                  SizedBox(width: 10),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        }
        return SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            child: const Text("Simpan"),
            onPressed: () {
              _formBloc.updateCalendarActivity(docId: docId);
            },
          ),
        );
      },
    );
  }
}
