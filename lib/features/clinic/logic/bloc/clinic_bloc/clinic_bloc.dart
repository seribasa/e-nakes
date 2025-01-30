import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_member_model.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_model.dart';
import 'package:eimunisasi_nakes/features/clinic/data/repositories/clinic_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'clinic_event.dart';
part 'clinic_state.dart';

@injectable
class ClinicBloc extends Bloc<ClinicEvent, ClinicState> {
  final ClinicRepository _clinicRepository;
  ClinicBloc(this._clinicRepository) : super(ClinicStateInitial()) {
    on<ClinicProfileSelected>(_fetchDataKlinik);
    on<ClinicMembershipSelected>(_fetchDataKeanggotaan);
  }
  Future<void> _fetchDataKlinik(
    ClinicProfileSelected event,
    Emitter<ClinicState> emit,
  ) async {
    emit(ClinicLoading());
    try {
      final data = await _clinicRepository.getClinic(id: event.clinicId);

      emit(ClinicFetchData(clinic: data));
    } catch (e) {
      emit(ClinicFailure(error: 'Terjadi kesalahan, silahkan coba lagi'));
    }
  }

  Future<void> _fetchDataKeanggotaan(
      ClinicMembershipSelected event, Emitter<ClinicState> emit) async {
    emit(ClinicLoading());
    try {
      final data = await _clinicRepository.getClinicMember(id: event.clinicId);

      emit(ClinicMemberDataFetched(data: data));
    } catch (e) {
      emit(ClinicFailure(error: 'Terjadi kesalahan, silahkan coba lagi'));
    }
  }
}
