import 'package:eimunisasi_nakes/features/calendar/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/calendar/data/repositories/calendar_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_supabase_http_client/mock_supabase_http_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  late CalendarRepository repository;
  late SupabaseClient mockSupabaseClient;
  late final MockSupabaseHttpClient mockHttpClient;

  setUpAll(() {
    mockHttpClient = MockSupabaseHttpClient();
    mockSupabaseClient = SupabaseClient(
      'http://localhost:8080',
      'supabaseKey',
      httpClient: mockHttpClient,
    );
  });

  tearDown(() async {
    mockHttpClient.reset();
  });

  tearDownAll(() {
    mockHttpClient.close();
  });

  setUp(() {
    repository = CalendarRepository(mockSupabaseClient);
  });

  group('CalendarRepository', () {
    final testCalendar = CalendarModel(
      id: '1',
      userId: 'test-user-id',
      activity: 'Test Calendar',
      doAt: DateTime.now(),
    );

    test('getCalendarActivity throw Exception Assert User id is null',
        () async {
      final result = repository.getCalendarActivity(
        page: 0,
        perPage: 10,
      );

      expect(result, throwsA(isA<AssertionError>()));
      expect(
        result,
        throwsA(predicate((e) => e.toString().contains('User id is null'))),
      );
    });

    test('getSpecificCalendarActivity throw Exception Assert User id is null',
        () async {
      final result = repository.getSpecificCalendarActivity(
        date: DateTime.now(),
      );

      expect(result, throwsA(isA<AssertionError>()));
      expect(
        result,
        throwsA(predicate((e) => e.toString().contains('User id is null'))),
      );
    });

    test('addCalendarActivity throw Exception Assert User id is null',
        () async {
      final result = repository.addCalendarActivity(
        calendarModel: testCalendar,
      );

      expect(result, throwsA(isA<AssertionError>()));
      expect(
        result,
        throwsA(predicate((e) => e.toString().contains('User id is null'))),
      );
    });

    test('updateCalendarActivity throw Exception Assert User id is null',
        () async {
      final result = repository.updateCalendarActivity(
        calendarModel: testCalendar,
      );

      expect(result, throwsA(isA<AssertionError>()));
      expect(
        result,
        throwsA(predicate((e) => e.toString().contains('User id is null'))),
      );
    });

    test('deleteCalendarActivity deletes calendar', () async {
      await mockSupabaseClient.from('calendars').insert(
            testCalendar.toMap(),
          );

      final result = repository.deleteCalendarActivity(
        docId: testCalendar.id!,
      );

      expect(result, completes);
      expect(
        result,
        completion(isA<void>()),
      );
    });
  });
}
