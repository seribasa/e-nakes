part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  final FormzSubmissionStatus? updateAvatarStatus;
  const ProfileState({
    this.updateAvatarStatus,
  });

  ProfileState copyWith({
    FormzSubmissionStatus? updateAvatarStatus,
  }) {
    return ProfileState(
      updateAvatarStatus: updateAvatarStatus ?? this.updateAvatarStatus,
    );
  }

  @override
  List<Object?> get props => [
        updateAvatarStatus,
      ];
}
