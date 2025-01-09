import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/appointment/data/models/appointment_model.dart';
import 'package:eimunisasi_nakes/features/appointment/data/repositories/appointment_repository.dart';
import 'package:eimunisasi_nakes/features/appointment/logic/appointment_cubit/appointment_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJadwalRepository extends Mock implements AppointmentRepository {}

void main() {
  late AppointmentCubit jadwalCubit;
  late MockJadwalRepository mockRepository;

  setUp(() {
    mockRepository = MockJadwalRepository();
    jadwalCubit = AppointmentCubit(mockRepository);
  });

  group('JadwalCubit getAllJadwal', () {
    final tPagination = BasePagination<PatientAppointmentModel>(
      data: [PatientAppointmentModel()],
      metadata: MetadataPaginationModel(
        page: 1,
        perPage: 10,
        total: 1,
      ),
    );

    blocTest<AppointmentCubit, AppointmentState>(
      'emits [JadwalLoading, JadwalLoaded] when getAllJadwal is successful',
      build: () {
        when(() => mockRepository.getAppointments(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
              search: any(named: 'search'),
              date: any(named: 'date'),
            )).thenAnswer((_) async => tPagination);
        return jadwalCubit;
      },
      act: (cubit) => cubit.getAllJadwal(),
      expect: () => [
        AppointmentLoading(),
        AppointmentLoaded(paginationAppointment: tPagination),
      ],
    );

    blocTest<AppointmentCubit, AppointmentState>(
      'emits [JadwalLoading, JadwalError] when getAllJadwal fails',
      build: () {
        when(() => mockRepository.getAppointments(
              page: any(named: 'page'),
              perPage: any(named: 'perPage'),
              search: any(named: 'search'),
              date: any(named: 'date'),
            )).thenThrow(Exception());
        return jadwalCubit;
      },
      act: (cubit) => cubit.getAllJadwal(),
      expect: () => [
        AppointmentLoading(),
        AppointmentError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );
  });

  group('JadwalCubit getJadwalToday', () {
    final tJadwal = PatientAppointmentModel();

    blocTest<AppointmentCubit, AppointmentState>(
      'emits [JadwalLoading, JadwalLoaded] when getJadwalToday is successful',
      build: () {
        when(() => mockRepository.getAppointments(
              date: any(named: 'date'),
            )).thenAnswer((_) async => BasePagination<PatientAppointmentModel>(
                data: [tJadwal],
                metadata: MetadataPaginationModel(
                  page: 1,
                  perPage: 10,
                  total: 1,
                )));
        return jadwalCubit;
      },
      act: (cubit) => cubit.getJadwalToday(),
      expect: () => [
        AppointmentLoading(),
        AppointmentLoaded(todayAppointment: tJadwal),
      ],
    );

    blocTest<AppointmentCubit, AppointmentState>(
      'emits [JadwalLoading, JadwalError] when getJadwalToday fails',
      build: () {
        when(() => mockRepository.getAppointments(
              date: any(named: 'date'),
            )).thenThrow(Exception());
        return jadwalCubit;
      },
      act: (cubit) => cubit.getJadwalToday(),
      expect: () => [
        AppointmentLoading(),
        AppointmentError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );
  });

  group('JadwalCubit getSelectedDetail', () {
    final tJadwal = PatientAppointmentModel();

    blocTest<AppointmentCubit, AppointmentState>(
      'emits [JadwalLoading, JadwalLoaded] when getSelectedDetail is successful',
      build: () {
        when(() => mockRepository.getAppointment(
              id: any(named: 'id'),
            )).thenAnswer((_) async => tJadwal);
        return jadwalCubit;
      },
      act: (cubit) => cubit.getSelectedDetail('1'),
      expect: () => [
        AppointmentLoading(),
        AppointmentLoaded(selectedAppointment: tJadwal),
      ],
    );

    blocTest<AppointmentCubit, AppointmentState>(
      'emits [JadwalLoading, JadwalError] when getSelectedDetail fails',
      build: () {
        when(() => mockRepository.getAppointment(
              id: any(named: 'id'),
            )).thenThrow(Exception());
        return jadwalCubit;
      },
      act: (cubit) => cubit.getSelectedDetail('1'),
      expect: () => [
        AppointmentLoading(),
        AppointmentError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );
  });
}
