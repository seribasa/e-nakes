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
  _fetchDataKlinik(
      KlinikProfilePressed event, Emitter<KlinikState> emit) async {
    emit(KlinikLoading());
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _klinikRepository.getKlinik(id: 'npoSSEMlxMSbuQ9nFEJh');
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

  _fetchDataKeanggotaan(
      KlinikKeanggotaanPressed event, Emitter<KlinikState> emit) async {
    emit(KlinikLoading());
    try {
      DocumentSnapshot<Map<String, dynamic>> data =
          await _klinikRepository.getAnggotaKlinik(id: 'npoSSEMlxMSbuQ9nFEJh');
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
    }
  }
}
