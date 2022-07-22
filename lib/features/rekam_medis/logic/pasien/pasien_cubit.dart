import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/repositories/pasien_repository.dart';
import 'package:equatable/equatable.dart';

part 'pasien_state.dart';

class PasienCubit extends Cubit<PasienState> {
  final PasienRepository _pasienRepository;
  PasienCubit({PasienRepository? pasienRepository})
      : _pasienRepository = pasienRepository ?? PasienRepository(),
        super(PasienInitial());

  Future<void> getPasienBySearch(String searchQuery) async {
    emit(PasienLoading());
    print(searchQuery);
    try {
      final listPasien = await _pasienRepository.getPasienByNIK(
        searchQuery: searchQuery,
      );
      emit(PasienLoaded(pasien: listPasien ?? []));
    } catch (e) {
      print(e);
      emit(PasienError(message: e.toString()));
    }
  }

  Future<void> getPasien() async {
    emit(PasienLoading());
    try {
      final listPasien = await _pasienRepository.getPasienLimited(limit: 10);
      emit(PasienLoaded(pasien: listPasien ?? []));
    } catch (e) {
      print(e);
      emit(PasienError(message: e.toString()));
    }
  }
}
