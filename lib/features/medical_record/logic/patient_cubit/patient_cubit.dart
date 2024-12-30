import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'patient_state.dart';

@injectable
class PatientCubit extends Cubit<PatientState> {
  final PatientRepository _pasienRepository;

  PatientCubit(this._pasienRepository) : super(PatientInitial());

  Future<void> getPasienBySearch(String searchQuery) async {
    emit(PatientLoading());
    try {
      final result = await _pasienRepository.getPatients(
        nik: searchQuery,
      );

      if (state.patientPagination?.metadata?.page == 1) {
        emit(PatientLoaded(patientPagination: result));
        return;
      }
      final pagination = BasePagination<PatientModel>(
        data: [
          ...?state.patientPagination?.data,
          ...?result?.data,
        ],
        metadata: result?.metadata,
      );
      emit(PatientLoaded(patientPagination: pagination));
    } catch (e) {
      emit(PatientError(message: e.toString()));
    }
  }

  Future<void> getPasien({
    int? page,
    int? perPage,
  }) async {
    emit(PatientLoading());
    try {
      final result = await _pasienRepository.getPatients(
        page: page,
        perPage: perPage,
      );
      emit(PatientLoaded(patientPagination: result));
    } catch (e) {
      emit(PatientError(message: e.toString()));
    }
  }
}
