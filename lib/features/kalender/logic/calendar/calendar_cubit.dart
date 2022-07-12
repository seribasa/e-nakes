import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';
import 'package:equatable/equatable.dart';

part 'calendar_state.dart';

class CalendarCubit extends Cubit<CalendarState> {
  CalendarCubit() : super(CalendarInitial());
}
