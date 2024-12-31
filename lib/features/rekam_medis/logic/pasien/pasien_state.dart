part of 'pasien_cubit.dart';

abstract class PasienState extends Equatable {
  final BasePagination<PasienModel>? patientPagination;
  final String? searchQuery;

  const PasienState({this.patientPagination, this.searchQuery});

  @override
  List<Object?> get props => [patientPagination, searchQuery];
}

class PasienInitial extends PasienState {}

class PasienLoading extends PasienState {}

class PasienLoaded extends PasienState {
  const PasienLoaded({super.patientPagination});

  @override
  List<Object> get props => [];
}

class PasienError extends PasienState {
  final String message;

  const PasienError({required this.message});

  @override
  List<Object> get props => [message];
}
