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
  final BasePagination<CalendarModel>? calendarPagination;

  const CalendarLoaded({this.calendarPagination});

  @override
  List<Object?> get props => [calendarPagination];
}

class CalendarDeleted extends CalendarState {}

class CalendarSuccess extends CalendarState {}

class CalendarFailure extends CalendarState {
  final String? error;
  const CalendarFailure({this.error});
  @override
  List<Object?> get props => [error];
}
