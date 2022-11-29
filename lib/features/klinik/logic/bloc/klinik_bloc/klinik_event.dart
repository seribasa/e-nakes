part of 'klinik_bloc.dart';

class KlinikEvent extends Equatable {
  const KlinikEvent();

  @override
  List<Object> get props => [];
}

class KlinikKeanggotaanPressed extends KlinikEvent {
  final String? clinicId;

  const KlinikKeanggotaanPressed({required this.clinicId});
  @override
  String toString() => 'KeanggotaanKlinikPressed';
}

class KlinikProfilePressed extends KlinikEvent {
  final String? clinicId;

  const KlinikProfilePressed({required this.clinicId});
  @override
  String toString() => 'KlinikProfilePressed';
}
