import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/klinik/data/models/klinik.dart';
import 'package:equatable/equatable.dart';

/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class UserData extends Equatable {
  /// {@macro user}
  const UserData({
    required this.id,
    this.email,
    this.phone,
    this.fullName,
    this.photo,
    this.birthDate,
    this.birthPlace,
    this.kartuKeluarga,
    this.nik,
    this.profession,
    this.schedules,
    this.schedulesImunisasi,
    this.clinic,
  });

  /// The current user's email address.
  final String? email;

  /// The current user's phone address.
  final String? phone;

  /// The current user's id.
  final String? id;

  /// The current user's name (display name).
  final String? fullName;

  /// Url for the current user's photo.
  final String? photo;

  final String? nik;

  final String? kartuKeluarga;

  final String? profession;

  final DateTime? birthDate;

  final String? birthPlace;

  final Klinik? clinic;

  /// Map<Hari, List<jam>>
  final List<JadwalPraktek>? schedules;
  final List<JadwalPraktek>? schedulesImunisasi;

  /// Empty user which represents an unauthenticated user.
  static const empty = UserData(id: '');

  /// Convenience getter to determine whether the current user is empty.
  bool get isEmpty => this == UserData.empty;

  /// Convenience getter to determine whether the current user is not empty.
  bool get isNotEmpty => this != UserData.empty;

  factory UserData.fromMap(Map<String, dynamic>? map, String id) {
    return UserData(
      id: id,
      email: map?['email'],
      phone: map?['noTelpon'],
      fullName: map?['namaLengkap'],
      photo: map?['photoURL'],
      birthDate: ((map?['tanggalLahir'] != null)
          ? (map?['tanggalLahir'] as Timestamp).toDate()
          : null),
      birthPlace: map?['tempatLahir'],
      kartuKeluarga: map?['kartuKeluarga'],
      nik: map?['nik'],
      profession: map?['profesi'],
      schedules: (map?['jadwal'] as List?)
          ?.map((e) => JadwalPraktek.fromMap(e))
          .toList(),
      schedulesImunisasi: (map?['jadwalImunisasi'] as List?)
          ?.map((e) => JadwalPraktek.fromMap(e))
          .toList(),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'noTelpon': phone,
      'namaLengkap': fullName,
      'photo': photo,
      'tanggalLahir': birthDate,
      'tempatLahir': birthPlace,
      'kartuKeluarga': kartuKeluarga,
      'nik': nik,
      'profesi': profession,
      'jadwal': schedules,
    };
  }

  UserData copyWith({
    String? id,
    String? email,
    String? phone,
    String? fullName,
    String? photo,
    DateTime? birthDate,
    String? birthPlace,
    String? kartuKeluarga,
    String? nik,
    String? profession,
    List<JadwalPraktek>? schedules,
    List<JadwalPraktek>? schedulesImunisasi,
    Klinik? clinic,
  }) {
    return UserData(
      id: id ?? this.id,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      photo: photo ?? this.photo,
      birthDate: birthDate ?? this.birthDate,
      birthPlace: birthPlace ?? this.birthPlace,
      kartuKeluarga: kartuKeluarga ?? this.kartuKeluarga,
      nik: nik ?? this.nik,
      profession: profession ?? this.profession,
      schedules: schedules ?? this.schedules,
      schedulesImunisasi: schedulesImunisasi ?? this.schedulesImunisasi,
      clinic: clinic ?? this.clinic,
    );
  }

  @override
  List<Object?> get props => [
        email,
        phone,
        id,
        fullName,
        photo,
        birthDate,
        birthPlace,
        kartuKeluarga,
        nik,
        profession,
        schedules,
        schedulesImunisasi,
        clinic,
      ];
}

class JadwalPraktek extends Equatable {
  final String? hari;
  final String? jam;

  const JadwalPraktek({
    this.hari,
    this.jam,
  });

  factory JadwalPraktek.fromMap(Map data) {
    return JadwalPraktek(
      hari: data['hari'],
      jam: data['jam'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "hari": hari,
      "jam": jam,
    };
  }

  @override
  List<Object?> get props => [hari, jam];
}
