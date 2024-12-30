import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/checkup_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/models/patient_model.dart';
import 'package:eimunisasi_nakes/features/medical_record/data/repositories/checkup_repository.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_form_cubit/checkup_form_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockCheckupRepository extends Mock implements CheckupRepository {}

void main() {
  late CheckupFormCubit cubit;
  late MockCheckupRepository mockRepository;

  setUp(() {
    mockRepository = MockCheckupRepository();
    cubit = CheckupFormCubit(mockRepository);
  });

  setUpAll(() {
    registerFallbackValue(CheckupModel());
  });

  tearDown(() {
    cubit.close();
  });

  group('FormPemeriksaanVaksinasiCubit', () {
    final patientModel = PatientModel();

    test('initial state should be empty', () {
      expect(cubit.state, CheckupFormState());
    });

    blocTest<CheckupFormCubit, CheckupFormState>(
      'providePasienData emits correct state',
      build: () => cubit,
      act: (cubit) => cubit.selectedPatient(patientModel),
      expect: () => [
        CheckupFormState(
          patient: patientModel,
        ),
      ],
    );

    blocTest<CheckupFormCubit, CheckupFormState>(
      'changeBeratBadan emits correct state',
      build: () => cubit,
      act: (cubit) => cubit.changeWeight(50),
      expect: () => [
        CheckupFormState(checkup: CheckupModel(weight: 50)),
      ],
    );

    blocTest<CheckupFormCubit, CheckupFormState>(
      'savePemeriksaanVaksinasi success emits correct states',
      build: () {
        when(() => mockRepository.setCheckup(
            checkupModel: any(named: 'checkupModel'))).thenAnswer(
          (_) async => CheckupModel(),
        );
        return cubit;
      },
      act: (cubit) {
        cubit.changeWeight(50);
        cubit.changeHeight(160);
        cubit.changeHeadCircumference(35);
        return cubit.submit();
      },
      expect: () => [
        CheckupFormState(
          checkup: CheckupModel(
            weight: 50,
          ),
        ),
        CheckupFormState(
          checkup: CheckupModel(
            weight: 50,
            height: 160,
          ),
        ),
        CheckupFormState(
          checkup: CheckupModel(
            weight: 50,
            height: 160,
            headCircumference: 35,
          ),
        ),
        CheckupFormState(
          checkup: CheckupModel(
            weight: 50,
            height: 160,
            headCircumference: 35,
          ),
          status: FormzSubmissionStatus.inProgress,
        ),
        CheckupFormState(
          checkup: CheckupModel(
            weight: 50,
            height: 160,
            headCircumference: 35,
          ),
          status: FormzSubmissionStatus.success,
        ),
      ],
    );
  });
}
