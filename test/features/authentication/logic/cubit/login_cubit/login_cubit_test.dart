import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/email.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/cubit/login_cubit/login_cubit.dart';
import 'package:eimunisasi_nakes/features/authentication/data/repositories/user_repository.dart';
import 'package:formz/formz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockUserRepository extends Mock implements UserRepository {}
class MockAuthResponse extends Mock implements AuthResponse {}

void main() {
  late LoginCubit loginCubit;
  late MockUserRepository mockUserRepository;
  late MockAuthResponse mockAuthResponse;

  setUp(() {
    mockUserRepository = MockUserRepository();
    mockAuthResponse = MockAuthResponse();
    loginCubit = LoginCubit(mockUserRepository);
  });

  blocTest<LoginCubit, LoginState>(
    'emailChanged updates email and status to failure if fails',
    build: () => loginCubit,
    act: (cubit) => cubit.emailChanged('test@example.com'),
    expect: () => [
      LoginState(
        email: Email.dirty('test@example.com'),
        status: FormzSubmissionStatus.failure,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'passwordChanged updates password and status to failure if fails',
    build: () => loginCubit,
    act: (cubit) => cubit.passwordChanged('password123'),
    expect: () => [
      LoginState(
        password: Password.dirty('password123'),
        status: FormzSubmissionStatus.failure,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'passwordChanged and emailChanged updates password and email and status to success if valid password and email',
    build: () => loginCubit,
    act: (cubit) {
      cubit.passwordChanged('password123');
      cubit.emailChanged('test@example.com');
    },
    expect: () => [
      LoginState(
        password: Password.dirty('password123'),
        status: FormzSubmissionStatus.failure,
      ),
      LoginState(
        email: Email.dirty('test@example.com'),
        password: Password.dirty('password123'),
        status: FormzSubmissionStatus.success,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'logInWithCredentials emits inProgress and success when login succeeds',
    build: () => loginCubit,
    setUp: () {
      when(() => mockUserRepository.logInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer(
        (_) async => mockAuthResponse,
      );
    },
    seed: () => LoginState(
      email: Email.dirty('test@example.com'),
      password: Password.dirty('password123'),
      status: FormzSubmissionStatus.success,
    ),
    act: (cubit) {
      return cubit.logInWithCredentials();
    },
    expect: () => [
      LoginState(
        email: Email.dirty('test@example.com'),
        password: Password.dirty('password123'),
        status: FormzSubmissionStatus.inProgress,
      ),
      LoginState(
        email: Email.dirty('test@example.com'),
        password: Password.dirty('password123'),
        status: FormzSubmissionStatus.success,
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'logInWithCredentials emits inProgress and failure when login fails',
    build: () => loginCubit,
    setUp: () {
      when(() => mockUserRepository.logInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception());
    },
    seed: () => LoginState(
      email: Email.dirty('test@example.com'),
      password: Password.dirty('password123'),
      status: FormzSubmissionStatus.success,
    ),
    act: (cubit) {
      return cubit.logInWithCredentials();
    },
    expect: () => [
      LoginState(
        email: Email.dirty('test@example.com'),
        password: Password.dirty('password123'),
        status: FormzSubmissionStatus.inProgress,
      ),
      LoginState(
        email: Email.dirty('test@example.com'),
        password: Password.dirty('password123'),
        status: FormzSubmissionStatus.failure,
        errorMessage: 'Mohon maaf, terjadi kesalahan. Silahkan coba lagi.',
      ),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'logInWithSeribaseOauth emits inProgress and success when login succeeds',
    build: () => loginCubit,
    setUp: () {
      when(() => mockUserRepository.logInWithSeribaseOauth()).thenAnswer(
        (_) async => true,
      );
    },
    act: (cubit) => cubit.logInWithSeribaseOauth(),
    expect: () => [
      LoginState(status: FormzSubmissionStatus.inProgress),
      LoginState(status: FormzSubmissionStatus.success),
    ],
  );

  blocTest<LoginCubit, LoginState>(
    'logInWithSeribaseOauth emits inProgress and failure when login fails',
    build: () => loginCubit,
    setUp: () {
      when(() => mockUserRepository.logInWithSeribaseOauth())
          .thenThrow(Exception());
    },
    act: (cubit) => cubit.logInWithSeribaseOauth(),
    expect: () => [
      LoginState(status: FormzSubmissionStatus.inProgress),
      LoginState(
        status: FormzSubmissionStatus.failure,
        errorMessage: 'Mohon maaf, terjadi kesalahan. Silahkan coba lagi.',
      ),
    ],
  );
}
