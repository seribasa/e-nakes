import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class JadwalPasienModel extends Equatable {
  final String? id;
  final DateTime? tanggal;
  final int? idPasien;
  final String? idOrangtua;
  final String? idNakes;

  const JadwalPasienModel({
    this.id,
    this.tanggal,
    this.idPasien,
    this.idOrangtua,
    this.idNakes,
  });

  @override
  List<Object?> get props => [id, tanggal, idPasien, idOrangtua];

  factory JadwalPasienModel.fromMap(Map<String, dynamic> map, String docId) {
    return JadwalPasienModel(
      id: docId,
      tanggal: ((map['tanggal'] != null)
          ? (map['tanggal'] as Timestamp).toDate()
          : null),
      idPasien: map['id_pasien'],
      idOrangtua: map['id_orangtua'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'id_pasien': idPasien,
      'id_orangtua': idOrangtua,
      'id_nakes': idNakes,
    };
  }
}
