import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_member_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tClinicMemberModel = ClinicMemberModel(
    healthWorkerName: 'Test Name',
    healthWorkerId: 'hw123',
    clinicId: 'c456',
    clinicName: 'Test Clinic'
  );

  final tClinicMemberMap = {
    'full_name': 'Test Name',
    'user_id': 'hw123',
    'clinic': {
      'id': 'c456',
      'name': 'Test Clinic'
    }
  };

  group('ClinicMemberModel', () {
    test('should create ClinicMemberModel from map', () {
      // act
      final result = ClinicMemberModel.fromSeribase(tClinicMemberMap);
      
      // assert
      expect(result.healthWorkerName, tClinicMemberModel.healthWorkerName);
      expect(result.healthWorkerId, tClinicMemberModel.healthWorkerId);
      expect(result.clinicId, tClinicMemberModel.clinicId);
      expect(result.clinicName, tClinicMemberModel.clinicName);
    });

    test('should convert ClinicMemberModel to map', () {
      // act
      final result = tClinicMemberModel.toSeribase();
      
      // assert
      expect(result, tClinicMemberMap);
    });

    test('should return empty map when all fields are null', () {
      // arrange
      final emptyModel = ClinicMemberModel();
      
      // act
      final result = emptyModel.toSeribase();
      
      // assert
      expect(result, {});
    });
  });
}