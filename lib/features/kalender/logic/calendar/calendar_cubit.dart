import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/kalender/data/repositories/calendar_repository.dart';
import 'package:equatable/equatable.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  final CalendarRepository _calendarRepository;
  final UserData? userData;
  CalendarCubit({
    CalendarRepository? calendarRepository,
    required this.userData,
  })  : _calendarRepository = calendarRepository ?? CalendarRepository(),
        super(CalendarInitial());

  Future<void> getAllCalendar() async {
    emit(CalendarLoading());
    try {
      final listCalendarModel =
          await _calendarRepository.getCalendarActivity(uid: userData?.id);
      emit(CalendarLoaded(listCalendarModel: listCalendarModel));
    } catch (e) {
      CalendarFailure(error: e.toString());
    }
  }

  Future<void> getSpecificCalendar(DateTime date) async {
    emit(CalendarLoading());
    try {
      final listCalendarModel = await _calendarRepository
          .getSpecificCalendarActivity(uid: userData?.id, date: date);
      emit(CalendarLoaded(listCalendarModel: listCalendarModel));
    } catch (e) {
      CalendarFailure(error: e.toString());
    }
  }

  deleteCalendarByDocId(String docId) async {
    emit(CalendarLoading());
    try {
      await _calendarRepository.deleteCalendarActivity(docId: docId);
      emit(CalendarDeleted());
    } catch (e) {
      CalendarFailure(error: e.toString());
    }
  }
}
