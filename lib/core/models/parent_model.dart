import 'package:equatable/equatable.dart';

class ParentModel extends Equatable {
  final String? id;
  final String? nama;
  final String? email;
  final String? noHp;

  const ParentModel({
    this.id,
    this.nama,
    this.email,
    this.noHp,
  });

  @override
  List<Object?> get props => [id, nama, email, noHp];

  factory ParentModel.fromMap(Map<String, dynamic>? map, String docId) {
    return ParentModel(
      id: docId,
      nama: map?['momName'],
      email: map?['email'],
      noHp: map?['noHpIbu'],
    );
  }

  factory ParentModel.fromSeribase(Map<String, dynamic> map) {
    return ParentModel(
      id: map['id'],
      nama: map['name'],
      email: map['email'],
      noHp: map['phone_number'],
    );
  }
}
