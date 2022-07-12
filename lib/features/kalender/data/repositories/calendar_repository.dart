import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';

class CalendarRepository {
  final FirebaseFirestore _firestore;

  CalendarRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<CalendarModel>?> getCalendarActivity(
      {required String uid}) async {
    final calendar = await _firestore
        .collection('calendar')
        .where('uid', isEqualTo: uid)
        .get();
    calendar.docs.forEach((element) {
      print(element.data());
    });
    // return CalendarModel.fromMap(doc.docs. ?? {}, id);
  }

  Future<void> addCalendarActivity({
    required CalendarModel calendarModel,
  }) async {
    final DocumentReference reference =
        _firestore.collection('calendars').doc();
    await reference.set(calendarModel.toMap());
  }

  Future<void> updateCalendarActivity(
      {required CalendarModel calendarModel}) async {
    final DocumentReference reference =
        _firestore.collection('calendars').doc();
    await reference.update(calendarModel.toMap());
  }

  Future<void> deleteCalendarActivity(
      {required CalendarModel calendarModel}) async {
    final DocumentReference reference =
        _firestore.collection('calendars').doc();
    await reference.delete();
  }
}
