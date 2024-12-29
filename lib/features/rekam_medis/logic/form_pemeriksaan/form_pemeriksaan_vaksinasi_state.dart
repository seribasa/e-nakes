part of 'form_pemeriksaan_vaksinasi_cubit.dart';

class FormPemeriksaanVaksinasiState extends Equatable {
  final FormzSubmissionStatus? status;
  final String? errorMessage;
  final int? beratBadan;
  final int? tinggiBadan;
  final int? lingkarKepala;
  final String? riwayatKeluhan;
  final String? diagnosa;
  final String? tindakan;
  final String? idPasien;
  final String? idOrangTuaPasien;
  final PatientModel? pasien;
  final String? bulanKe;
  final String? jenisVaksin;
  const FormPemeriksaanVaksinasiState({
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.beratBadan,
    this.tinggiBadan,
    this.lingkarKepala,
    this.riwayatKeluhan,
    this.diagnosa,
    this.tindakan,
    this.idPasien,
    this.idOrangTuaPasien,
    this.pasien,
    this.bulanKe,
    this.jenisVaksin,
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
        idOrangTuaPasien,
        pasien,
        bulanKe,
        jenisVaksin,
      ];

  FormPemeriksaanVaksinasiState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    int? beratBadan,
    int? tinggiBadan,
    int? lingkarKepala,
    String? riwayatKeluhan,
    String? diagnosa,
    String? tindakan,
    String? idPasien,
    String? idOrangTuaPasien,
    PatientModel? pasien,
    String? bulanKe,
    String? jenisVaksin,
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
      idOrangTuaPasien: idOrangTuaPasien ?? this.idOrangTuaPasien,
      pasien: pasien ?? this.pasien,
      bulanKe: bulanKe ?? this.bulanKe,
      jenisVaksin: jenisVaksin ?? this.jenisVaksin,
    );
  }
}
