import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/cubit/local_auth_cubit/local_auth_cubit.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/passcode.dart';
import 'package:formz/formz.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late LocalAuthCubit localAuthCubit;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localAuthCubit = LocalAuthCubit(
      mockSharedPreferences,
    );
  });

  blocTest<LocalAuthCubit, LocalAuthState>(
    'passcodeChanged updates passcode correctly',
    build: () => localAuthCubit,
    act: (cubit) => cubit.passcodeChanged('1234'),
    expect: () => [
      LocalAuthState(passcode: Passcode.dirty('1234')),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'passcodeConfirmChanged updates confirmPasscode correctly',
    build: () => localAuthCubit,
    act: (cubit) => cubit.passcodeConfirmChanged('1234'),
    expect: () => [
      LocalAuthState(confirmPasscode: '1234'),
    ],
  );

  // blocTest<LocalAuthCubit, LocalAuthState>(
  //   'setPasscode saves passcode and emits success',
  //   build: () => localAuthCubit,
  //   setUp: () {
  //     when(() => mockSharedPreferences.setInt('passCode', 1234))
  //         .thenAnswer((_) async => true);
  //   },
  //   act: (cubit) => cubit.setPasscode(1234),
  //   expect: () => [
  //     LocalAuthState(statusSetPasscode: FormzSubmissionStatus.inProgress),
  //     LocalAuthState(
  //       passcode: Passcode.dirty('1234'),
  //       statusSetPasscode: FormzSubmissionStatus.success,
  //     ),
  //   ],
  // );

  // blocTest<LocalAuthCubit, LocalAuthState>(
  //   'setPasscode saves passcode and emits failure',
  //   build: () => localAuthCubit,
  //   setUp: () {
  //     when(() => mockSharedPreferences.setInt('passCode', 1234))
  //         .thenThrow(Exception('Error'));
  //   },
  //   act: (cubit) => cubit.setPasscode(1234),
  //   expect: () => [
  //     LocalAuthState(statusSetPasscode: FormzSubmissionStatus.inProgress),
  //     LocalAuthState(
  //       passcode: Passcode.dirty('1234'),
  //       errorMessage: 'Error',
  //       statusSetPasscode: FormzSubmissionStatus.failure,
  //     ),
  //   ],
  // );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'getPasscode retrieves passcode and emits success',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.getInt('passCode')).thenReturn(1234);
    },
    act: (cubit) => cubit.getPasscode(),
    expect: () => [
      LocalAuthState(statusGetPasscode: FormzSubmissionStatus.inProgress),
      LocalAuthState(
        savedPasscode: Passcode.dirty('1234'),
        statusGetPasscode: FormzSubmissionStatus.success,
      ),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'getPasscode retrieves passcode and emits failure',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.getInt('passCode'))
          .thenThrow(Exception('Error'));
    },
    act: (cubit) => cubit.getPasscode(),
    expect: () => [
      LocalAuthState(statusGetPasscode: FormzSubmissionStatus.inProgress),
      LocalAuthState(
        savedPasscode: Passcode.dirty('1234'),
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
        statusGetPasscode: FormzSubmissionStatus.failure,
      ),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'checkPasscode emits error if passcode is not set',
    build: () => localAuthCubit,
    act: (cubit) => cubit.checkPasscode(''),
    expect: () => [
      LocalAuthState(errorMessage: 'Silahkan isi PIN'),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'checkPasscode emits success if passcode matches',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.getInt('passCode')).thenReturn(1234);
    },
    act: (cubit) => cubit.checkPasscode('1234'),
    expect: () => [
      LocalAuthState(status: FormzSubmissionStatus.inProgress),
      LocalAuthState(status: FormzSubmissionStatus.success),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'checkPasscode emits failure if passcode does not match',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.getInt('passCode')).thenReturn(1234);
    },
    act: (cubit) => cubit.checkPasscode('4321'),
    expect: () => [
      LocalAuthState(status: FormzSubmissionStatus.inProgress),
      LocalAuthState(
        errorMessage: 'Password Salah',
        status: FormzSubmissionStatus.failure,
      ),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'checkPasscode emits failure if getInt throws',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.getInt('passCode'))
          .thenThrow(Exception('Error'));
    },
    act: (cubit) => cubit.checkPasscode('4321'),
    expect: () => [
      LocalAuthState(status: FormzSubmissionStatus.inProgress),
      LocalAuthState(
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
        status: FormzSubmissionStatus.failure,
      ),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'confirmPasscode emits success if passcodes match',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.setInt('passCode', 1234))
          .thenAnswer((_) async => true);
    },
    seed: () => LocalAuthState(
      passcode: Passcode.dirty('1234'),
      confirmPasscode: '1234',
    ),
    act: (cubit) {
      return cubit.confirmPasscode();
    },
    expect: () => [
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.inProgress,
      ),
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.inProgress,
        statusSetPasscode: FormzSubmissionStatus.inProgress,
      ),
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.inProgress,
        statusSetPasscode: FormzSubmissionStatus.success,
      ),
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.success,
        statusSetPasscode: FormzSubmissionStatus.success,
      ),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'confirmPasscode emits failure if passcodes do not match',
    build: () => localAuthCubit,
    seed: () => LocalAuthState(
      passcode: Passcode.dirty('1234'),
      confirmPasscode: '4321',
    ),
    act: (cubit) {
      return cubit.confirmPasscode();
    },
    expect: () => [
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '4321',
        status: FormzSubmissionStatus.inProgress,
      ),
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '4321',
        status: FormzSubmissionStatus.failure,
        errorMessage: 'Passcode Salah',
      ),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'confirmPasscode emits failure if _setPasscode rethrow',
    build: () => localAuthCubit,
    seed: () => LocalAuthState(
      passcode: Passcode.dirty('1234'),
      confirmPasscode: '1234',
    ),
    setUp: () {
      when(() => mockSharedPreferences.setInt('passCode', 1234))
          .thenThrow(Exception('Error'));
    },
    act: (cubit) {
      return cubit.confirmPasscode();
    },
    expect: () => [
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.inProgress,
      ),
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.inProgress,
        statusSetPasscode: FormzSubmissionStatus.inProgress,
      ),
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.inProgress,
        statusSetPasscode: FormzSubmissionStatus.failure,
      ),
      LocalAuthState(
        passcode: Passcode.dirty('1234'),
        confirmPasscode: '1234',
        status: FormzSubmissionStatus.failure,
        statusSetPasscode: FormzSubmissionStatus.failure,
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
      ),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'destroyPasscode removes passcode and emits success',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.remove('passCode'))
          .thenAnswer((_) async => true);
    },
    act: (cubit) => cubit.destroyPasscode(),
    expect: () => [
      LocalAuthState(status: FormzSubmissionStatus.inProgress),
      LocalAuthState(status: FormzSubmissionStatus.success),
    ],
  );

  blocTest<LocalAuthCubit, LocalAuthState>(
    'destroyPasscode removes passcode and emits failure',
    build: () => localAuthCubit,
    setUp: () {
      when(() => mockSharedPreferences.remove('passCode'))
          .thenThrow(Exception('Error'));
    },
    act: (cubit) => cubit.destroyPasscode(),
    expect: () => [
      LocalAuthState(status: FormzSubmissionStatus.inProgress),
      LocalAuthState(
        status: FormzSubmissionStatus.failure,
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
      ),
    ],
  );
}
