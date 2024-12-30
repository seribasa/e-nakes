import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/core/models/pagination_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/checkup_repository.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_cubit/checkup_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckupRepository extends Mock implements CheckupRepository {}

void main() {
  late CheckupCubit checkupCubit;
  late MockCheckupRepository mockRepository;

  setUp(() {
    mockRepository = MockCheckupRepository();
    checkupCubit = CheckupCubit(mockRepository);
  });

  tearDown(() {
    checkupCubit.close();
  });

  group('CheckupCubit', () {
    final tCheckups = [CheckupModel()]; // Add sample checkup model data
    const tPatientId = '123';
    final tPaginationCheckup = BasePagination(
      metadata: MetadataPaginationModel(
        perPage: 10,
        total: 1,
      ),
      data: tCheckups,
    );

    test('initial state should be CheckupInitial', () {
      expect(checkupCubit.state, equals(CheckupInitial()));
    });

    blocTest<CheckupCubit, CheckupState>(
      'emits [CheckupLoading, CheckupLoaded] when getCheckupByPatientId is successful',
      build: () {
        when(() => mockRepository.getCheckups(patientId: tPatientId))
            .thenAnswer((_) async => tPaginationCheckup);
        return checkupCubit;
      },
      act: (cubit) => cubit.getCheckupByPatientId(tPatientId),
      expect: () => [
        CheckupLoading(),
        CheckupLoaded(checkupResult: tPaginationCheckup),
      ],
    );

    blocTest<CheckupCubit, CheckupState>(
      'emits [CheckupLoading, CheckupError] when getCheckupByPatientId fails',
      build: () {
        when(() => mockRepository.getCheckups(patientId: tPatientId))
            .thenThrow(Exception('Error fetching checkups'));
        return checkupCubit;
      },
      act: (cubit) => cubit.getCheckupByPatientId(tPatientId),
      expect: () => [
        CheckupLoading(),
        CheckupError(message: 'Exception: Error fetching checkups'),
      ],
    );
  });
}
