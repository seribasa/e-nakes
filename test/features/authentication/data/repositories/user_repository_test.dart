import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:eimunisasi_nakes/features/authentication/data/repositories/user_repository.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

import '../../../../mocks/url_launcher.mock.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}

class MockGoTrueClient extends Mock implements GoTrueClient {}

class MockSupabaseStorageClient extends Mock implements SupabaseStorageClient {}

class MockStorageFileApi extends Mock implements StorageFileApi {}

class MockAuthResponse extends Mock implements AuthResponse {}

class MockAuthState extends Mock implements AuthState {}

class MockUser extends Mock implements User {}

class MockOAuthResponse extends Mock implements OAuthResponse {}

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockGoTrueClient mockGoTrueClient;
  late MockSupabaseStorageClient mockSupabaseStorageClient;
  late UserRepository userRepository;
  late MockOAuthResponse mockOAuthResponse;
  late MockUser mockUser;

  setUp(() {
    mockSupabaseClient = MockSupabaseClient();
    mockGoTrueClient = MockGoTrueClient();
    mockSupabaseStorageClient = MockSupabaseStorageClient();
    mockOAuthResponse = MockOAuthResponse();
    mockUser = MockUser();
    userRepository = UserRepository(mockSupabaseClient);
    when(() => mockSupabaseClient.auth).thenReturn(mockGoTrueClient);
    when(() => mockSupabaseClient.storage)
        .thenReturn(mockSupabaseStorageClient);
  });

  setUpAll(() {
    registerFallbackValue(File(''));
    registerFallbackValue(FileOptions(cacheControl: '3600', upsert: true));
  });

  group('UserRepository', () {

    test('stream onAuthStateChange returns Stream<AuthState>', () {
      final mockAuthState = MockAuthState();
      when(() => mockGoTrueClient.onAuthStateChange)
          .thenAnswer((_) => Stream.fromIterable([mockAuthState]));

      final result = userRepository.onAuthStateChange;

      expect(result, emits(mockAuthState));
    });

    test('logInWithEmailAndPassword returns AuthResponse on success', () async {
      final mockAuthResponse = MockAuthResponse();
      when(() => mockGoTrueClient.signInWithPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockAuthResponse);

      final result = await userRepository.logInWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result, mockAuthResponse);
    });

    test('forgetEmailPassword completes without error', () async {
      when(() => mockGoTrueClient.resetPasswordForEmail(
            any(),
          )).thenAnswer((_) async => Future.value());

      await userRepository.forgetEmailPassword(email: 'test@example.com');
    });

    test('signUpWithEmailAndPassword returns AuthResponse on success',
        () async {
      final mockAuthResponse = MockAuthResponse();
      when(() => mockGoTrueClient.signUp(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockAuthResponse);

      final result = await userRepository.signUpWithEmailAndPassword(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result, mockAuthResponse);
    });

    test('signOut completes without error', () async {
      when(() => mockGoTrueClient.signOut())
          .thenAnswer((_) async => Future.value());

      await userRepository.signOut();
    });

    test('isSignedIn returns true if user is signed in', () async {
      when(() => mockGoTrueClient.currentUser).thenReturn(mockUser);

      final result = await userRepository.isSignedIn();

      expect(result, true);
    });

    group('logInWithSeribaseOauth', () {
      late MockSupabaseClient mockSupabase;
      setUp(() {
        mockSupabase = MockSupabaseClient();
        userRepository = UserRepository(
          mockSupabase,
        );
        final mock = setupMockUrlLauncher();
        UrlLauncherPlatform.instance = mock;

        when(() => mockOAuthResponse.provider)
            .thenReturn(OAuthProvider.keycloak);
        when(() => mockOAuthResponse.url).thenReturn('http://www.google.com');
        when(() => mockSupabase.auth).thenReturn(mockGoTrueClient);
      });

      test('logInWithSeribaseOauth success', () async {
        when(() => mockGoTrueClient.getOAuthSignInUrl(
              provider: OAuthProvider.keycloak,
              redirectTo: any(named: 'redirectTo'),
              scopes: any(named: 'scopes'),
              queryParams: any(named: 'queryParams'),
            )).thenAnswer((_) async => mockOAuthResponse);

        when(() => mockSupabase.auth).thenReturn(mockGoTrueClient);

        final result = await userRepository.logInWithSeribaseOauth();

        expect(result, true);
      });

      test(
          'logInWithSeribaseOauth throws an exception if signInWithOAuth throws',
          () async {
        when(() => mockGoTrueClient.getOAuthSignInUrl(
              provider: OAuthProvider.keycloak,
              redirectTo: any(named: 'redirectTo'),
              scopes: any(named: 'scopes'),
              queryParams: any(named: 'queryParams'),
            )).thenThrow(Exception('error'));

        when(() => mockSupabase.auth).thenReturn(mockGoTrueClient);

        final result = userRepository.logInWithSeribaseOauth();

        expect(result, throwsA(isA<Exception>()));
      });
    });
  });
}
