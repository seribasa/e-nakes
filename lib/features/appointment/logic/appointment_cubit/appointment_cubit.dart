import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/appointment_model.dart';
import '../../data/repositories/appointment_repository.dart';

part 'appointment_state.dart';

@injectable
class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository _appointmentRepository;

  AppointmentCubit(
    this._appointmentRepository,
  ) : super(AppointmentInitial());

  getAllJadwal({
    int? page,
    int? perPage,
    String? search,
    DateTime? date,
  }) async {
    emit(AppointmentLoading());
    try {
      final result = await _appointmentRepository.getAppointments(
        page: page,
        perPage: perPage,
        search: search,
        date: date,
      );
      if (state.paginationAppointment?.metadata?.page == 1) {
        emit(AppointmentLoaded(paginationAppointment: result));
      } else {
        final pagination = BasePagination<PatientAppointmentModel>(
          data: [
            ...?state.paginationAppointment?.data,
            ...?result?.data,
          ],
          metadata: result?.metadata,
        );
        emit(AppointmentLoaded(paginationAppointment: pagination));
      }
    } catch (e) {
      emit(
        AppointmentError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      );
    }
  }

  getJadwalToday() async {
    emit(AppointmentLoading());
    try {
      final result = await _appointmentRepository.getAppointments(
        date: DateTime.now(),
      );
      emit(AppointmentLoaded(todayAppointment: result?.data?.first));
    } catch (e) {
      emit(AppointmentError(message: 'Terjadi kesalahan, silahkan coba lagi'));
    }
  }

  getSelectedDetail(String id) async {
    emit(AppointmentLoading());
    try {
      final result = await _appointmentRepository.getAppointment(id: id);
      emit(AppointmentLoaded(selectedAppointment: result));
    } catch (e) {
      emit(AppointmentError(message: 'Terjadi kesalahan, silahkan coba lagi'));
    }
  }
}
