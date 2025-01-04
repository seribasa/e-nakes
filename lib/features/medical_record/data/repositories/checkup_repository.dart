import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/pagination_model.dart';

@injectable
class CheckupRepository {
  final SupabaseClient _supabaseClient;

  CheckupRepository(
    this._supabaseClient,
  );

  Future<BasePagination<CheckupModel>?> getCheckups({
    int? perPage,
    int? page,
    String? patientId,
    DateTime? date,
  }) async {
    try {
      final queries = {
        if (patientId != null) 'patient_id': patientId,
        if (page != null) 'page': page.toString(),
        if (perPage != null) 'page_size': perPage.toString(),
      };
      if (date != null) {
        queries['date'] = date.toIso8601String();
      }
      final fetch = await _supabaseClient.functions.invoke(
        'checkups',
        queryParameters: queries,
        method: HttpMethod.get,
      );

      if (fetch.status != 200) {
        throw Exception('Failed to get checkups');
      }

      final data = fetch.data;
      final result = BasePagination<CheckupModel>(
        data: data['data']?.map<CheckupModel>((e) {
          return CheckupModel.fromSeribase(e);
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

  Future<CheckupModel> setCheckup({
    required CheckupModel checkupModel,
  }) async {
    try {
      final userId = _supabaseClient.auth.currentUser?.id;
      if (userId == null) {
        throw Exception('User not authenticated');
      }
      final checkup = checkupModel
          .copyWith(
            healthWorkerId: userId,
          )
          .toSeribase();
      final fetch = await _supabaseClient.functions.invoke(
        'checkups',
        body: checkup,
        method: HttpMethod.post,
      );

      if (fetch.status != 200) {
        throw Exception('Failed to set checkup');
      }

      return CheckupModel.fromSeribase(fetch.data?['data'].first);
    } catch (e) {
      rethrow;
    }
  }

  Future<CheckupModel> updateCheckup({
    required CheckupModel checkupModel,
  }) async {
    try {
      final fetch = await _supabaseClient.functions.invoke(
        'checkups/${checkupModel.id}',
        queryParameters: checkupModel.toSeribase(),
        method: HttpMethod.put,
      );

      if (fetch.status != 200) {
        throw Exception('Failed to update checkup');
      }

      return CheckupModel.fromSeribase(fetch.data?['data']);
    } catch (e) {
      rethrow;
    }
  }
}
