import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PemeriksaanModel extends Equatable {
  final int? beratBadan;
  final int? tinggiBadan;
  final int? lingkarKepala;
  final String? riwayatKeluhan;
  final String? diagnosa;
  final String? tindakan;
  final String? id;
  final String? idAnakPasien;
  final String? idPasien;
  final String? idDokter;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const PemeriksaanModel({
    this.beratBadan,
    this.tinggiBadan,
    this.lingkarKepala,
    this.riwayatKeluhan,
    this.diagnosa,
    this.tindakan,
    this.id,
    this.idAnakPasien,
    this.idPasien,
    this.idDokter,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
        beratBadan,
        tinggiBadan,
        lingkarKepala,
        riwayatKeluhan,
        diagnosa,
        tindakan,
        id,
        idAnakPasien,
        idPasien,
        idDokter,
        createdAt,
        updatedAt,
        deletedAt
      ];

  factory PemeriksaanModel.fromMap(Map<String, dynamic> map, String docId) {
    return PemeriksaanModel(
      beratBadan: map['berat_badan'],
      tinggiBadan: map['tinggi_badan'],
      lingkarKepala: map['lingkar_kepala'],
      riwayatKeluhan: map['riwayat_keluhan'],
      diagnosa: map['diagnosa'],
      tindakan: map['tindakan'],
      id: docId,
      idAnakPasien: map['id_anak_pasien'],
      idPasien: map['id_pasien'],
      idDokter: map['id_dokter'],
      createdAt: (map['created_at'] as Timestamp).toDate(),
      updatedAt: (map['updated_at'] as Timestamp).toDate(),
      deletedAt: (map['deleted_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'berat_badan': beratBadan,
      'tinggi_badan': tinggiBadan,
      'lingkar_kepala': lingkarKepala,
      'riwayat_keluhan': riwayatKeluhan,
      'diagnosa': diagnosa,
      'tindakan': tindakan,
      'id_pasien': idPasien,
      'id_anak_pasien': idAnakPasien,
      'id_dokter': idDokter,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}
