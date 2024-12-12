import 'package:flutter_test/flutter_test.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/klinik/data/models/klinik.dart';

void main() {
  group('ProfileModel', () {
    final profile = ProfileModel(
      id: '123',
      email: 'test@example.com',
      phone: '1234567890',
      fullName: 'Test User',
      photo: 'http://example.com/photo.jpg',
      birthDate: DateTime(2000, 1, 1),
      birthPlace: 'Test City',
      kartuKeluarga: '1234567890123456',
      nik: '1234567890123456',
      profession: 'Doctor',
      schedules: [
        Schedule(
            day: Day(id: 1, name: 'Monday'),
            startTime: '09:00',
            endTime: '17:00')
      ],
      schedulesImunisasi: [
        Schedule(
            day: Day(id: 2, name: 'Tuesday'),
            startTime: '10:00',
            endTime: '12:00')
      ],
      clinic: ClinicModel(id: '1', name: 'Test Clinic'),
    );

    test('isEmpty returns true for empty profile', () {
      expect(ProfileModel.empty.isEmpty, true);
    });

    test('isNotEmpty returns true for non-empty profile', () {
      expect(profile.isNotEmpty, true);
    });

    test('fromSeribase creates a valid ProfileModel', () {
      final map = {
        'user_id': '123',
        'email': 'test@example.com',
        'phone_number': '1234567890',
        'full_name': 'Test User',
        'avatar_url': 'http://example.com/photo.jpg',
        'date_of_birth': '2000-01-01T00:00:00.000',
        'place_of_birth': 'Test City',
        'no_kartu_keluarga': '1234567890123456',
        'no_induk_kependudukan': '1234567890123456',
        'profession': 'Doctor',
        'schedules': [
          {
            'day': {'id': 1, 'name': 'Monday'},
            'start_time': '09:00',
            'end_time': '17:00'
          }
        ],
        'practice_schedules': [
          {
            'day': {'id': 2, 'name': 'Tuesday'},
            'start_time': '10:00',
            'end_time': '12:00'
          }
        ],
        'clinic': {'id': '1', 'name': 'Test Clinic'}
      };
      final profileFromMap = ProfileModel.fromSeribase(map);
      expect(profileFromMap.email, 'test@example.com');
      expect(profileFromMap.phone, '1234567890');
      expect(profileFromMap.fullName, 'Test User');
      expect(profileFromMap.photo, 'http://example.com/photo.jpg');
      expect(profileFromMap.birthDate, DateTime(2000, 1, 1));
      expect(profileFromMap.birthPlace, 'Test City');
      expect(profileFromMap.kartuKeluarga, '1234567890123456');
      expect(profileFromMap.nik, '1234567890123456');
      expect(profileFromMap.profession, 'Doctor');
      expect(profileFromMap.schedules?.first.day?.name, 'Monday');
      expect(profileFromMap.schedules?.first.startTime, '09:00');
      expect(profileFromMap.schedules?.first.endTime, '17:00');
      expect(profileFromMap.schedulesImunisasi?.first.day?.name, 'Tuesday');
      expect(profileFromMap.schedulesImunisasi?.first.startTime, '10:00');
      expect(profileFromMap.schedulesImunisasi?.first.endTime, '12:00');
    });

    test('toSeribaseMap returns a valid map', () {
      final map = profile.toSeribaseMap();
      expect(map['email'], 'test@example.com');
      expect(map['phone_number'], '1234567890');
      expect(map['full_name'], 'Test User');
      expect(map['avatar_url'], 'http://example.com/photo.jpg');
      expect(map['date_of_birth'], '2000-01-01T00:00:00.000');
      expect(map['place_of_birth'], 'Test City');
      expect(map['no_kartu_keluarga'], '1234567890123456');
      expect(map['no_induk_kependudukan'], '1234567890123456');
      expect(map['profession'], 'Doctor');
    });

    test('copyWith creates a copy with updated values', () {
      final updatedProfile = profile.copyWith(
        email: 'new@example.com',
        schedules: [
          Schedule(
            day: Day(id: 2, name: 'Tuesday'),
            startTime: '10:00',
            endTime: '12:00',
          ),
        ],
        schedulesImunisasi: [
          Schedule(
            day: Day(id: 3, name: 'Wednesday'),
            startTime: '11:00',
            endTime: '13:00',
          ),
        ],
        clinic: ClinicModel(id: '2', name: 'New Clinic'),
      );
      expect(updatedProfile.email, 'new@example.com');
      expect(updatedProfile.phone, '1234567890');
      expect(updatedProfile.schedules?.first.day?.name, 'Tuesday');
      expect(updatedProfile.schedules?.first.startTime, '10:00');
      expect(updatedProfile.schedules?.first.endTime, '12:00');
      expect(updatedProfile.schedulesImunisasi?.first.day?.name, 'Wednesday');
      expect(updatedProfile.schedulesImunisasi?.first.startTime, '11:00');
      expect(updatedProfile.schedulesImunisasi?.first.endTime, '13:00');
    });

    test('copyWith equals original profile when no values are updated', () {
      final updatedProfile = profile.copyWith();
      expect(updatedProfile, profile);
    });
  });

  group('Schedule', () {
    final schedule = Schedule(
        day: Day(id: 1, name: 'Monday'), startTime: '09:00', endTime: '17:00');

    test('fromSeribase creates a valid Schedule', () {
      final map = {
        'day': {'id': 1, 'name': 'Monday'},
        'start_time': '09:00',
        'end_time': '17:00'
      };
      final scheduleFromMap = Schedule.fromSeribase(map);
      expect(scheduleFromMap.day?.name, 'Monday');
      expect(scheduleFromMap.startTime, '09:00');
      expect(scheduleFromMap.endTime, '17:00');
    });

    test('toSeribase returns a valid map', () {
      final map = schedule.toSeribase();
      expect(map['day_id'], 1);
      expect(map['start_time'], '09:00');
      expect(map['end_time'], '17:00');
    });
  });

  group('Day', () {
    final day = Day(id: 1, name: 'Monday');

    test('fromSeribase creates a valid Day', () {
      final map = {'id': 1, 'name': 'Monday'};
      final dayFromMap = Day.fromSeribase(map);
      expect(dayFromMap.id, 1);
      expect(dayFromMap.name, 'Monday');
    });

    test('toSeribase returns a valid map', () {
      final map = day.toSeribase();
      expect(map['id'], 1);
      expect(map['name'], 'Monday');
    });
  });
}
