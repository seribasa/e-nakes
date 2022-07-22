part of 'pasien_cubit.dart';

abstract class PasienState extends Equatable {
  final String? searchQuery;
  const PasienState({this.searchQuery});

  @override
  List<Object?> get props => [searchQuery];
}

class PasienInitial extends PasienState {}

class PasienLoading extends PasienState {}

class PasienLoaded extends PasienState {
  final List<PasienModel> pasien;

  const PasienLoaded({required this.pasien});

  @override
  List<Object> get props => [pasien];
}

class PasienError extends PasienState {
  final String message;

  const PasienError({required this.message});

  @override
  List<Object> get props => [message];
}
