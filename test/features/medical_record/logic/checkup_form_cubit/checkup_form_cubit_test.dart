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
  late FormPemeriksaanVaksinasiCubit cubit;
  late MockCheckupRepository mockRepository;

  setUp(() {
    mockRepository = MockCheckupRepository();
    cubit = FormPemeriksaanVaksinasiCubit(mockRepository);
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
      expect(cubit.state, FormPemeriksaanVaksinasiState());
    });

    blocTest<FormPemeriksaanVaksinasiCubit, FormPemeriksaanVaksinasiState>(
      'providePasienData emits correct state',
      build: () => cubit,
      act: (cubit) => cubit.providePasienData('123', '456', patientModel),
      expect: () => [
        FormPemeriksaanVaksinasiState(
          idPasien: '123',
          idOrangTuaPasien: '456',
          pasien: patientModel,
        ),
      ],
    );

    blocTest<FormPemeriksaanVaksinasiCubit, FormPemeriksaanVaksinasiState>(
      'changeBeratBadan emits correct state',
      build: () => cubit,
      act: (cubit) => cubit.changeBeratBadan(50),
      expect: () => [
        FormPemeriksaanVaksinasiState(beratBadan: 50),
      ],
    );

    blocTest<FormPemeriksaanVaksinasiCubit, FormPemeriksaanVaksinasiState>(
      'savePemeriksaanVaksinasi success emits correct states',
      build: () {
        when(() => mockRepository.setCheckup(
            checkupModel: any(named: 'checkupModel'))).thenAnswer(
          (_) async => CheckupModel(),
        );
        return cubit;
      },
      act: (cubit) {
        cubit.changeBeratBadan(50);
        cubit.changeTinggiBadan(160);
        cubit.changeLingkarKepala(35);
        return cubit.savePemeriksaanVaksinasi();
      },
      expect: () => [
        FormPemeriksaanVaksinasiState(
          beratBadan: 50,
        ),
        FormPemeriksaanVaksinasiState(
          beratBadan: 50,
          tinggiBadan: 160,
        ),
        FormPemeriksaanVaksinasiState(
          beratBadan: 50,
          tinggiBadan: 160,
          lingkarKepala: 35,
        ),
        FormPemeriksaanVaksinasiState(
          beratBadan: 50,
          tinggiBadan: 160,
          lingkarKepala: 35,
          status: FormzSubmissionStatus.inProgress,
        ),
        FormPemeriksaanVaksinasiState(
          beratBadan: 50,
          tinggiBadan: 160,
          lingkarKepala: 35,
          status: FormzSubmissionStatus.success,
        ),
      ],
    );
  });
}
