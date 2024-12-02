part of 'jadwal_cubit.dart';

abstract class JadwalState extends Equatable {
  final List<JadwalPasienModel>? jadwalPasienModel;
  const JadwalState({this.jadwalPasienModel});

  @override
  List<Object?> get props => [jadwalPasienModel];
}

class JadwalInitial extends JadwalState {}

class JadwalLoading extends JadwalState {}

class JadwalLoaded extends JadwalState {
  const JadwalLoaded({super.jadwalPasienModel});

  @override
  List<Object?> get props => [jadwalPasienModel];
}

class JadwalError extends JadwalState {
  final String message;
  const JadwalError({required this.message});

  @override
  List<Object> get props => [message];
}
