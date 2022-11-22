import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/core/models/orang_tua_model.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:equatable/equatable.dart';

class JadwalPasienModel extends Equatable {
  final String? id;
  final DateTime? tanggal;
  final PasienModel? anak;
  final OrangtuaModel? orangtua;
  final UserData? nakes;
  final String? tujuan;
  final String? desc;
  final String? notes;

  const JadwalPasienModel({
    this.id,
    this.tanggal,
    this.anak,
    this.orangtua,
    this.nakes,
    this.tujuan,
    this.desc,
    this.notes,
  });

  JadwalPasienModel copyWith({
    String? id,
    DateTime? tanggal,
    PasienModel? anak,
    OrangtuaModel? orangtua,
    UserData? nakes,
    String? tujuan,
    String? desc,
    String? notes,
  }) {
    return JadwalPasienModel(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      anak: anak ?? this.anak,
      orangtua: orangtua ?? this.orangtua,
      nakes: nakes ?? this.nakes,
      tujuan: tujuan ?? this.tujuan,
      desc: desc ?? this.desc,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props =>
      [id, tanggal, anak, orangtua, nakes, tujuan, desc, notes];
  factory JadwalPasienModel.fromMap(Map<String, dynamic> map, String docId) {
    return JadwalPasienModel(
      id: docId,
      tanggal: ((map['appointment_date'] != null)
          ? (map['appointment_date'] as Timestamp).toDate()
          : null),
      notes: map['notes'],
      desc: map['appointment_desc'],
      tujuan: map['purpose'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appointment_date': tanggal,
      'appointment_desc': desc,
      'medic_id': nakes?.id,
      'notes': notes,
      'parent_id': orangtua?.id,
      'patient_id': anak?.id,
      'purpose': tujuan,
    };
  }
}
