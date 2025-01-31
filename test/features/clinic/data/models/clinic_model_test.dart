import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClinicModel', () {
    test('should create ClinicModel instance', () {
      final clinic = ClinicModel(
        id: '1',
        name: 'Test Clinic',
        address: 'Test Address',
        motto: 'Test Motto', 
        phoneNumber: '1234567890',
        photos: ['photo1.jpg', 'photo2.jpg'],
        schedules: []
      );

      expect(clinic.id, '1');
      expect(clinic.name, 'Test Clinic');
      expect(clinic.address, 'Test Address');
      expect(clinic.motto, 'Test Motto');
      expect(clinic.phoneNumber, '1234567890');
      expect(clinic.photos, ['photo1.jpg', 'photo2.jpg']);
      expect(clinic.schedules, []);
    });

    test('fromSeribase should return valid ClinicModel', () {
      final Map<String, dynamic> json = {
        'id': '1',
        'name': 'Test Clinic',
        'address': 'Test Address',
        'motto': 'Test Motto',
        'phone_number': '1234567890',
        'photos': ['photo1.jpg', 'photo2.jpg'],
        'schedules': []
      };

      final result = ClinicModel.fromSeribase(json);

      expect(result.id, '1');
      expect(result.name, 'Test Clinic');
      expect(result.address, 'Test Address');
      expect(result.motto, 'Test Motto');
      expect(result.phoneNumber, '1234567890');
      expect(result.photos, ['photo1.jpg', 'photo2.jpg']);
      expect(result.schedules, []);
    });

    test('toSeribase should return valid json', () {
      final clinic = ClinicModel(
        id: '1',
        name: 'Test Clinic',
        address: 'Test Address',
        motto: 'Test Motto',
        phoneNumber: '1234567890',
        photos: ['photo1.jpg', 'photo2.jpg']
      );

      final result = clinic.toSeribase();

      expect(result, {
        'id': '1',
        'name': 'Test Clinic',
        'address': 'Test Address',
        'motto': 'Test Motto',
        'phone_number': '1234567890',
        'photos': ['photo1.jpg', 'photo2.jpg']
      });
    });
  });
}
