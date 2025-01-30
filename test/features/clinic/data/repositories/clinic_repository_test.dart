import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_member_model.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_model.dart';
import 'package:eimunisasi_nakes/features/clinic/data/repositories/clinic_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_supabase_http_client/mock_supabase_http_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late ClinicRepository repository;
  late SupabaseClient mockSupabaseClient;

  setUp(() {
    mockSupabaseClient = SupabaseClient(
      'dummy.supabase.co',
      'dummyKey',
      httpClient: MockSupabaseHttpClient(),
    );
    repository = ClinicRepository(mockSupabaseClient);
  });

  group('ClinicRepository', () {
    group('getClinic', () {
      test('should throw AssertionError when id is null', () {
        expect(
          () => repository.getClinic(id: null),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should return ClinicModel when successful', () async {
        const id = '123';
        final mockClinicData = {
          'id': id,
          'name': 'Test Clinic',
        };

        await mockSupabaseClient
            .from(ClinicModel.tableName)
            .insert(mockClinicData);

        final result = await repository.getClinic(id: id);

        expect(result, isA<ClinicModel>());
        expect(result.id, equals(id));
      });
    });

    group('getClinicMember', () {
      test('should throw AssertionError when id is null', () {
        expect(
          () => repository.getClinicMember(id: null),
          throwsA(isA<AssertionError>()),
        );
      });

      test('should return List<ClinicMemberModel> when successful', () async {
        const id = '123';
        final mockMemberData = {
          'full_name': 'John Doe',
          'user_id': '456',
          'clinic_id': id,
        };

        final mockClinicData = {
          'id': id,
          'name': 'Test Clinic',
        };

        await mockSupabaseClient
            .from(ClinicModel.tableName)
            .insert(mockClinicData);

        await mockSupabaseClient
            .from(ProfileModel.tableName)
            .insert(mockMemberData);

        final result = await repository.getClinicMember(id: id);

        expect(result, isA<List<ClinicMemberModel>>());
        expect(result.length, equals(1));
        expect(
          result.first.healthWorkerName,
          equals(mockMemberData['full_name']),
        );
      });
    });
  });
}
