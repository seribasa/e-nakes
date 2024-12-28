import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/pagination_model.dart';

@injectable
class JadwalRepository {
  final SupabaseClient _supabase;

  JadwalRepository(
    this._supabase,
  );

  final String table = 'appointments';

  Future<BasePagination<JadwalPasienModel>?> getAppointments({
    int? page,
    int? perPage,
    String? search,
    DateTime? date,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      final queryParameters = {
        if (userId != null) 'user_id': userId,
        if (page != null) 'page': page.toString(),
        if (perPage != null) 'page_size': perPage.toString(),
        if (date != null) 'date': date.toIso8601String(),
      };

      final fetch = await _supabase.functions.invoke(
        'appointments',
        queryParameters: queryParameters,
        method: HttpMethod.get,
      );

      if (fetch.status != 200) {
        throw Exception('Failed to get appointments');
      }

      final data = fetch.data;
      final result = BasePagination<JadwalPasienModel>(
        data: data['data']?.map<JadwalPasienModel>((e) {
          return JadwalPasienModel.fromSeribase(e);
        }).toList(),
        metadata: () {
          final metadata = data['metadata'];
          if (metadata == null) return null;
          return MetadataPaginationModel.fromMap(metadata);
        }(),
      );

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<JadwalPasienModel?> getAppointment({
    String? id,
  }) async {
    try {
      final fetch = await _supabase.functions.invoke(
        'appointments/$id',
        method: HttpMethod.get,
      );

      if (fetch.status == 404) {
        return null;
      }

      if (fetch.status != 200) {
        throw Exception('Failed to get appointment for id: $id');
      }

      final data = fetch.data;
      final result = JadwalPasienModel.fromSeribase(data['data']);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<JadwalPasienModel> addAppointment({
    required JadwalPasienModel model,
  }) async {
    try {
      final fetch = await _supabase.functions.invoke('appointment',
          method: HttpMethod.post, body: model.toSeribase());

      if (fetch.status != 200) {
        throw Exception('Failed to add appointment');
      }

      final data = fetch.data;
      final result = JadwalPasienModel.fromSeribase(data['data']);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<JadwalPasienModel> updateAppointment({
    required JadwalPasienModel model,
    required String? appointmentId,
  }) async {
    try {
      final fetch = await _supabase.functions.invoke(
          'appointment/$appointmentId',
          method: HttpMethod.put,
          body: model.toSeribase());

      if (fetch.status != 200) {
        throw Exception('Failed to update appointment');
      }

      final data = fetch.data;
      final result = JadwalPasienModel.fromSeribase(data['data']);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteAppointment({
    required String appointmentId,
  }) async {
    try {
      final fetch = await _supabase.functions.invoke(
        'appointment/$appointmentId',
        method: HttpMethod.delete,
      );

      if (fetch.status != 200) {
        throw Exception('Failed to delete appointment');
      }
    } catch (e) {
      rethrow;
    }
  }
}
