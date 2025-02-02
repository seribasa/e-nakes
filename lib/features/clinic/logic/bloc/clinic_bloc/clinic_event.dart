part of 'clinic_bloc.dart';

class ClinicEvent extends Equatable {
  const ClinicEvent();

  @override
  List<Object> get props => [];
}

class ClinicMembershipSelected extends ClinicEvent {
  final String? clinicId;

  const ClinicMembershipSelected({required this.clinicId});
  @override
  String toString() => 'KeanggotaanKlinikPressed';
}

class ClinicProfileSelected extends ClinicEvent {
  final String? clinicId;

  const ClinicProfileSelected({required this.clinicId});
  @override
  String toString() => 'KlinikProfilePressed';
}
