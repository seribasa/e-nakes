import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/checkup_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/checkup_model.dart';

part 'checkup_state.dart';

@injectable
class CheckupCubit extends Cubit<CheckupState> {
  final CheckupRepository _checkupRepository;

  CheckupCubit(this._checkupRepository) : super(CheckupInitial());

  Future<void> getCheckupByPatientId(String? idPasien) async {
    emit(CheckupLoading());
    try {
      final result = await _checkupRepository.getCheckups(
        patientId: idPasien,
      );

      emit(CheckupLoaded(checkupResult: result));
    } catch (e) {
      emit(CheckupError(message: 'Gagal memuat data, coba lagi'));
    }
  }
}
