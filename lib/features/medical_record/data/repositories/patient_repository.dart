import 'package:eimunisasi_nakes/core/models/parent_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/pagination_model.dart';

@injectable
class PatientRepository {
  final SupabaseClient _supabaseClient;

  PatientRepository(
    this._supabaseClient,
  );

  Future<ParentModel?> getParentByID({
    required String id,
  }) async {
    try {
      final fetch = await _supabaseClient.functions.invoke('parents/$id');

      return ParentModel.fromSeribase(fetch.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<PatientModel?> getPatient({
    required String id,
  }) async {
    try {
      final fetch = await _supabaseClient.functions.invoke('patients/$id');

      return PatientModel.fromSeribase(fetch.data?['data']);
    } catch (e) {
      rethrow;
    }
  }

  Future<BasePagination<PatientModel>?> getPatients({
    int? perPage,
    int? page,
    String? id,
    String? nik,
  }) async {
    try {
      final queryParameters = {
        if (id != null) 'id': id,
        if (nik != null) 'nik': nik,
        if (page != null) 'page': page.toString(),
        if (perPage != null) 'page_size': perPage.toString(),
      };

      final fetch = await _supabaseClient.functions.invoke(
        'patients',
        queryParameters: queryParameters,
        method: HttpMethod.get,
      );

      if (fetch.status != 200) {
        throw Exception('Failed to get appointments');
      }

      final data = fetch.data;
      final result = BasePagination<PatientModel>(
        data: data['data']?.map<PatientModel>((e) {
          return PatientModel.fromSeribase(e);
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
}
