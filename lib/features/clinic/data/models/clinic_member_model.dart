import 'package:equatable/equatable.dart';

class ClinicMemberModel extends Equatable {
  final String? healthWorkerName,
      healthWorkerId,
      healthWorkerProfession,
      clinicId,
      clinicName;
  const ClinicMemberModel({
    this.healthWorkerName,
    this.healthWorkerId,
    this.healthWorkerProfession,
    this.clinicId,
    this.clinicName,
  });

  factory ClinicMemberModel.fromSeribase(Map<String, dynamic> data) {
    return ClinicMemberModel(
      healthWorkerName: data['full_name'],
      healthWorkerId: data['user_id'],
      healthWorkerProfession: data['profession'],
      clinicId: data['clinic']?['id'],
      clinicName: data['clinic']?['name'],
    );
  }

  Map<String, dynamic> toSeribase() {
    return {
      if (healthWorkerName != null) "full_name": healthWorkerName,
      if (healthWorkerId != null) "user_id": healthWorkerId,
      if (healthWorkerProfession != null) "profession": healthWorkerProfession,
      if (clinicId != null || clinicName != null)
        "clinic": {
          if (clinicId != null) "id": clinicId,
          if (clinicName != null) "name": clinicName,
        },
    };
  }

  @override
  List<Object?> get props => [
        healthWorkerName,
        healthWorkerId,
        healthWorkerProfession,
        clinicId,
        clinicName,
      ];
}
