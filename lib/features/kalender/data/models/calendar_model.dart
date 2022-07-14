import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CalendarModel extends Equatable {
  final String? uid;
  final DateTime? date;
  final String? activity;
  final String? documentID;
  final bool? readOnly;

  const CalendarModel(
      {this.uid,
      this.activity,
      this.date,
      this.documentID,
      this.readOnly = false});

  factory CalendarModel.fromMap(Map data, docID) {
    return CalendarModel(
      uid: data['uid'] ?? '',
      activity: data['activity'] ?? '',
      date: (data['date'] as Timestamp).toDate(),
      readOnly: data['readOnly'],
      documentID: docID,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "activity": activity,
      "date": date,
      "readOnly": readOnly,
    };
  }

  @override
  List<Object?> get props => [uid, activity, date, documentID, readOnly];
}
