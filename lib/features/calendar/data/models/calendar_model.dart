import 'package:equatable/equatable.dart';

class CalendarModel extends Equatable {
  final String? id, userId, activity;
  final DateTime? doAt, createdAt;
  final bool? readOnly;

  const CalendarModel({
    this.userId,
    this.activity,
    this.doAt,
    this.createdAt,
    this.id,
    this.readOnly = false,
  });

  static const String tableName = 'calendars';

  factory CalendarModel.fromMap(Map<String, dynamic> data) {
    return CalendarModel(
      id: data['id'],
      userId: data['user_id'],
      activity: data['activity'],
      doAt: () {
        try {
          return DateTime.parse(data['do_at']);
        } catch (e) {
          return null;
        }
      }(),
      createdAt: () {
        try {
          return DateTime.parse(data['created_at']);
        } catch (e) {
          return null;
        }
      }(),
      readOnly: data['read_only'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (activity != null) 'activity': activity,
      if (doAt != null) 'do_at': doAt!.toIso8601String(),
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
      if (readOnly != null) 'read_only': readOnly,
    };
  }

  CalendarModel copyWith({
    String? id,
    String? userId,
    String? activity,
    DateTime? doAt,
    DateTime? createdAt,
    bool? readOnly,
  }) {
    return CalendarModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      activity: activity ?? this.activity,
      doAt: doAt ?? this.doAt,
      createdAt: createdAt ?? this.createdAt,
      readOnly: readOnly ?? this.readOnly,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        activity,
        doAt,
        createdAt,
        readOnly,
      ];
}
