import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/checkup_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'checkup_form_state.dart';

@injectable
class FormPemeriksaanVaksinasiCubit
    extends Cubit<FormPemeriksaanVaksinasiState> {
  final CheckupRepository _pemeriksaanRepository;
  
  FormPemeriksaanVaksinasiCubit(this._pemeriksaanRepository)
      : super(FormPemeriksaanVaksinasiState());

  providePasienData(
      String? idPasien, String? idOrangTuaPasien, PatientModel pasien) {
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

  changeTypeOfVaccine(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(
        jenisVaksin: null,
        errorMessage: 'Jenis vaksin tidak boleh kosong',
      ));
      return;
    }
    emit(state.copyWith(
      jenisVaksin: value,
    ));
  }

  changeMonthOfVisit(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(
        bulanKe: null,
        errorMessage: 'Bulan kunjungan tidak boleh kosong',
      ));
      return;
    }
    emit(state.copyWith(
      bulanKe: value,
    ));
  }

  changeTindakan(String value) {
    emit(state.copyWith(
      tindakan: value,
    ));
  }

  validateForm() {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    final validate = state.beratBadan != null &&
        state.tinggiBadan != null &&
        state.lingkarKepala != null;
    if (validate) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    } else {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
      ));
    }
  }

  void savePemeriksaanVaksinasi() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      final data = CheckupModel(
        weight: state.beratBadan,
        height: state.tinggiBadan,
        headCircumference: state.lingkarKepala,
        complaint: state.riwayatKeluhan,
        diagnosis: state.diagnosa,
        action: state.tindakan,
        patientId: state.idPasien,
        parentId: state.idOrangTuaPasien,
        vaccineType: state.jenisVaksin,
        month: state.bulanKe,
        createdAt: DateTime.now(),
      );
      await _pemeriksaanRepository.setCheckup(checkupModel: data);
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
