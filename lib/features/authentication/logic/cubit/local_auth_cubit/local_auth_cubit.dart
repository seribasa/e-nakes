import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/models/passcode.dart';

part 'local_auth_state.dart';

@injectable
class LocalAuthCubit extends Cubit<LocalAuthState> {
  final SharedPreferences _sharedPreferences;

  LocalAuthCubit(
    this._sharedPreferences,
  ) : super(const LocalAuthState());

  void passcodeChanged(String value) {
    final code = Passcode.dirty(value);
    emit(state.copyWith(
      passcode: code,
    ));
  }

  void passcodeConfirmChanged(String value) {
    emit(
      state.copyWith(
        confirmPasscode: value,
      ),
    );
  }

  Future<void> _setPasscode(int passcode) async {
    // if (!state.status.isValidated) return;
    emit(state.copyWith(
      statusSetPasscode: FormzSubmissionStatus.inProgress,
    ));
    try {
      _sharedPreferences.setInt('passCode', passcode);
      final code = Passcode.dirty(passcode.toString());
      emit(state.copyWith(
        passcode: code,
        statusSetPasscode: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        statusSetPasscode: FormzSubmissionStatus.failure,
      ));
      rethrow;
    }
  }

  void getPasscode() async {
    emit(state.copyWith(
      statusGetPasscode: FormzSubmissionStatus.inProgress,
    ));
    try {
      int? passcode = _sharedPreferences.getInt('passCode');
      debugPrint("**************$passcode");
      final code = Passcode.dirty(passcode.toString());
      emit(
        state.copyWith(
          savedPasscode: code,
          statusGetPasscode: FormzSubmissionStatus.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
        statusGetPasscode: FormzSubmissionStatus.failure,
      ));
    }
  }

  void checkPasscode(String passcode) async {
    if (passcode.isEmpty) {
      return emit(state.copyWith(
        errorMessage: 'Silahkan isi PIN',
      ));
    }
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      int? savedPasscode = _sharedPreferences.getInt('passCode');
      debugPrint("**************$savedPasscode");
      if (savedPasscode == int.parse(passcode)) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: "Password Salah",
          status: FormzSubmissionStatus.failure,
        ));
      }
    } catch (e) {
      log('Error Passcode: $e');
      emit(state.copyWith(
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
        status: FormzSubmissionStatus.failure,
      ));
    }
  }

  void confirmPasscode() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      final String passcode = state.passcode.value;
      final String confirmPasscode = state.confirmPasscode;
      if (passcode == confirmPasscode) {
        await _setPasscode(int.parse(passcode));
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
        ));
      } else {
        emit(state.copyWith(
          errorMessage: "Passcode Salah",
          status: FormzSubmissionStatus.failure,
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
        status: FormzSubmissionStatus.failure,
      ));
    }
  }

  void destroyPasscode() async {
    emit(state.copyWith(
      status: FormzSubmissionStatus.inProgress,
    ));
    try {
      _sharedPreferences.remove('passCode');
      emit(state.copyWith(
        status: FormzSubmissionStatus.success,
      ));
    } catch (e) {
      emit(state.copyWith(
        errorMessage: 'Terjadi kesalahan, silahkan coba lagi',
        status: FormzSubmissionStatus.failure,
      ));
    }
  }
}
