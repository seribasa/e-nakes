import 'package:eimunisasi_nakes/core/models/orang_tua_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/repositories/jadwal_repository.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockFunctionsClient extends Mock implements FunctionsClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockUser extends Mock implements User {}

void main() {
  late MockFunctionsClient mockSupabaseFunctions;
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late MockUser mockSupabaseUser;
  late JadwalRepository jadwalRepository;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    reset(mockSupabaseClient);

    mockSupabaseFunctions = MockFunctionsClient();
    mockGoTrueClient = MockGoTrueClient();
    mockSupabaseUser = MockUser();
    jadwalRepository = JadwalRepository(mockSupabaseClient);
    when(() => mockSupabaseUser.id).thenReturn('1');
    when(() => mockGoTrueClient.currentUser).thenReturn(mockSupabaseUser);
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    when(() => mockSupabaseClient.functions).thenReturn(mockSupabaseFunctions);
  });

  group('JadwalRepository', () {
    final jadwalModel = JadwalPasienModel(
      id: '1',
      date: DateTime(2023, 10, 10),
      child: PasienModel(id: 'child1'),
      parent: OrangtuaModel(id: 'parent1'),
      note: 'note',
      purpose: 'purpose',
      startTime: '08:00',
      endTime: '10:00',
    );

    test('getAppointments returns appointments successfully', () async {
      when(() => mockSupabaseFunctions.invoke(
            'appointments',
            queryParameters: any(named: 'queryParameters'),
            method: HttpMethod.get,
          )).thenAnswer(
        (_) async => FunctionResponse(
          status: 200,
          data: {
            'data': [jadwalModel.toSeribase()],
            'metadata': {'total': 1},
          },
        ),
      );

      final result = await jadwalRepository.getAppointments();

      expect(result?.data?.length, 1);
      expect(result?.data?.first.id, '1');
    });

    test('getAppointments returns empty list when no appointments found',
        () async {
      when(() => mockSupabaseFunctions.invoke(
            'appointments',
            queryParameters: any(named: 'queryParameters'),
            method: HttpMethod.get,
          )).thenAnswer(
        (_) async => FunctionResponse(
          status: 200,
          data: {
            'data': [],
            'metadata': {'total': 0},
          },
        ),
      );

      final result = await jadwalRepository.getAppointments();

      expect(result?.data?.isEmpty, true);
    });

    test('getAppointment returns appointment successfully', () async {
      when(() => mockSupabaseFunctions.invoke(
            'appointments/1',
            method: HttpMethod.get,
          )).thenAnswer((_) async => FunctionResponse(
            status: 200,
            data: {'data': jadwalModel.toSeribase()},
          ));

      final result = await jadwalRepository.getAppointment(id: '1');

      expect(result?.id, '1');
    });

    test('getAppointment returns null when appointment not found', () async {
      when(() => mockSupabaseFunctions.invoke(
            'appointments/non-existent-id',
            method: HttpMethod.get,
          )).thenAnswer((_) async => FunctionResponse(
            status: 404,
          ));

      final result =
          await jadwalRepository.getAppointment(id: 'non-existent-id');

      expect(result, null);
    });

    test('addAppointment adds appointment successfully', () async {
      when(() => mockSupabaseFunctions.invoke(
            'appointment',
            method: HttpMethod.post,
            body: jadwalModel.toSeribase(),
          )).thenAnswer((_) async => FunctionResponse(
            status: 200,
            data: {'data': jadwalModel.toSeribase()},
          ));

      final result = await jadwalRepository.addAppointment(model: jadwalModel);

      expect(result.id, '1');
    });

    test('updateAppointment updates appointment successfully', () async {
      when(() => mockSupabaseFunctions.invoke(
            'appointment/1',
            method: HttpMethod.put,
            body: jadwalModel.toSeribase(),
          )).thenAnswer((_) async => FunctionResponse(
            status: 200,
            data: {'data': jadwalModel.toSeribase()},
          ));

      final result = await jadwalRepository.updateAppointment(
          model: jadwalModel, appointmentId: '1');

      expect(result.id, '1');
    });

    test('deleteAppointment deletes appointment successfully', () async {
      when(() => mockSupabaseFunctions.invoke(
            'appointment/1',
            method: HttpMethod.delete,
          )).thenAnswer((_) async => FunctionResponse(
            status: 200,
          ));

      expect(() => jadwalRepository.deleteAppointment(appointmentId: '1'),
          returnsNormally);
    });
  });
}
