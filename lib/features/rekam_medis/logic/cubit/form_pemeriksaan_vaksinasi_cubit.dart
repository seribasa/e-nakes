import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
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

  providePasienData(String idPasien, String idAnakPasien) {
    emit(state.copyWith(
      idPasien: idPasien,
      idAnakPasien: idAnakPasien,
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

  void savePemeriksaanVaksinasi() async {
    emit(state.copyWith(
      status: FormzStatus.submissionInProgress,
    ));
    try {
      final data = PemeriksaanModel(
        beratBadan: state.beratBadan,
        tinggiBadan: state.tinggiBadan,
        lingkarKepala: state.lingkarKepala,
        riwayatKeluhan: state.riwayatKeluhan,
        diagnosa: state.diagnosa,
        tindakan: state.tindakan,
        idPasien: state.idPasien,
        idAnakPasien: state.idAnakPasien,
        idDokter: userData?.id,
        createdAt: DateTime.now(),
      );
      await _pemeriksaanRepository.savePemeriksaan(pemeriksaanModel: data);
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
