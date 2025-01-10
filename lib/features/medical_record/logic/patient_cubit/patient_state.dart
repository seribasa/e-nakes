part of 'patient_cubit.dart';

abstract class PatientState extends Equatable {
  final BasePagination<PatientModel>? patientPagination;
  final String? searchQuery;

  const PatientState({this.patientPagination, this.searchQuery});

  @override
  List<Object?> get props => [patientPagination, searchQuery];
}

class PatientInitial extends PatientState {}

class PatientLoading extends PatientState {}

class PatientLoaded extends PatientState {
  const PatientLoaded({super.patientPagination});

  @override
  List<Object> get props => [];
}

class PatientError extends PatientState {
  final String message;

  const PatientError({required this.message});

  @override
  List<Object> get props => [message];
}
