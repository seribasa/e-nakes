part of 'form_pemeriksaan_vaksinasi_cubit.dart';

class FormPemeriksaanVaksinasiState extends Equatable {
  final FormzStatus? status;
  final String? errorMessage;
  final int? beratBadan;
  final int? tinggiBadan;
  final int? lingkarKepala;
  final String? riwayatKeluhan;
  final String? diagnosa;
  final String? tindakan;
  final String? idPasien;
  final String? idAnakPasien;
  const FormPemeriksaanVaksinasiState({
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.beratBadan,
    this.tinggiBadan,
    this.lingkarKepala,
    this.riwayatKeluhan,
    this.diagnosa,
    this.tindakan,
    this.idPasien,
    this.idAnakPasien,
  });

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        beratBadan,
        tinggiBadan,
        lingkarKepala,
        riwayatKeluhan,
        diagnosa,
        tindakan,
        idPasien,
        idAnakPasien,
      ];

  FormPemeriksaanVaksinasiState copyWith({
    FormzStatus? status,
    String? errorMessage,
    int? beratBadan,
    int? tinggiBadan,
    int? lingkarKepala,
    String? riwayatKeluhan,
    String? diagnosa,
    String? tindakan,
    String? idPasien,
    String? idAnakPasien,
  }) {
    return FormPemeriksaanVaksinasiState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      beratBadan: beratBadan ?? this.beratBadan,
      tinggiBadan: tinggiBadan ?? this.tinggiBadan,
      lingkarKepala: lingkarKepala ?? this.lingkarKepala,
      riwayatKeluhan: riwayatKeluhan ?? this.riwayatKeluhan,
      diagnosa: diagnosa ?? this.diagnosa,
      tindakan: tindakan ?? this.tindakan,
      idPasien: idPasien ?? this.idPasien,
      idAnakPasien: idAnakPasien ?? this.idAnakPasien,
    );
  }
}
