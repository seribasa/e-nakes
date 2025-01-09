part of 'form_calendar_activity_cubit.dart';

class FormCalendarActivityState extends Equatable {
  final DateTime? date;
  final String? activity;
  final FormzSubmissionStatus status;
  final String? errorMessage;

  const FormCalendarActivityState({
    this.date,
    this.activity,
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

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
