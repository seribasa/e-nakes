import 'package:equatable/equatable.dart';

class OrangtuaModel extends Equatable {
  final String? id;
  final String? nama;
  final String? email;
  final String? noHp;

  const OrangtuaModel({
    this.id,
    this.nama,
    this.email,
    this.noHp,
  });

  @override
  List<Object?> get props => [id, nama, email, noHp];

  factory OrangtuaModel.fromMap(Map<String, dynamic>? map, String docId) {
    return OrangtuaModel(
      id: docId,
      nama: map?['momName'],
      email: map?['email'],
      noHp: map?['noHpIbu'],
    );
  }
}
