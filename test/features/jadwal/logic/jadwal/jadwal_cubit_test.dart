import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/models/jadwal_model.dart';
import 'package:eimunisasi_nakes/features/jadwal/data/repositories/jadwal_repository.dart';
import 'package:eimunisasi_nakes/features/jadwal/logic/jadwal/jadwal_cubit.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockJadwalRepository extends Mock implements JadwalRepository {}

void main() {
  late JadwalCubit jadwalCubit;
  late MockJadwalRepository mockRepository;

  setUp(() {
    mockRepository = MockJadwalRepository();
    jadwalCubit = JadwalCubit(mockRepository);
  });

  group('JadwalCubit getAllJadwal', () {
    final tPagination = BasePagination<JadwalPasienModel>(
      data: [JadwalPasienModel()],
      metadata: MetadataPaginationModel(
        page: 1,
        perPage: 10,
        total: 1,
      ),
    );

    blocTest<JadwalCubit, JadwalState>(
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
        JadwalLoading(),
        JadwalLoaded(paginationAppointment: tPagination),
      ],
    );

    blocTest<JadwalCubit, JadwalState>(
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
        JadwalLoading(),
        JadwalError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );
  });

  group('JadwalCubit getJadwalToday', () {
    final tJadwal = JadwalPasienModel();

    blocTest<JadwalCubit, JadwalState>(
      'emits [JadwalLoading, JadwalLoaded] when getJadwalToday is successful',
      build: () {
        when(() => mockRepository.getAppointments(
              date: any(named: 'date'),
            )).thenAnswer((_) async => BasePagination<JadwalPasienModel>(
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
        JadwalLoading(),
        JadwalLoaded(todayAppointment: tJadwal),
      ],
    );

    blocTest<JadwalCubit, JadwalState>(
      'emits [JadwalLoading, JadwalError] when getJadwalToday fails',
      build: () {
        when(() => mockRepository.getAppointments(
              date: any(named: 'date'),
            )).thenThrow(Exception());
        return jadwalCubit;
      },
      act: (cubit) => cubit.getJadwalToday(),
      expect: () => [
        JadwalLoading(),
        JadwalError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );
  });

  group('JadwalCubit getSelectedDetail', () {
    final tJadwal = JadwalPasienModel();

    blocTest<JadwalCubit, JadwalState>(
      'emits [JadwalLoading, JadwalLoaded] when getSelectedDetail is successful',
      build: () {
        when(() => mockRepository.getAppointment(
              id: any(named: 'id'),
            )).thenAnswer((_) async => tJadwal);
        return jadwalCubit;
      },
      act: (cubit) => cubit.getSelectedDetail('1'),
      expect: () => [
        JadwalLoading(),
        JadwalLoaded(selectedAppointment: tJadwal),
      ],
    );

    blocTest<JadwalCubit, JadwalState>(
      'emits [JadwalLoading, JadwalError] when getSelectedDetail fails',
      build: () {
        when(() => mockRepository.getAppointment(
              id: any(named: 'id'),
            )).thenThrow(Exception());
        return jadwalCubit;
      },
      act: (cubit) => cubit.getSelectedDetail('1'),
      expect: () => [
        JadwalLoading(),
        JadwalError(message: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );
  });
}
