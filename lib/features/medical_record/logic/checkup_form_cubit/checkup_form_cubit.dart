import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/checkup_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'checkup_form_state.dart';

@injectable
class CheckupFormCubit extends Cubit<CheckupFormState> {
  final CheckupRepository _pemeriksaanRepository;

  CheckupFormCubit(this._pemeriksaanRepository) : super(CheckupFormState());

  selectedPatient(PatientModel? patient) {
    emit(state.copyWith(
      patient: patient,
    ));
  }

  changeWeight(int value) {
    emit(state.copyWith(
        checkup: state.checkup.copyWith(
      weight: value,
    )));
  }

  changeHeight(int value) {
    emit(state.copyWith(
        checkup: state.checkup.copyWith(
      height: value,
    )));
  }

  changeHeadCircumference(int value) {
    emit(state.copyWith(
        checkup: state.checkup.copyWith(
      headCircumference: value,
    )));
  }

  changeComplaint(String value) {
    emit(state.copyWith(
        checkup: state.checkup.copyWith(
      complaint: value,
    )));
  }

  changeDiagnosis(String value) {
    emit(state.copyWith(
        checkup: state.checkup.copyWith(
      diagnosis: value,
    )));
  }

  changeTypeOfVaccine(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(
        errorMessage: 'Jenis vaksin tidak boleh kosong',
      ));
      return;
    }
    emit(state.copyWith(
        checkup: state.checkup.copyWith(
      vaccineType: value,
    )));
  }

  changeMonthOfVisit(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(
        checkup: state.checkup.copyWith(
          month: value,
        ),
        errorMessage: 'Bulan kunjungan tidak boleh kosong',
      ));
      return;
    }
    emit(state.copyWith(
      checkup: state.checkup.copyWith(
        month: value,
      ),
    ));
  }

  changeAction(String value) {
    emit(state.copyWith(
      checkup: state.checkup.copyWith(
        action: value,
      ),
    ));
  }

  void submit() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      final data = state.checkup.copyWith(
        patientId: state.patient?.id,
        parentId: state.patient?.parentId,
        createdAt: DateTime.now(),
      );
      await _pemeriksaanRepository.setCheckup(checkupModel: data);
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: FormzSubmissionStatus.failure,
        errorMessage: 'Gagal mengirim data, coba lagi',
      ));
    }
  }
}
