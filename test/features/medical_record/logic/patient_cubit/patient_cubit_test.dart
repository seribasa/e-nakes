import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/patient_repository.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/patient_cubit/patient_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPasienRepository extends Mock implements PatientRepository {}

void main() {
  late PatientCubit pasienCubit;
  late MockPasienRepository mockRepository;

  setUp(() {
    mockRepository = MockPasienRepository();
    pasienCubit = PatientCubit(mockRepository);
  });

  tearDown(() {
    pasienCubit.close();
  });

  group('PasienCubit - getPasien', () {
    final tPagination = BasePagination<PatientModel>(
      data: [PatientModel()],
      metadata: MetadataPaginationModel(
        page: 1,
        perPage: 10,
        total: 1,
      ),
    );

    blocTest<PatientCubit, PatientState>(
      'emits [PasienLoading, PasienLoaded] when getPasien is successful',
      build: () {
        when(() => mockRepository.getPatients(page: 1, perPage: 10))
            .thenAnswer((_) async => tPagination);
        return pasienCubit;
      },
      act: (cubit) => cubit.getPasien(page: 1, perPage: 10),
      expect: () => [
        isA<PatientLoading>(),
        isA<PatientLoaded>(),
      ],
    );

    blocTest<PatientCubit, PatientState>(
      'emits [PasienLoading, PasienError] when getPasien fails',
      build: () {
        when(() => mockRepository.getPatients(page: 1, perPage: 10))
            .thenThrow(Exception('Error'));
        return pasienCubit;
      },
      act: (cubit) => cubit.getPasien(page: 1, perPage: 10),
      expect: () => [
        isA<PatientLoading>(),
        isA<PatientError>(),
      ],
    );

    blocTest<PatientCubit, PatientState>(
      'emits [PasienLoading, PasienLoaded] when getPasienBySearch is successful',
      build: () {
        when(() => mockRepository.getPatients(nik: 'search'))
            .thenAnswer((_) async => tPagination);
        return pasienCubit;
      },
      act: (cubit) => cubit.getPasienBySearch('search'),
      expect: () => [
        isA<PatientLoading>(),
        isA<PatientLoaded>(),
      ],
    );
  });

  group('PasienCubit - getPasienBySearch', () {
    final tPagination = BasePagination<PatientModel>(
      data: [PatientModel()],
      metadata: MetadataPaginationModel(
        page: 1,
        perPage: 10,
        total: 1,
      ),
    );

    blocTest<PatientCubit, PatientState>(
      'emits [PasienLoading, PasienLoaded] when getPasienBySearch is successful',
      build: () {
        when(() => mockRepository.getPatients(nik: 'search'))
            .thenAnswer((_) async => tPagination);
        return pasienCubit;
      },
      act: (cubit) => cubit.getPasienBySearch('search'),
      expect: () => [
        isA<PatientLoading>(),
        isA<PatientLoaded>(),
      ],
    );

    blocTest<PatientCubit, PatientState>(
      'emits [PasienLoading, PasienError] when getPasienBySearch fails',
      build: () {
        when(() => mockRepository.getPatients(nik: 'search'))
            .thenThrow(Exception('Error'));
        return pasienCubit;
      },
      act: (cubit) => cubit.getPasienBySearch('search'),
      expect: () => [
        isA<PatientLoading>(),
        isA<PatientError>(),
      ],
    );
  });
}
