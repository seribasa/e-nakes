part of 'pemeriksaan_cubit.dart';

abstract class PemeriksaanState extends Equatable {
  const PemeriksaanState();

  @override
  List<Object?> get props => [];
}

class PemeriksaanInitial extends PemeriksaanState {}

class PemeriksaanLoading extends PemeriksaanState {}

class PemeriksaanLoaded extends PemeriksaanState {
  final List<PemeriksaanModel>? pemeriksaan;

  const PemeriksaanLoaded({required this.pemeriksaan});

  @override
  List<Object?> get props => [pemeriksaan];
}

class PemeriksaanError extends PemeriksaanState {
  final String message;

  const PemeriksaanError({required this.message});

  @override
  List<Object> get props => [message];
}
