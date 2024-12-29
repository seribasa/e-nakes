import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/repositories/patient_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'pasien_state.dart';

@injectable
class PasienCubit extends Cubit<PasienState> {
  final PatientRepository _pasienRepository;

  PasienCubit(this._pasienRepository) : super(PasienInitial());

  Future<void> getPasienBySearch(String searchQuery) async {
    emit(PasienLoading());
    try {
      final result = await _pasienRepository.getPatients(
        nik: searchQuery,
      );

      if (state.patientPagination?.metadata?.page == 1) {
        emit(PasienLoaded(patientPagination: result));
        return;
      }
      final pagination = BasePagination<PatientModel>(
        data: [
          ...?state.patientPagination?.data,
          ...?result?.data,
        ],
        metadata: result?.metadata,
      );
      emit(PasienLoaded(patientPagination: pagination));
    } catch (e) {
      emit(PasienError(message: e.toString()));
    }
  }

  Future<void> getPasien({
    int? page,
    int? perPage,
}) async {
    emit(PasienLoading());
    try {
      final result = await _pasienRepository.getPatients(
        page: page,
        perPage: perPage,
      );
      emit(PasienLoaded(patientPagination: result));
    } catch (e) {
      emit(PasienError(message: e.toString()));
    }
  }
}
