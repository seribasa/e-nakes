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
        .where('medic_id', isEqualTo: uid)
        .get();
    for (var element in jadwalPasien.docs) {
      JadwalPasienModel dataJadwal = JadwalPasienModel.fromMap(
        element.data(),
        element.id,
      );
      final pasien = await _pasienRepository.getPasienByID(
        searchQuery: element.data()['patient_id'],
      );
      final orangtua = await _pasienRepository.getOrangtuaByID(
        searchQuery: element.data()['parent_id'],
      );
      dataJadwal = dataJadwal.copyWith(
        anak: pasien,
        orangtua: orangtua,
      );
      result.add(dataJadwal);
    }
    return result;
  }

  Future<JadwalPasienModel?> getJadwalActivityById(
      {required String? id}) async {
    final jadwalPasien = await _firestore.collection(collection).doc(id).get();
    JadwalPasienModel dataJadwal = JadwalPasienModel.fromMap(
      jadwalPasien.data() ?? {},
      jadwalPasien.id,
    );
    final pasien = await _pasienRepository.getPasienByID(
      searchQuery: jadwalPasien.data()?['patient_id'],
    );
    final orangtua = await _pasienRepository.getOrangtuaByID(
      searchQuery: jadwalPasien.data()?['parent_id'],
    );
    dataJadwal = dataJadwal.copyWith(
      anak: pasien,
      orangtua: orangtua,
    );

    return dataJadwal;
  }

  Future<List<JadwalPasienModel>?> getSpecificJadwalActivity(
      {required String? uid, required DateTime date}) async {
    List<JadwalPasienModel>? result;
    final jadwalPasien = await _firestore
        .collection(collection)
        .where('medic_id', isEqualTo: uid)
        .where(
          'appointment_date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(date),
          isLessThan: Timestamp.fromDate(
            date.add(const Duration(days: 1)),
          ),
        )
        .get();
    if (jadwalPasien.docs.isNotEmpty) {
      result = [];
      for (var element in jadwalPasien.docs) {
        JadwalPasienModel dataJadwal = JadwalPasienModel.fromMap(
          element.data(),
          element.id,
        );
        final pasien = await _pasienRepository.getPasienByID(
          searchQuery: element.data()['patient_id'],
        );
        final orangtua = await _pasienRepository.getOrangtuaByID(
          searchQuery: element.data()['parent_id'],
        );
        dataJadwal = dataJadwal.copyWith(
          anak: pasien,
          orangtua: orangtua,
        );
        result.add(dataJadwal);
      }
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
