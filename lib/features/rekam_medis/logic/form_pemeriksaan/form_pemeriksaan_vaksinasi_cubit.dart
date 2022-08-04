import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/repositories/pemeriksaan_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'form_pemeriksaan_vaksinasi_state.dart';

class FormPemeriksaanVaksinasiCubit
    extends Cubit<FormPemeriksaanVaksinasiState> {
  final PemeriksaanRepository _pemeriksaanRepository;
  final UserData? userData;
  FormPemeriksaanVaksinasiCubit({
    PemeriksaanRepository? pemeriksaanRepository,
    required this.userData,
  })  : _pemeriksaanRepository =
            pemeriksaanRepository ?? PemeriksaanRepository(),
        super(const FormPemeriksaanVaksinasiState());

  providePasienData(
      String? idPasien, String? idOrangTuaPasien, PasienModel pasien) {
    emit(state.copyWith(
      idPasien: idPasien,
      idOrangTuaPasien: idOrangTuaPasien,
      pasien: pasien,
    ));
  }

  changeBeratBadan(int value) {
    emit(state.copyWith(
      beratBadan: value,
    ));
  }

  changeTinggiBadan(int value) {
    emit(state.copyWith(
      tinggiBadan: value,
    ));
  }

  changeLingkarKepala(int value) {
    emit(state.copyWith(
      lingkarKepala: value,
    ));
  }

  changeRiwayatKeluhan(String value) {
    emit(state.copyWith(
      riwayatKeluhan: value,
    ));
  }

  changeDiagnosa(String value) {
    emit(state.copyWith(
      diagnosa: value,
    ));
  }

  changeTindakan(String value) {
    emit(state.copyWith(
      tindakan: value,
    ));
  }

  validateForm() {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    final validate = state.beratBadan != null &&
        state.tinggiBadan != null &&
        state.lingkarKepala != null;
    if (validate) {
      emit(state.copyWith(
        status: FormzStatus.valid,
      ));
    } else {
      emit(state.copyWith(
        status: FormzStatus.invalid,
      ));
    }
  }

  void savePemeriksaanVaksinasi() async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    try {
      final data = PemeriksaanModel(
        beratBadan: state.beratBadan,
        tinggiBadan: state.tinggiBadan,
        lingkarKepala: state.lingkarKepala,
        riwayatKeluhan: state.riwayatKeluhan ?? 'Tidak ada riwayat keluhan',
        diagnosa: state.diagnosa ?? 'Tidak ada diagnosa',
        tindakan: state.tindakan ?? 'Tidak ada tindakan',
        idPasien: state.idPasien,
        idOrangTuaPasien: state.idOrangTuaPasien,
        idDokter: userData?.id,
        createdAt: DateTime.now(),
      );
      await _pemeriksaanRepository.setPemeriksaan(pemeriksaanModel: data);
      emit(state.copyWith(
        status: FormzStatus.submissionSuccess,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
        errorMessage: e.toString(),
      ));
    }
  }
}
