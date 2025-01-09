part of 'form_calendar_activity_cubit.dart';

class FormCalendarActivityState extends Equatable {
  final DateTime? date;
  final String? activity;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  FormCalendarActivityState({
    DateTime? date,
    this.activity,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  }) : date = date ?? DateTime.now();

  @override
  List<Object?> get props => [date, activity, status, errorMessage];

  FormCalendarActivityState copyWith({
    DateTime? date,
    String? activity,
    FormzSubmissionStatus? status,
    String? errorMessage,
  }) {
    return FormCalendarActivityState(
      date: date ?? this.date,
      activity: activity ?? this.activity,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
