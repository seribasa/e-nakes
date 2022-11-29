import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/klinik/data/models/anggota_klinik.dart';
import 'package:eimunisasi_nakes/features/klinik/data/models/klinik.dart';
import 'package:eimunisasi_nakes/features/klinik/data/repositories/klinik_repository.dart';
import 'package:equatable/equatable.dart';

part 'klinik_event.dart';
part 'klinik_state.dart';

class KlinikBloc extends Bloc<KlinikEvent, KlinikState> {
  final KlinikRepository _klinikRepository = KlinikRepository();
  KlinikBloc() : super(KlinikInitial()) {
    on<KlinikProfilePressed>(_fetchDataKlinik);
    on<KlinikKeanggotaanPressed>(_fetchDataKeanggotaan);
  }
  Future<void> _fetchDataKlinik(
      KlinikProfilePressed event, Emitter<KlinikState> emit) async {
    emit(KlinikLoading());
    try {
      // 31VERUiwjrZyB6NfiGPK
      DocumentSnapshot<Map<String, dynamic>> data =
          await _klinikRepository.getKlinik(id: event.clinicId);
      if (data.exists) {
        Klinik dataKlinik = Klinik.fromJson(data.data()!);
        emit(KlinikFetchData(klinik: dataKlinik));
      } else {
        emit(const KlinikFailure(error: 'Data klinik tidak ditemukan'));
      }
    } on FirebaseException catch (e) {
      emit(KlinikFailure(error: e.message));
    }
  }

  Future<void> _fetchDataKeanggotaan(
      KlinikKeanggotaanPressed event, Emitter<KlinikState> emit) async {
    emit(KlinikLoading());
    // 31VERUiwjrZyB6NfiGPK
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _klinikRepository.getAnggotaKlinik(id: event.clinicId);
      if (data.exists) {
        List<AnggotaKlinik> dataKlinik = data
            .get('listMember')
            .map<AnggotaKlinik>((e) => AnggotaKlinik(uid: e))
            .toList();
        emit(KlinikFetchDataAnggota(data: dataKlinik));
      } else {
        emit(const KlinikFailure(error: 'Data Anggota tidak ditemukan'));
      }
    } on FirebaseException catch (e) {
      emit(KlinikFailure(error: e.message));
    } catch (e) {
      emit(KlinikFailure(error: e.toString()));
    }
  }
}
