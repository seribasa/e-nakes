part of 'jadwal_cubit.dart';

abstract class JadwalState extends Equatable {
  const JadwalState();

  @override
  List<Object> get props => [];
}

class JadwalInitial extends JadwalState {}

class JadwalLoading extends JadwalState {}

class JadwalLoaded extends JadwalState {
  final List<JadwalPasienModel> jadwalPasienModel;

  const JadwalLoaded({required this.jadwalPasienModel});

  @override
  List<Object> get props => [jadwalPasienModel];
}

class JadwalError extends JadwalState {
  final String message;
  const JadwalError({required this.message});

  @override
  List<Object> get props => [message];
}
