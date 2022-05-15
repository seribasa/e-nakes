part of 'klinik_bloc.dart';

class KlinikEvent extends Equatable {
  const KlinikEvent();

  @override
  List<Object> get props => [];
}

class KlinikKeanggotaanPressed extends KlinikEvent {
  @override
  String toString() => 'KeanggotaanKlinikPressed';
}

class KlinikProfilePressed extends KlinikEvent {
  @override
  String toString() => 'KlinikProfilePressed';
}
