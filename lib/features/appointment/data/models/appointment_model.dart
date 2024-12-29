import 'package:eimunisasi_nakes/core/models/parent_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:equatable/equatable.dart';

class PatientAppointmentModel extends Equatable {
  final String? id;
  final DateTime? date;
  final PatientModel? child;
  final ParentModel? parent;
  final String? purpose;
  final String? note;
  final String? startTime;
  final String? endTime;

  String get time => (){
    if(startTime != null && endTime != null){
      final startTime = this.startTime?.split(":").getRange(0, 2).join(":");
      final endTime = this.endTime?.split(":").getRange(0, 2).join(":");
      return "$startTime - $endTime";
    }
    return '';
  }();


  const PatientAppointmentModel({
    this.id,
    this.date,
    this.child,
    this.parent,
    this.note,
    this.purpose,
    this.startTime,
    this.endTime,
  });

  static const String tableName = 'appointments';

  PatientAppointmentModel copyWith({
    String? id,
    DateTime? date,
    PatientModel? child,
    ParentModel? parent,
    String? note,
    String? purpose,
    String? startTime,
    String? endTime,
  }) {
    return PatientAppointmentModel(
      id: id ?? this.id,
      date: date ?? this.date,
      child: child ?? this.child,
      parent: parent ?? this.parent,
      note: note ?? this.note,
      purpose: purpose ?? this.purpose,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [
    id,
    date,
    child,
    parent,
    note,
    purpose,
    startTime,
    endTime,
  ];

  factory PatientAppointmentModel.fromSeribase(
      Map<String, dynamic> map,
      ) {
    return PatientAppointmentModel(
      id: map['id'],
      date: () {
        try {
          if (map['date'] == null) return null;
          return DateTime.parse(map['date']);
        } catch (e) {
          return null;
        }
      }(),
      child: map['child'] != null
          ? PatientModel.fromSeribase(map['child'])
          : null,
      parent: map['parent'] != null
          ? ParentModel.fromSeribase(map['parent'])
          : null,
      note: map['note'],
      purpose: map['purpose'],
      startTime: map['start_time'],
      endTime: map['end_time'],
    );
  }

  Map<String, dynamic> toSeribase() {
    return {
      if (id != null) 'id': id,
      if (parent != null) 'parent_id': parent?.id,
      if (child != null) 'child_id': child?.id,
      if (date != null) 'date': date?.toIso8601String(),
      if (note != null) 'note': note,
      if (purpose != null) 'purpose': purpose,
      if (startTime != null) 'start_time': startTime,
      if (endTime != null) 'end_time': endTime,
    };
  }
}