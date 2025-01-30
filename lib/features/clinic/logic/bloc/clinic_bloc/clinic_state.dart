part of 'clinic_bloc.dart';

abstract class ClinicState extends Equatable {
  const ClinicState();

  @override
  List<Object> get props => [];
}

class ClinicStateInitial extends ClinicState {}

class ClinicFetchData extends ClinicState {
  final ClinicModel? clinic;
  const ClinicFetchData({this.clinic});
  @override
  List<Object> get props => [clinic!];
}

class ClinicMemberDataFetched extends ClinicState {
  final List<ClinicMemberModel>? data;
  const ClinicMemberDataFetched({this.data});
  @override
  List<Object> get props => [data!];
}

class ClinicLoading extends ClinicState {}

class ClinicFailure extends ClinicState {
  final String? error;
  const ClinicFailure({this.error});
  @override
  List<Object> get props => [error!];
}
