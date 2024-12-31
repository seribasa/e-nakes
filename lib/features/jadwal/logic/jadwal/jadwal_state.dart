part of 'jadwal_cubit.dart';

abstract class JadwalState extends Equatable {
  final BasePagination<JadwalPasienModel>? paginationAppointment;

  const JadwalState({this.paginationAppointment});

  @override
  List<Object?> get props => [paginationAppointment];
}

class JadwalInitial extends JadwalState {}

class JadwalLoading extends JadwalState {}

class JadwalLoaded extends JadwalState {
  final JadwalPasienModel? todayAppointment;
  final JadwalPasienModel? selectedAppointment;

  const JadwalLoaded({
    this.todayAppointment,
    this.selectedAppointment,
    super.paginationAppointment,
  });

  @override
  List<Object?> get props => [paginationAppointment];
}

class JadwalError extends JadwalState {
  final String message;

  const JadwalError({required this.message});

  @override
  List<Object> get props => [message];
}
