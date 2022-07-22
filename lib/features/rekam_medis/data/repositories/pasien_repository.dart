import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';

class PasienRepository {
  final FirebaseFirestore _firestore;

  PasienRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<PasienModel>?> getPasienByNIK(
      {required String searchQuery}) async {
    List<PasienModel>? result = [];
    final getData = await _firestore
        .collection('children')
        .where('nik', isEqualTo: searchQuery)
        .get();
    for (var element in getData.docs) {
      result.add(PasienModel.fromMap(element.data(), element.id));
    }
    return result;
  }

  Future<List<PasienModel>?> getPasienLimited({int? limit}) async {
    List<PasienModel>? result = [];
    final getData =
        await _firestore.collection('children').limit(limit ?? 10).get();
    for (var element in getData.docs) {
      if (element.data()['nama'] != null) {
        result.add(PasienModel.fromMap(element.data(), element.id));
      } else {
        element.data().forEach((key, value) {
          result.add(PasienModel.fromMap(value, element.id));
        });
      }
    }
    return result;
  }
}
