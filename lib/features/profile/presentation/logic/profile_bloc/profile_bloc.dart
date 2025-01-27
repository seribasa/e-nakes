import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:eimunisasi_nakes/features/authentication/data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository _userRepository;

  ProfileBloc(this._userRepository) : super(ProfileState()) {
    on<ChangeAvatar>(_onChangeAvatar);
  }

  void _onChangeAvatar(
    ChangeAvatar event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(
      updateAvatarStatus: FormzSubmissionStatus.inProgress,
    ));

    try {
      final url = await _userRepository.uploadImage(event.file!);
      await _userRepository.updateUserAvatar(url);
      emit(state.copyWith(
        updateAvatarStatus: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        updateAvatarStatus: FormzSubmissionStatus.failure,
      ));
    }
  }
}
