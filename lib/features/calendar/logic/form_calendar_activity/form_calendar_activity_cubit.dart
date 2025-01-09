import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/calendar/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/calendar/data/repositories/calendar_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'form_calendar_activity_state.dart';

@injectable
class FormCalendarActivityCubit extends Cubit<FormCalendarActivityState> {
  final CalendarRepository _calendarRepository;
  FormCalendarActivityCubit(
    this._calendarRepository,
  ) : super(FormCalendarActivityState());

  void dateChange(DateTime value) {
    emit(state.copyWith(
      activity: state.activity,
      date: value,
    ));
  }

  void activityChange(String value) {
    emit(state.copyWith(
      activity: value,
      date: state.date,
    ));
  }

  Future<void> addCalendarActivity() async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _calendarRepository.addCalendarActivity(
        calendarModel: CalendarModel(
          doAt: state.date,
          activity: state.activity,
        ),
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage:
            'Terjadi kesalahan saat menambahkan data, silahkan coba lagi',
      ));
    }
  }

  Future<void> updateCalendarActivity(CalendarModel model) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _calendarRepository.updateCalendarActivity(
        calendarModel: model,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage:
            'Terjadi kesalahan saat mengubah data, silahkan coba lagi',
      ));
    }
  }

  void reset() {
    emit(state.copyWith(
      activity: '',
      date: DateTime.now(),
      status: FormzSubmissionStatus.initial,
    ));
  }
}
