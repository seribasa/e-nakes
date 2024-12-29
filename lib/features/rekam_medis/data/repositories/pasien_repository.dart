import 'package:eimunisasi_nakes/core/models/orang_tua_model.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pasien_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/models/pagination_model.dart';

@injectable
class PasienRepository {
  final SupabaseClient _supabaseClient;

  PasienRepository(
  this._supabaseClient,
  );

  Future<OrangtuaModel?> getParentByID({
    required String id,
  }) async {
    try {
      final fetch = await _supabaseClient.functions.invoke('parents/$id');

      return OrangtuaModel.fromSeribase(fetch.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<PasienModel?> getPatient({
    required String id,
  }) async {
    try {
      final fetch = await _supabaseClient.functions.invoke('patients/$id');

      return PasienModel.fromSeribase(fetch.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<BasePagination<PasienModel>?> getPatients({
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
      final result = BasePagination<PasienModel>(
        data: data['data']?.map<PasienModel>((e) {
          return PasienModel.fromSeribase(e);
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
