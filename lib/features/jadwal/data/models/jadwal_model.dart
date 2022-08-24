import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class JadwalPasienModel extends Equatable {
  final String? id;
  final DateTime? tanggal;
  final String? idPasien;
  final String? idOrangtua;
  final String? idNakes;
  final String? notes;

  const JadwalPasienModel({
    this.id,
    this.tanggal,
    this.idPasien,
    this.idOrangtua,
    this.idNakes,
    this.notes,
  });

  @override
  List<Object?> get props =>
      [id, tanggal, idPasien, idOrangtua, idNakes, notes];

  factory JadwalPasienModel.fromMap(Map<String, dynamic> map, String docId) {
    return JadwalPasienModel(
      id: docId,
      tanggal: ((map['tanggal'] != null)
          ? (map['tanggal'] as Timestamp).toDate()
          : null),
      idPasien: map['id_pasien'],
      idOrangtua: map['id_orangtua'],
      idNakes: map['id_nakes'],
      notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tanggal': tanggal,
      'id_pasien': idPasien,
      'id_orangtua': idOrangtua,
      'id_nakes': idNakes,
      'notes': notes,
    };
  }
}
