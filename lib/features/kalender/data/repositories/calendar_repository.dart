import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';

class CalendarRepository {
  final FirebaseFirestore _firestore;

  CalendarRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<CalendarModel>?> getCalendarActivity(
      {required String? uid}) async {
    List<CalendarModel> result = [];
    final calendar = await _firestore
        .collection('calendars')
        .where('uid', isEqualTo: uid)
        .get();
    for (var element in calendar.docs) {
      result.add(CalendarModel.fromMap(element.data(), element.id));
    }
    return result;
  }

  Future<List<CalendarModel>?> getSpecificCalendarActivity(
      {required String? uid, DateTime? date}) async {
    List<CalendarModel>? result;
    final calendar = await _firestore
        .collection('calendars')
        .where('uid', isEqualTo: uid)
        .where('date', isEqualTo: date)
        .get();
    for (var element in calendar.docs) {
      result?.add(CalendarModel.fromMap(element.data(), element.id));
    }
    return result;
  }

  Future<void> addCalendarActivity({
    required CalendarModel calendarModel,
  }) async {
    final DocumentReference reference =
        _firestore.collection('calendars').doc();
    await reference.set(calendarModel.toMap());
  }

  Future<void> updateCalendarActivity(
      {required CalendarModel calendarModel, required String? docId}) async {
    final DocumentReference reference =
        _firestore.collection('calendars').doc(docId);
    await reference.update(calendarModel.toMap());
  }

  Future<void> deleteCalendarActivity({required String docId}) async {
    final DocumentReference reference =
        _firestore.collection('calendars').doc(docId);
    await reference.delete();
  }
}
