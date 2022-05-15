import 'package:cloud_firestore/cloud_firestore.dart';

class KlinikRepository {
  final FirebaseFirestore _firestore;
  KlinikRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<DocumentSnapshot<Map<String, dynamic>>> getKlinik(
      {required String? id}) async {
    return _firestore.collection('klinik').doc(id).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getAnggotaKlinik(
      {required String? id}) async {
    return _firestore.collection('klinik').doc(id).get();
  }
}
