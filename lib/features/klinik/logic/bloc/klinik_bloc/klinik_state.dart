part of 'klinik_bloc.dart';

abstract class KlinikState extends Equatable {
  const KlinikState();

  @override
  List<Object> get props => [];
}

class KlinikInitial extends KlinikState {}

class KlinikFetchData extends KlinikState {
  final Klinik? klinik;
  const KlinikFetchData({this.klinik});
  @override
  List<Object> get props => [klinik!];
}

class KlinikFetchDataAnggota extends KlinikState {
  final List<AnggotaKlinik>? data;
  const KlinikFetchDataAnggota({this.data});
  @override
  List<Object> get props => [data!];
}

class KlinikLoading extends KlinikState {}

class KlinikFailure extends KlinikState {
  final String? error;
  const KlinikFailure({this.error});
  @override
  List<Object> get props => [error!];
}
