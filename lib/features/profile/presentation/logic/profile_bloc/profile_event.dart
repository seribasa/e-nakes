part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ChangeAvatar extends ProfileEvent {
  final File? file;

  const ChangeAvatar(this.file);
}
