import 'dart:io';
import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/features/authentication/data/repositories/user_repository.dart';
import 'package:eimunisasi_nakes/features/profile/presentation/logic/profile_bloc/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late ProfileBloc profileBloc;
  late MockUserRepository mockUserRepository;

  setUp(() {
    mockUserRepository = MockUserRepository();
    profileBloc = ProfileBloc(mockUserRepository);
  });

  tearDown(() {
    profileBloc.close();
  });

  group('ProfileBloc', () {
    final mockFile = File('test_image.jpg');
    const mockImageUrl = 'http://example.com/image.jpg';

    blocTest<ProfileBloc, ProfileState>(
      'emits [inProgress, success] when avatar change succeeds',
      build: () {
        when(() => mockUserRepository.uploadImage(mockFile))
            .thenAnswer((_) async => mockImageUrl);
        when(() => mockUserRepository.updateUserAvatar(mockImageUrl))
            .thenAnswer((_) async {});
        return profileBloc;
      },
      act: (bloc) => bloc.add(ChangeAvatar(mockFile)),
      expect: () => [
        ProfileState(updateAvatarStatus: FormzSubmissionStatus.inProgress),
        ProfileState(updateAvatarStatus: FormzSubmissionStatus.success),
      ],
    );

    blocTest<ProfileBloc, ProfileState>(
      'emits [inProgress, failure] when avatar change fails',
      build: () {
        when(() => mockUserRepository.uploadImage(mockFile))
            .thenThrow(Exception('Upload failed'));
        return profileBloc;
      },
      act: (bloc) => bloc.add(ChangeAvatar(mockFile)),
      expect: () => [
        ProfileState(updateAvatarStatus: FormzSubmissionStatus.inProgress),
        ProfileState(updateAvatarStatus: FormzSubmissionStatus.failure),
      ],
    );
  });
}
