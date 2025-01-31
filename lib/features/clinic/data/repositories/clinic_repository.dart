import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_member_model.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_model.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

@injectable
class ClinicRepository {
  final SupabaseClient _supabaseClient;
  ClinicRepository(this._supabaseClient);

  Future<ClinicModel> getClinic({
    required String? id,
  }) async {
    try {
      assert(id != null, 'id clinic tidak boleh kosong');
      return _supabaseClient
          .from(ClinicModel.tableName)
          .select(
            '*, clinic_schedules(*, days(*))',
          )
          .eq('id', id!)
          .single()
          .withConverter(
            (json) => ClinicModel.fromSeribase(json),
          );
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ClinicMemberModel>> getClinicMember({
    required String? id,
  }) async {
    try {
      assert(id != null, 'id clinic tidak boleh kosong');
      return _supabaseClient
          .from(ProfileModel.tableName)
          .select(
            '''
              *,
              clinic:clinics ( * )
            ''',
          )
          .eq('clinic_id', id!)
          .withConverter(
            (json) =>
                json.map((e) => ClinicMemberModel.fromSeribase(e)).toList(),
          );
    } catch (e) {
      rethrow;
    }
  }
}
