import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/core/models/orang_tua_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:equatable/equatable.dart';

class JadwalPasienModel extends Equatable {
  final String? id;
  final DateTime? tanggal;
  final String? idPasien;
  final PasienModel? pasien;
  final String? idOrangtua;
  final OrangtuaModel? orangtua;
  final String? idNakes;
  final String? notes;

  const JadwalPasienModel({
    this.id,
    this.tanggal,
    this.idPasien,
    this.pasien,
    this.idOrangtua,
    this.orangtua,
    this.idNakes,
    this.notes,
  });

  JadwalPasienModel copyWith({
    String? id,
    DateTime? tanggal,
    String? idPasien,
    PasienModel? pasien,
    String? idOrangtua,
    OrangtuaModel? orangtua,
    String? idNakes,
    String? notes,
  }) {
    return JadwalPasienModel(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      idPasien: idPasien ?? this.idPasien,
      pasien: pasien ?? this.pasien,
      idOrangtua: idOrangtua ?? this.idOrangtua,
      orangtua: orangtua ?? this.orangtua,
      idNakes: idNakes ?? this.idNakes,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props =>
      [id, tanggal, idPasien, idOrangtua, idNakes, notes, pasien, orangtua];

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
