import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/calendar/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/calendar/data/repositories/calendar_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'calendar_state.dart';

@injectable
class CalendarCubit extends Cubit<CalendarState> {
  final CalendarRepository _calendarRepository;
  CalendarCubit(
    this._calendarRepository,
  ) : super(CalendarInitial());

  Future<void> getAllCalendar() async {
    emit(CalendarLoading());
    try {
      final result = await _calendarRepository.getCalendarActivity();
      emit(CalendarLoaded(calendarPagination: result));
    } catch (e) {
      CalendarFailure(
        error: 'Terjadi kesalahan saat mengambil data, silahkan coba lagi',
      );
    }
  }

  Future<void> getSpecificCalendar(DateTime date) async {
    emit(CalendarLoading());
    try {
      final result = await _calendarRepository.getSpecificCalendarActivity(
        date: date,
      );
      emit(CalendarLoaded(calendarPagination: result));
    } catch (e) {
      CalendarFailure(
        error: 'Terjadi kesalahan saat mengambil data, silahkan coba lagi',
      );
    }
  }

  Future<void> deleteCalendarByDocId(String docId) async {
    emit(CalendarDeleting());
    try {
      await _calendarRepository.deleteCalendarActivity(docId: docId);
      emit(CalendarDeleted());
    } catch (e) {
      CalendarFailure(
        error: 'Terjadi kesalahan saat menghapus data, silahkan coba lagi',
      );
    }
  }
}
