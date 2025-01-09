import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/calendar/data/models/calendar_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class CalendarRepository {
  final SupabaseClient _supabase;

  CalendarRepository(
    this._supabase,
  );

  Future<BasePagination<CalendarModel>?> getCalendarActivity({
    int? page,
    int? perPage,
  }) async {
    try {
      final from = page! * perPage!;
      final to = from + perPage;
      final userId = _supabase.auth.currentUser?.id;
      assert(userId != null, 'User id is null');
      final result = await _supabase
          .from('calendars')
          .select()
          .eq('user_id', userId!)
          .range(from, to)
          .count(CountOption.exact)
          .withConverter(
            (calendars) => calendars.map((calendar) {
              return CalendarModel.fromMap(calendar);
            }).toList(),
          );

      return BasePagination<CalendarModel>(
        data: result.data,
        metadata: MetadataPaginationModel(
          total: result.count,
          page: page,
          perPage: perPage,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<BasePagination<CalendarModel>?> getSpecificCalendarActivity({
    DateTime? date,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      assert(userId != null, 'User id is null');
      final result = await _supabase
          .from('calendars')
          .select()
          .eq('user_id', userId!)
          .eq('do_at', date!.toIso8601String())
          .withConverter(
            (calendars) => calendars.map((calendar) {
              return CalendarModel.fromMap(calendar);
            }).toList(),
          );

      return BasePagination<CalendarModel>(
        data: result,
        metadata: MetadataPaginationModel(
          total: result.length,
          page: 1,
          perPage: 1,
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<CalendarModel> addCalendarActivity({
    required CalendarModel calendarModel,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      assert(userId != null, 'User id is null');
      final json = calendarModel.copyWith(
        userId: userId,
      ).toMap();
      final result =
          await _supabase.from('calendars').insert(json).single().withConverter(
                (calendar) => CalendarModel.fromMap(calendar),
              );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<CalendarModel> updateCalendarActivity({
    required CalendarModel calendarModel,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      assert(userId != null, 'User id is null');
      assert(calendarModel.id != null, 'Calendar id is null');

      final json = calendarModel.toMap();
      final result = await _supabase
          .from('calendars')
          .update(json)
          .eq('id', calendarModel.id!)
          .single()
          .withConverter(
            (calendar) => CalendarModel.fromMap(calendar),
          );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteCalendarActivity({
    required String docId,
  }) async {
    try {
      await _supabase.from('calendars').delete().eq('id', docId);
    } catch (e) {
      rethrow;
    }
  }
}
