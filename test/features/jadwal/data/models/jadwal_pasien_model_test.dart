import 'package:flutter_test/flutter_test.dart';
import 'package:eimunisasi_nakes/features/appointment/data/models/appointment_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:eimunisasi_nakes/core/models/parent_model.dart';

void main() {
  group('JadwalPasienModel', () {
    final parent = ParentModel(id: 'parent1');
    final child = PatientModel(id: 'child1');
    final date = DateTime(2023, 10, 10);
    final jadwal = PatientAppointmentModel(
      id: '1',
      date: date,
      child: child,
      parent: parent,
      note: 'note',
      purpose: 'purpose',
      startTime: '08:00',
      endTime: '10:00',
    );

    test('time returns correct formatted time', () {
      expect(jadwal.time, '08:00 - 10:00');
    });

    test('copyWith returns a new instance with updated values', () {
      final newJadwal = jadwal.copyWith(note: 'new note');
      expect(newJadwal.note, 'new note');
      expect(newJadwal.id, '1');
    });

    test('fromSeribase creates an instance from a map', () {
      final map = {
        'id': '1',
        'date': '2023-10-10T00:00:00.000',
        'child': {'id': 'child1'},
        'parent': {'id': 'parent1'},
        'note': 'note',
        'purpose': 'purpose',
        'start_time': '08:00',
        'end_time': '10:00',
      };
      final jadwalFromMap = PatientAppointmentModel.fromSeribase(map);
      expect(jadwalFromMap.id, '1');
      expect(jadwalFromMap.date, date);
    });

    test('toSeribase returns a map with correct values', () {
      final map = jadwal.toSeribase();
      expect(map['id'], '1');
      expect(map['date'], '2023-10-10T00:00:00.000');
      expect(map['parent_id'], 'parent1');
      expect(map['child_id'], 'child1');
    });

    test('time returns empty string if startTime or endTime is null', () {
      final jadwalWithNullTime = PatientAppointmentModel(
        id: '1',
        date: date,
        child: child,
        parent: parent,
        note: 'note',
        purpose: 'purpose',
        startTime: null,
        endTime: null,
      );
      expect(jadwalWithNullTime.time, '');
    });
  });
}