import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/repositories/jadwal_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'jadwal_state.dart';

@injectable
class JadwalCubit extends Cubit<JadwalState> {
  final JadwalRepository _appointmentRepository;

  JadwalCubit(
    this._appointmentRepository,
  ) : super(JadwalInitial());

  getAllJadwal({
    int? page,
    int? perPage,
    String? search,
    DateTime? date,
  }) async {
    emit(JadwalLoading());
    try {
      final result = await _appointmentRepository.getAppointments(
        page: page,
        perPage: perPage,
        search: search,
        date: date,
      );
      if (state.paginationAppointment?.metadata?.page == 1) {
        emit(JadwalLoaded(paginationAppointment: result));
      } else {
        final pagination = BasePagination<JadwalPasienModel>(
          data: [
            ...?state.paginationAppointment?.data,
            ...?result?.data,
          ],
          metadata: result?.metadata,
        );
        emit(JadwalLoaded(paginationAppointment: pagination));
      }
    } catch (e) {
      emit(
        JadwalError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      );
    }
  }

  getJadwalToday() async {
    emit(JadwalLoading());
    try {
      final result = await _appointmentRepository.getAppointments(
        date: DateTime.now(),
      );
      emit(JadwalLoaded(todayAppointment: result?.data?.first));
    } catch (e) {
      emit(JadwalError(message: 'Terjadi kesalahan, silahkan coba lagi'));
    }
  }

  getSelectedDetail(String id) async {
    emit(JadwalLoading());
    try {
      final result = await _appointmentRepository.getAppointment(id: id);
      emit(JadwalLoaded(selectedAppointment: result));
    } catch (e) {
      emit(JadwalError(message: 'Terjadi kesalahan, silahkan coba lagi'));
    }
  }
}
