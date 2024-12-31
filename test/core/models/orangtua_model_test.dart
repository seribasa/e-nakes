import 'package:flutter_test/flutter_test.dart';
import 'package:eimunisasi_nakes/core/models/orang_tua_model.dart';

void main() {
  group('OrangtuaModel', () {
    final map = {
      'id': '1',
      'name': 'John Doe',
      'email': 'john.doe@example.com',
      'phone_number': '1234567890',
    };

    final docMap = {
      'momName': 'Jane Doe',
      'email': 'jane.doe@example.com',
      'noHpIbu': '0987654321',
    };

    final orangtua = OrangtuaModel(
      id: '1',
      nama: 'John Doe',
      email: 'john.doe@example.com',
      noHp: '1234567890',
    );

    test('fromSeribase creates instance from map', () {
      final result = OrangtuaModel.fromSeribase(map);
      expect(result.id, '1');
      expect(result.nama, 'John Doe');
      expect(result.email, 'john.doe@example.com');
      expect(result.noHp, '1234567890');
    });

    test('fromMap creates instance from map', () {
      final result = OrangtuaModel.fromMap(docMap, '2');
      expect(result.id, '2');
      expect(result.nama, 'Jane Doe');
      expect(result.email, 'jane.doe@example.com');
      expect(result.noHp, '0987654321');
    });

    test('props returns correct values', () {
      expect(orangtua.props,
          ['1', 'John Doe', 'john.doe@example.com', '1234567890']);
    });
  });
}
