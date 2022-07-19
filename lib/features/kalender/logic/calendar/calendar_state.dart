part of 'calendar_cubit.dart';

abstract class CalendarState extends Equatable {
  const CalendarState();

  @override
  List<Object?> get props => [];
}

class CalendarInitial extends CalendarState {}

class CalendarLoading extends CalendarState {}

class CalendarDeleting extends CalendarState {}

class CalendarLoaded extends CalendarState {
  final List<CalendarModel>? listCalendarModel;

  const CalendarLoaded({this.listCalendarModel});

  @override
  List<Object?> get props => [listCalendarModel];
}

class CalendarDeleted extends CalendarState {}

class CalendarSuccess extends CalendarState {}

class CalendarFailure extends CalendarState {
  final String? error;
  const CalendarFailure({this.error});
  @override
  List<Object?> get props => [error];
}
