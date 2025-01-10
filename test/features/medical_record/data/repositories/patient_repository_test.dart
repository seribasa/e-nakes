import 'package:eimunisasi_nakes/core/models/parent_model.dart';
import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/patient_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockFunctionsClient extends Mock implements FunctionsClient {}

void main() {
  late PatientRepository repository;
  late MockSupabaseClient mockSupabaseClient;
  late MockFunctionsClient mockFunctionsClient;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    reset(mockSupabaseClient);

    mockFunctionsClient = MockFunctionsClient();
    repository = PatientRepository(mockSupabaseClient);
    when(() => mockSupabaseClient.functions).thenReturn(mockFunctionsClient);
  });

  group('PasienRepository', () {
    test('getParentByID returns ParentModel', () async {
      when(() => mockFunctionsClient.invoke(
            any(),
          )).thenAnswer(
        (_) async => FunctionResponse(
          data: {
            'data': {'id': '1', 'name': 'Test Parent'}
          },
          status: 200,
        ),
      );

      final result = await repository.getParentByID(id: '1');

      expect(result, isA<ParentModel>());
      verify(() => mockFunctionsClient.invoke('parents/1')).called(1);
    });

    test('getPatient returns PatientModel', () async {
      when(() => mockFunctionsClient.invoke(any())).thenAnswer(
        (_) async => FunctionResponse(
          data: {
            'data': {'id': '1', 'name': 'Test Patient'}
          },
          status: 200,
        ),
      );

      final result = await repository.getPatient(id: '1');

      expect(result, isA<PatientModel>());
      verify(() => mockFunctionsClient.invoke('patients/1')).called(1);
    });

    test('getPatients returns BasePagination<PatientModel>', () async {
      final patientModel = PatientModel(
        id: '1',
        nama: 'name',
      );

      when(() => mockFunctionsClient.invoke(
            any(),
            queryParameters: any(named: 'queryParameters'),
            method: HttpMethod.get,
          )).thenAnswer((_) async => FunctionResponse(
            data: {
              'data': [patientModel.toSeribaseMap()],
              'metadata': {'page': 1, 'per_page': 10, 'total': 1}
            },
            status: 200,
          ));

      final result = await repository.getPatients(page: 1, perPage: 10);

      expect(result, isA<BasePagination<PatientModel>>());
      verify(() => mockFunctionsClient.invoke(
            'patients',
            queryParameters: {'page': '1', 'page_size': '10'},
            method: HttpMethod.get,
          )).called(1);
    });
  });
}
