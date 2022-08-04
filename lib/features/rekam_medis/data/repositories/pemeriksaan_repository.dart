import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';

class PemeriksaanRepository {
  final FirebaseFirestore _firestore;

  PemeriksaanRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<PemeriksaanModel>?> getPemeriksaan({required String? uid}) async {
    List<PemeriksaanModel>? result = [];
    final getData = await _firestore
        .collection('checkups')
        .where('id_pasien', isEqualTo: uid)
        .get();
    for (var element in getData.docs) {
      result.add(PemeriksaanModel.fromMap(element.data(), element.id));
    }
    return result;
  }

  Future<List<PemeriksaanModel>?> getSpecificPemeriksaanByDate(
      {required String? uid, required DateTime? date}) async {
    List<PemeriksaanModel>? result;
    final getData = await _firestore
        .collection('checkups')
        .where('id_pasien', isEqualTo: uid)
        .where('date', isGreaterThanOrEqualTo: date)
        .get();
    for (var element in getData.docs) {
      result?.add(PemeriksaanModel.fromMap(element.data(), element.id));
    }
    return result;
  }

  Future<void> setPemeriksaan({
    required PemeriksaanModel pemeriksaanModel,
  }) async {
    final DocumentReference reference = _firestore.collection('checkups').doc();
    await reference.set(pemeriksaanModel.toMap());
  }

  Future<void> updatePemeriksaan(
      {required PemeriksaanModel pemeriksaanModel,
      required String? docId}) async {
    final DocumentReference reference =
        _firestore.collection('checkups').doc(docId);
    await reference.update(pemeriksaanModel.toMap());
  }

  Future<void> deletePemeriksaan({required String docId}) async {
    final DocumentReference reference =
        _firestore.collection('checkups').doc(docId);
    await reference.delete();
  }
}
