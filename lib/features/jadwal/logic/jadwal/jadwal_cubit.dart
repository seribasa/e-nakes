import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/repositories/jadwal_repository.dart';
import 'package:equatable/equatable.dart';

part 'jadwal_state.dart';

class JadwalCubit extends Cubit<JadwalState> {
  final JadwalRepository _jadwalRepository;
  final UserData? userData;
  JadwalCubit({
    JadwalRepository? jadwalRepository,
    required this.userData,
  })  : _jadwalRepository = jadwalRepository ?? JadwalRepository(),
        super(JadwalInitial());

  getAllJadwal() async {
    emit(JadwalLoading());
    try {
      final listJadwal =
          await _jadwalRepository.getJadwalActivity(uid: userData?.id);
      listJadwal?.sort((a, b) => a.tanggal!.compareTo(b.tanggal!));
      emit(JadwalLoaded(jadwalPasienModel: listJadwal ?? []));
    } catch (e) {
      emit(JadwalError(message: e.toString()));
    }
  }
}
