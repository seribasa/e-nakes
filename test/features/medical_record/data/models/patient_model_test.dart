import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PatientModel', () {
    test('should create PatientModel instance', () {
      final patient = PatientModel(
        id: '1',
        parentId: '2', 
        nama: 'Test Patient',
        nik: '1234567890',
        tempatLahir: 'Test City',
        tanggalLahir: DateTime(1990, 1, 1),
        jenisKelamin: 'L',
        golDarah: 'O',
        photoURL: 'http://test.com/photo.jpg'
      );

      expect(patient.id, '1');
      expect(patient.parentId, '2');
      expect(patient.nama, 'Test Patient');
      expect(patient.nik, '1234567890');
      expect(patient.tempatLahir, 'Test City');
      expect(patient.tanggalLahir, DateTime(1990, 1, 1));
      expect(patient.jenisKelamin, 'L');
      expect(patient.golDarah, 'O');
      expect(patient.photoURL, 'http://test.com/photo.jpg');
    });

    test('should create PatientModel from Seribase map', () {
      final map = {
        'id': '1',
        'parent_id': '2',
        'name': 'Test Patient',
        'nik': '1234567890',
        'place_of_birth': 'Test City',
        'date_of_birth': '1990-01-01T00:00:00.000',
        'gender': 'L',
        'blood_type': 'O',
        'avatar_url': 'http://test.com/photo.jpg'
      };

      final patient = PatientModel.fromSeribase(map);

      expect(patient.id, '1');
      expect(patient.parentId, '2');
      expect(patient.nama, 'Test Patient');
      expect(patient.nik, '1234567890');
      expect(patient.tempatLahir, 'Test City');
      expect(patient.tanggalLahir, DateTime(1990, 1, 1));
      expect(patient.jenisKelamin, 'L');
      expect(patient.golDarah, 'O');
      expect(patient.photoURL, 'http://test.com/photo.jpg');
    });

    test('should convert PatientModel to Seribase map', () {
      final patient = PatientModel(
        parentId: '2',
        nama: 'Test Patient',
        nik: '1234567890',
        tempatLahir: 'Test City',
        tanggalLahir: DateTime(1990, 1, 1),
        jenisKelamin: 'L',
        golDarah: 'O',
        photoURL: 'http://test.com/photo.jpg'
      );

      final map = patient.toSeribaseMap();

      expect(map['parent_id'], '2');
      expect(map['name'], 'Test Patient');
      expect(map['nik'], '1234567890');
      expect(map['place_of_birth'], 'Test City');
      expect(map['date_of_birth'], '1990-01-01T00:00:00.000');
      expect(map['gender'], 'L');
      expect(map['blood_type'], 'O');
      expect(map['avatar_url'], 'http://test.com/photo.jpg');
    });

    test('should calculate age correctly', () {
      final patient = PatientModel(
        tanggalLahir: DateTime.now().subtract(const Duration(days: 730)) // 2 years ago
      );

      expect(patient.umur, startsWith('2 tahun'));
    });

    test('should return default message when birthdate is null', () {
      final patient = PatientModel();
      expect(patient.umur, 'Umur belum diisi');
    });
  });
}