import 'package:eimunisasi_nakes/features/calendar/data/models/calendar_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CalendarModel', () {
    final tCalendarModel = CalendarModel(
      id: '1',
      userId: 'user1',
      activity: 'Test Activity',
      doAt: DateTime(2023, 1, 1),
      createdAt: DateTime(2023, 1, 1),
      readOnly: false,
    );

    final tCalendarMap = {
      'id': '1',
      'user_id': 'user1',
      'activity': 'Test Activity',
      'do_at': '2023-01-01T00:00:00.000',
      'created_at': '2023-01-01T00:00:00.000',
      'read_only': false,
    };

    test('should create CalendarModel instance', () {
      expect(tCalendarModel, isA<CalendarModel>());
    });

    test('should convert CalendarModel to Map', () {
      final result = tCalendarModel.toMap();
      expect(result, equals(tCalendarMap));
    });

    test('should create CalendarModel from Map', () {
      final result = CalendarModel.fromMap(tCalendarMap);
      expect(result, equals(tCalendarModel));
    });

    test('should handle null dates in fromMap', () {
      final mapWithInvalidDates = {
        'id': '1',
        'user_id': 'user1',
        'activity': 'Test Activity',
        'do_at': 'invalid-date',
        'created_at': 'invalid-date',
        'read_only': false,
      };

      final result = CalendarModel.fromMap(mapWithInvalidDates);
      expect(result.doAt, isNull);
      expect(result.createdAt, isNull);
    });

    test('should create copy with new values', () {
      final newDateTime = DateTime(2023, 2, 1);
      final copied = tCalendarModel.copyWith(
        activity: 'New Activity',
        doAt: newDateTime,
      );

      expect(copied.activity, equals('New Activity'));
      expect(copied.doAt, equals(newDateTime));
      expect(copied.id, equals(tCalendarModel.id));
    });
  });
}