import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/repositories/pasien_repository.dart';

class JadwalRepository {
  final FirebaseFirestore _firestore;

  JadwalRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final String collection = 'appointments';
  final String collectionPasien = 'children';
  final _pasienRepository = PasienRepository();

  Future<List<JadwalPasienModel>?> getJadwalActivity(
      {required String? uid}) async {
    List<JadwalPasienModel>? result = [];
    final jadwalPasien = await _firestore
        .collection(collection)
        .where('id_nakes', isEqualTo: uid)
        .get();
    for (var element in jadwalPasien.docs) {
      JadwalPasienModel dataJadwal = JadwalPasienModel.fromMap(
        element.data(),
        element.id,
      );
      final pasien = await _pasienRepository.getPasienByID(
        searchQuery: element.data()['id_pasien'],
      );
      final orangtua = await _pasienRepository.getOrangtuaByID(
        searchQuery: element.data()['id_orangtua'],
      );
      dataJadwal = dataJadwal.copyWith(
        pasien: pasien,
        orangtua: orangtua,
      );
      result.add(dataJadwal);
    }
    return result;
  }

  Future<List<JadwalPasienModel>?> getSpecificJadwalActivity(
      {required String? uid, DateTime? date}) async {
    List<JadwalPasienModel>? result;
    final jadwalPasien = await _firestore
        .collection(collection)
        .where('uid', isEqualTo: uid)
        .where('date', isEqualTo: date)
        .get();
    for (var element in jadwalPasien.docs) {
      result?.add(JadwalPasienModel.fromMap(element.data(), element.id));
    }
    return result;
  }

  Future<void> addJadwalActivity({
    required JadwalPasienModel jadwalPasienModel,
  }) async {
    final DocumentReference reference = _firestore.collection(collection).doc();
    await reference.set(jadwalPasienModel.toMap());
  }

  Future<void> updateJadwalActivity(
      {required JadwalPasienModel jadwalPasienModel,
      required String? docId}) async {
    final DocumentReference reference =
        _firestore.collection(collection).doc(docId);
    await reference.update(jadwalPasienModel.toMap());
  }

  Future<void> deleteJadwalActivity({required String docId}) async {
    final DocumentReference reference =
        _firestore.collection(collection).doc(docId);
    await reference.delete();
  }
}
