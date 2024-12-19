import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/repositories/pemeriksaan_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/pemeriksaan_model.dart';

part 'pemeriksaan_state.dart';

class PemeriksaanCubit extends Cubit<PemeriksaanState> {
  final PemeriksaanRepository _pemeriksaanRepository;
  final ProfileModel? userData;
  PemeriksaanCubit({
    PemeriksaanRepository? pemeriksaanRepository,
    required this.userData,
  })  : _pemeriksaanRepository =
            pemeriksaanRepository ?? PemeriksaanRepository(),
        super(PemeriksaanInitial());

  Future<void> getPemeriksaanByIdPasien(String? idPasien) async {
    emit(PemeriksaanLoading());
    try {
      final pemeriksaan =
          await _pemeriksaanRepository.getPemeriksaan(uid: idPasien);

      pemeriksaan?.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
      emit(PemeriksaanLoaded(pemeriksaan: pemeriksaan));
    } catch (e) {
      emit(PemeriksaanError(message: e.toString()));
    }
  }
}
