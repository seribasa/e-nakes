import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/kalender/data/repositories/calendar_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'form_calendar_activity_state.dart';

class FormCalendarActivityCubit extends Cubit<FormCalendarActivityState> {
  final CalendarRepository _calendarRepository;
  final UserData? userData;
  FormCalendarActivityCubit({
    CalendarRepository? calendarRepository,
    required this.userData,
  })  : _calendarRepository = calendarRepository ?? CalendarRepository(),
        super(FormCalendarActivityState(date: DateTime.now()));

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
              uid: userData?.id, date: state.date, activity: state.activity));
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> updateCalendarActivity({required String? docId}) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _calendarRepository.updateCalendarActivity(
        calendarModel: CalendarModel(
          uid: userData?.id,
          date: state.date,
          activity: state.activity,
        ),
        docId: docId,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
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
