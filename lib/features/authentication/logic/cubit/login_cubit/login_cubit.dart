import 'package:bloc/bloc.dart';
import '../../../data/models/email.dart';
import '../../../data/models/password.dart';
import '../../../data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._userRepository) : super(const LoginState());

  final UserRepository _userRepository;

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(state.copyWith(
      email: email,
      status: Formz.validate([email, state.password])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    ));
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    emit(state.copyWith(
      password: password,
      status: Formz.validate([state.email, password])
          ? FormzSubmissionStatus.success
          : FormzSubmissionStatus.failure,
    ));
  }

  Future<void> logInWithCredentials() async {
    if (!state.status.isFailure) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _userRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.message));
    }
  }
}
