import 'package:eimunisasi_nakes/features/klinik/data/models/klinik.dart';
import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  const ProfileModel({
    this.id,
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
  final String? id, email, phone,fullName, photo, birthPlace, kartuKeluarga, nik, profession;
  final DateTime? birthDate;
  final ClinicModel? clinic;
  final List<Schedule>? schedules, schedulesImunisasi;

  static const String table = 'profiles';

  static const empty = ProfileModel();

  bool get isEmpty => this == ProfileModel.empty;

  bool get isNotEmpty => this != ProfileModel.empty;

  factory ProfileModel.fromSeribase(Map<String, dynamic>? map) {
    return ProfileModel(
      id: map?['user_id'],
      email: map?['email'],
      phone: map?['phone_number'],
      fullName: map?['full_name'],
      photo: map?['avatar_url'],
      birthDate: map?['date_of_birth'] != null
          ? (DateTime.parse(map?['date_of_birth']))
          : null,
      birthPlace: map?['place_of_birth'],
      kartuKeluarga: map?['no_kartu_keluarga'],
      nik: map?['no_induk_kependudukan'],
      profession: map?['profession'],
      schedules: (map?['schedules'] as List? ?? [])
          .map((e) => Schedule.fromSeribase(e))
          .toList(),
      schedulesImunisasi: () {
        try {
          return (map?['practice_schedules'] as List? ?? [])
              .map((e) => Schedule.fromSeribase(e))
              .toList();
        } catch (e) {
          return <Schedule>[];
        }
      }(),
      clinic: () {
        try {
          return ClinicModel.fromSeribase(map?['clinic']);
        } catch (e) {
          return null;
        }
      }(),
    );
  }

  Map<String, dynamic> toSeribaseMap() {
    return {
      if (email != null) 'email': email,
      if (phone != null) 'phone_number': phone,
      if (fullName != null) 'full_name': fullName,
      if (photo != null) 'avatar_url': photo,
      if (birthDate != null) 'date_of_birth': birthDate?.toIso8601String(),
      if (birthPlace != null) 'place_of_birth': birthPlace,
      if (kartuKeluarga != null) 'no_kartu_keluarga': kartuKeluarga,
      if (nik != null) 'no_induk_kependudukan': nik,
      if (profession != null) 'profession': profession,
    };
  }

  ProfileModel copyWith({
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
    List<Schedule>? schedules,
    List<Schedule>? schedulesImunisasi,
    ClinicModel? clinic,
  }) {
    return ProfileModel(
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

class Schedule extends Equatable {
  final Day? day;
  final String? startTime;
  final String? endTime;

  const Schedule({
    this.day,
    this.startTime,
    this.endTime,
  });

  String get time => () {
        if (startTime != null && endTime != null) {
          final startTime = this.startTime?.split(":").getRange(0, 2).join(":");
          final endTime = this.endTime?.split(":").getRange(0, 2).join(":");
          return "$startTime - $endTime";
        }
        return "";
      }();

  factory Schedule.fromSeribase(Map<String, dynamic> data) {
    return Schedule(
      day: Day.fromSeribase(data['day']),
      startTime: data['start_time'],
      endTime: data['end_time'],
    );
  }

  Map<String, dynamic> toSeribase() {
    return {
      "day_id": day?.id,
      "start_time": startTime,
      "end_time": endTime,
    };
  }

  @override
  List<Object?> get props => [day, startTime, endTime];
}

class Day extends Equatable {
  final int? id;
  final String? name;

  const Day({
    this.id,
    this.name,
  });

  factory Day.fromSeribase(Map<String, dynamic> data) {
    return Day(
      id: data['id'],
      name: data['name'],
    );
  }

  Map<String, dynamic> toSeribase() {
    return {
      "id": id,
      "name": name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
