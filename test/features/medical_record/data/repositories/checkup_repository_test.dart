import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/checkup_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockFunctionsClient extends Mock implements FunctionsClient {}

class MockFunctionResponse extends Mock implements FunctionResponse {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

void main() {
  late CheckupRepository repository;
  late MockSupabaseClient mockSupabaseClient;
  late MockFunctionsClient mockFunctions;
  late MockFunctionResponse mockResponse;
  late MockGoTrueClient mockGoTrueClient;
  late MockUser mockSupabaseUser;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    reset(mockSupabaseClient);

    mockFunctions = MockFunctionsClient();
    mockResponse = MockFunctionResponse();
    mockGoTrueClient = MockGoTrueClient();
    mockSupabaseUser = MockUser();

    repository = CheckupRepository(mockSupabaseClient);
    when(() => mockSupabaseUser.id).thenReturn('1');
    when(() => mockGoTrueClient.currentUser).thenReturn(mockSupabaseUser);
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);

    when(() => mockSupabaseClient.functions).thenReturn(mockFunctions);
  });

  group('CheckupRepository', () {
    test('getCheckups returns BasePagination of CheckupModel', () async {
      when(() => mockResponse.status).thenReturn(200);
      when(() => mockResponse.data).thenReturn({
        'data': [],
        'metadata': {'total': 0, 'page': 1, 'per_page': 10}
      });
      when(() => mockFunctions.invoke(
            'checkups',
            queryParameters: any(named: 'queryParameters'),
            method: HttpMethod.get,
          )).thenAnswer((_) async => mockResponse);

      final result = await repository.getCheckups();

      expect(result, isA<BasePagination<CheckupModel>>());
    });

    test('getCheckups with parameters calls API with correct query params', () async {
      final date = DateTime(2023);
      when(() => mockResponse.status).thenReturn(200);
      when(() => mockResponse.data).thenReturn({
        'data': [],
        'metadata': {'total': 0, 'page': 1, 'per_page': 10}
      });
      when(() => mockFunctions.invoke(
            'checkups',
            queryParameters: {
              'patient_id': 'test_id',
              'page': '1',
              'page_size': '10',
              'date': date.toIso8601String()
            },
            method: HttpMethod.get,
          )).thenAnswer((_) async => mockResponse);

      await repository.getCheckups(
        patientId: 'test_id',
        page: 1,
        perPage: 10,
        date: date,
      );

      verify(() => mockFunctions.invoke(
            'checkups',
            queryParameters: {
              'patient_id': 'test_id',
              'page': '1',
              'page_size': '10',
              'date': date.toIso8601String()
            },
            method: HttpMethod.get,
          )).called(1);
    });

    test('getCheckups throws exception when status is not 200', () async {
      when(() => mockResponse.status).thenReturn(400);
      when(() => mockFunctions.invoke(
            'checkups',
            queryParameters: any(named: 'queryParameters'),
            method: HttpMethod.get,
          )).thenAnswer((_) async => mockResponse);

      expect(
        () => repository.getCheckups(),
        throwsException,
      );
    });

    test('setCheckup creates new checkup', () async {
      final checkup = CheckupModel(weight: 2);
      when(() => mockResponse.status).thenReturn(200);
      when(() => mockResponse.data).thenReturn({
        'data': [checkup.toSeribase()],
      });
      when(() => mockFunctions.invoke(
            'checkups',
            body: any(named: 'body'),
            method: HttpMethod.post,
          )).thenAnswer(
        (_) async => mockResponse,
      );

      final result = await repository.setCheckup(checkupModel: checkup);

      expect(result, isA<CheckupModel>());
    });

    test('setCheckup throws exception when status is not 200', () async {
      final checkup = CheckupModel();
      when(() => mockResponse.status).thenReturn(400);
      when(() => mockFunctions.invoke(
            'checkups',
            body: any(named: 'body'),
            method: HttpMethod.post,
          )).thenThrow(
        Exception('Failed to create checkup'),
      );

      expect(
        () => repository.setCheckup(checkupModel: checkup),
        throwsException,
      );
    });

    test('updateCheckup updates existing checkup', () async {
      final checkup = CheckupModel();
      when(() => mockResponse.status).thenReturn(200);
      when(() => mockResponse.data).thenReturn({
        'data': checkup.toSeribase(),
      });
      when(() => mockFunctions.invoke(
            'checkups/${checkup.id}',
            body: any(named: 'body'),
            method: HttpMethod.put,
          )).thenAnswer((_) async => mockResponse);

      final result = await repository.updateCheckup(checkupModel: checkup);

      expect(result, isA<CheckupModel>());
    });

    test('updateCheckup throws exception when status is not 200', () async {
      final checkup = CheckupModel();
      when(() => mockResponse.status).thenReturn(400);
      when(() => mockFunctions.invoke(
            'checkups/${checkup.id}',
            body: any(named: 'body'),
            method: HttpMethod.put,
          )).thenAnswer((_) async => mockResponse);

      expect(
        () => repository.updateCheckup(checkupModel: checkup),
        throwsException,
      );
    });
  });
}
