import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../../data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this._userRepository) : super(const SignUpState());

  final UserRepository _userRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([
        email,
        state.password,
      ])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([
        state.email,
        password,
      ])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    ));
  }

  Future<void> signUpFormSubmitted() async {
    if (!state.status.isSuccess) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final userResult = await _userRepository.signUpWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      final userModel = ProfileModel(
        id: userResult.user?.id,
        email: userResult.user?.email,
      );
      await _userRepository.insertUserToDatabase(
        user: userModel,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
