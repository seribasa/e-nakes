import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
    late CheckupModel checkupModel;

    setUp(() {
        checkupModel = CheckupModel(
            weight: 10,
            height: 10,
            headCircumference: 10,
            vaccineType: 'jenisVaksin',
            complaint: 'riwayatKeluhan',
            diagnosis: 'diagnosa',
            action: 'tindakan',
            id: 'id',
            parentId: 'idOrangTua',
            patientId: 'idPasien',
            healthWorkerId: 'idDokter',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            deletedAt: DateTime.now(),
        );
    });

    test('should be a subclass of Equatable', () {
        expect(checkupModel, isA<CheckupModel>());
    });

    group('fromSeribase', () {
        test('should return a valid model', () {
            final dateNow = DateTime.now();
            final Map<String, dynamic> map = {
                'id': 'id',
                'weight': 10,
                'height': 10,
                'head_circumference': 10,
                'vaccine_type': 'jenisVaksin',
                'complaint': 'riwayatKeluhan',
                'diagnosis': 'diagnosa',
                'action': 'tindakan',
                'parent_id': 'idOrangTua',
                'child_id': 'idPasien',
                'inspector_id': 'idDokter',
                'created_at': dateNow.toIso8601String(),
                'deleted_at': null,
            };
            final result = CheckupModel.fromSeribase(map);

            expect(result.updatedAt, isNull);
            expect(result.deletedAt, isNull);
        });

        test('should return a valid model with deletedAt and updatedAt', () {
            final dateNow = DateTime.now();
            final Map<String, dynamic> map = {
                'id': 'id',
                'weight': 10,
                'height': 10,
                'head_circumference': 10,
                'vaccine_type': 'jenisVaksin',
                'complaint': 'riwayatKeluhan',
                'diagnosis': 'diagnosa',
                'action': 'tindakan',
                'parent_id': 'idOrangTua',
                'child_id': 'idPasien',
                'inspector_id': 'idDokter',
                'created_at': dateNow.toIso8601String(),
                'deleted_at': dateNow.add(Duration(days: 1)).toIso8601String(),
                'updated_at': dateNow.add(Duration(days: 2)).toIso8601String(),
            };
            final result = CheckupModel.fromSeribase(map);
            final expected = checkupModel.copyWith(
                createdAt: dateNow,
                updatedAt: dateNow.add(Duration(days: 2)),
                deletedAt: dateNow.add(Duration(days: 1)),
            );
            expect(result, expected);
        });
    });

    group('toMap', () {
        test('should return a JSON map containing the proper data', () {
            final result = checkupModel.toSeribase();
            final expected = {
                'weight': 10,
                'height': 10,
                'head_circumference': 10,
                'vaccine_type': 'jenisVaksin',
                'complaint': 'riwayatKeluhan',
                'diagnosis': 'diagnosa',
                'action': 'tindakan',
                'child_id': 'idPasien',
                'parent_id': 'idOrangTua',
                'inspector_id': 'idDokter',
                'created_at': checkupModel.createdAt?.toIso8601String(),
                'updated_at': checkupModel.updatedAt?.toIso8601String(),
                'deleted_at': checkupModel.deletedAt?.toIso8601String(),
            };
            expect(result, expected);
        });
    });

    group('copyWith', () {
        test('should return a new instance of CheckupModel', () {
            final result = checkupModel.copyWith();
            expect(result, isA<CheckupModel>());
        });

        test('should return a new instance of CheckupModel with updated data', () {
            final result = checkupModel.copyWith(
                weight: 20,
                height: 20,
                headCircumference: 20,
                vaccineType: 'jenisVaksin2',
                complaint: 'riwayatKeluhan2',
                diagnosis: 'diagnosa2',
                action: 'tindakan2',
                id: 'id2',
                parentId: 'idOrangTua2',
                patientId: 'idPasien2',
                healthWorkerId: 'idDokter2',
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
                deletedAt: DateTime.now(),
            );
            final expected = CheckupModel(
                weight: 20,
                height: 20,
                headCircumference: 20,
                vaccineType: 'jenisVaksin2',
                complaint: 'riwayatKeluhan2',
                diagnosis: 'diagnosa2',
                action: 'tindakan2',
                id: 'id2',
                parentId: 'idOrangTua2',
                patientId: 'idPasien2',
                healthWorkerId: 'idDokter2',
                createdAt: result.createdAt,
                updatedAt: result.updatedAt,
                deletedAt: result.deletedAt,
            );
            expect(result, expected);
        });
    });
}