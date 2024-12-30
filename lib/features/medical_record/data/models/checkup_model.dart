import 'package:equatable/equatable.dart';

class CheckupModel extends Equatable {
  final int? weight;
  final int? height;
  final int? headCircumference;
  final String? vaccineType;
  final String? complaint;
  final String? diagnosis;
  final String? action;
  final String? id;
  final String? parentId;
  final String? patientId;
  final String? healthWorkerId;
  final String? month;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  const CheckupModel({
    this.weight,
    this.height,
    this.headCircumference,
    this.vaccineType,
    this.complaint,
    this.diagnosis,
    this.action,
    this.id,
    this.parentId,
    this.patientId,
    this.healthWorkerId,
    this.month,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  @override
  List<Object?> get props => [
        weight,
        height,
        headCircumference,
        vaccineType,
        complaint,
        diagnosis,
        action,
        id,
        parentId,
        patientId,
        healthWorkerId,
        month,
        createdAt,
        updatedAt,
        deletedAt
      ];


  factory CheckupModel.fromSeribase(Map<String, dynamic> map) {
    return CheckupModel(
      weight: map['weight'],
      height: map['height'],
      headCircumference: map['head_circumference'],
      vaccineType: map['vaccine_type'],
      complaint: map['complaint'],
      diagnosis: map['diagnosis'],
      action: map['action'],
      id: map['id'],
      parentId: map['parent_id'],
      patientId: map['child_id'],
      healthWorkerId: map['inspector_id'],
      createdAt: () {
        try {
          return DateTime.parse(map['created_at']);
        } catch (e) {
          return null;
        }
      }(),
      updatedAt: () {
        try {
          return DateTime.parse(map['updated_at']);
        } catch (e) {
          return null;
        }
      }(),
      deletedAt: () {
        try {
          return DateTime.parse(map['deleted_at']);
        } catch (e) {
          return null;
        }
      }(),
    );
  }

  Map<String, dynamic> toSeribase() {
    return {
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (headCircumference != null) 'head_circumference': headCircumference,
      if (vaccineType != null) 'vaccine_type': vaccineType,
      if (complaint != null) 'complaint': complaint,
      if (diagnosis != null) 'diagnosis': diagnosis,
      if (action != null) 'action': action,
      if (patientId != null) 'child_id': patientId,
      if (parentId != null) 'parent_id': parentId,
      if (healthWorkerId != null) 'inspector_id': healthWorkerId,
      if (createdAt != null) 'created_at': createdAt?.toIso8601String(),
      if (updatedAt != null) 'updated_at': updatedAt?.toIso8601String(),
      if (deletedAt != null) 'deleted_at': deletedAt?.toIso8601String(),
    };
  }


  CheckupModel copyWith({
    int? weight,
    int? height,
    int? headCircumference,
    String? vaccineType,
    String? complaint,
    String? diagnosis,
    String? action,
    String? id,
    String? parentId,
    String? patientId,
    String? healthWorkerId,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
  }) {
    return CheckupModel(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      headCircumference: headCircumference ?? this.headCircumference,
      vaccineType: vaccineType ?? this.vaccineType,
      complaint: complaint ?? this.complaint,
      diagnosis: diagnosis ?? this.diagnosis,
      action: action ?? this.action,
      id: id ?? this.id,
      parentId: parentId ?? this.parentId,
      patientId: patientId ?? this.patientId,
      healthWorkerId: healthWorkerId ?? this.healthWorkerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
    );
  }
}
