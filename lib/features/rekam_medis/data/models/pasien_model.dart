import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PasienModel extends Equatable {
  final String? id;
  final String? nama;
  final String? nik;
  final String? tempatLahir;
  final String? jenisKelamin;
  final DateTime? tanggalLahir;
  final String? golonganDarah;

  get umur {
    if (tanggalLahir != null) {
      final now = DateTime.now();
      final totalHari = now.difference(tanggalLahir!).inDays;
      if (totalHari / 365 > 1) {
        final tahun = (totalHari / 365).floor();
        final bulan = ((totalHari % 365) / 30).floor();
        final hari = ((totalHari % 365) % 30).floor();
        return '$tahun tahun${bulan < 0 ? ' $bulan bulan' : ''} $hari hari';
      }
      if (totalHari / 30 > 1) {
        final bulan = (totalHari / 30).floor();
        final hari = ((totalHari % 30)).floor();
        return '$bulan bulan $hari hari';
      }
      return '$totalHari hari';
    } else {
      return "0";
    }
  }

  const PasienModel({
    this.id,
    this.nama,
    this.nik,
    this.jenisKelamin,
    this.tanggalLahir,
    this.tempatLahir,
    this.golonganDarah,
  });

  @override
  List<Object?> get props => [
        id,
        nama,
        nik,
        jenisKelamin,
        tanggalLahir,
        tempatLahir,
        golonganDarah,
      ];

  factory PasienModel.fromMap(Map<String, dynamic> map, String docId) {
    return PasienModel(
      id: docId,
      nama: map['nama'],
      nik: map['nik'],
      jenisKelamin: map['jenis_kelamin'],
      tanggalLahir: ((map['tanggal_lahir'] != null)
          ? (map['tanggal_lahir'] as Timestamp).toDate()
          : null),
      tempatLahir: map['tempat_lahir'],
      golonganDarah: map['golongan_darah'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'nik': nik,
      'jenis_kelamin': jenisKelamin,
      'tanggal_lahir': tanggalLahir,
      'tempat_lahir': tempatLahir,
      'gol_darah': golonganDarah,
    };
  }
}
