part of 'appointment_cubit.dart';

abstract class AppointmentState extends Equatable {
  final BasePagination<PatientAppointmentModel>? paginationAppointment;

  const AppointmentState({this.paginationAppointment});

  @override
  List<Object?> get props => [paginationAppointment];
}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentLoaded extends AppointmentState {
  final PatientAppointmentModel? todayAppointment;
  final PatientAppointmentModel? selectedAppointment;

  const AppointmentLoaded({
    this.todayAppointment,
    this.selectedAppointment,
    super.paginationAppointment,
  });

  @override
  List<Object?> get props => [paginationAppointment];
}

class AppointmentError extends AppointmentState {
  final String message;

  const AppointmentError({required this.message});

  @override
  List<Object> get props => [message];
}
