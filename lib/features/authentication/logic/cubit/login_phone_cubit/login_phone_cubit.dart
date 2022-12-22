import 'package:bloc/bloc.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import '../../../data/models/country_code.dart';
import '../../../data/models/otp.dart';
import '../../../data/models/phone.dart';
import '../../../data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';

part 'login_phone_state.dart';

class LoginPhoneCubit extends Cubit<LoginPhoneState> {
  LoginPhoneCubit(this._userRepository) : super(const LoginPhoneState());

  final UserRepository _userRepository;

  void phoneChanged(String value) {
    final phone = Phone.dirty(value);
    emit(state.copyWith(
      phone: phone,
      status: Formz.validate([phone, state.otpCode, state.countryCode]),
    ));
  }

  void otpCodeChanged(String value) {
    final otpCode = OTP.dirty(value);
    emit(state.copyWith(
      otpCode: otpCode,
      status: Formz.validate([state.phone, otpCode, state.countryCode]),
    ));
  }

  void countryCodeChanged(String value) {
    final countryCode = CountryCode.dirty(value);
    emit(state.copyWith(
      countryCode: countryCode,
      status: Formz.validate([state.phone, state.otpCode, countryCode]),
    ));
  }

  void verIdChanged(String value) {
    emit(state.copyWith(verId: value, status: FormzStatus.pure));
  }

  Future<void> sendOTPCode() async {
    String phoneNumber = state.phone.value;
    if (!state.phone.valid) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    if (phoneNumber.startsWith('0')) {
      // remove the first character
      phoneNumber = phoneNumber.substring(1);
    }
    try {
      await _userRepository.verifyPhoneNumber(
        phone: state.countryCode.value + phoneNumber,
        codeSent: (String verId, int? token) {
          emit(state.copyWith(status: FormzStatus.pure, verId: verId));
        },
        verificationFailed: (FirebaseAuthException e) {
          emit(state.copyWith(
              status: FormzStatus.submissionFailure, errorMessage: e.message));
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          final userResult = await _userRepository.signInWithCredential(
            credential,
          );
          final userModel = UserData(
            id: userResult.user?.uid,
            phone: userResult.user?.phoneNumber,
          );
          final isUserExist = await _userRepository.isUserExist();
          if (!isUserExist) {
            await _userRepository.insertUserToDatabase(
              user: userModel,
            );
          }
          emit(state.copyWith(status: FormzStatus.submissionSuccess));
        },
      );
    } catch (_) {
      emit(state.copyWith(
        status: FormzStatus.submissionFailure,
      ));
    }
  }

  Future<void> logInWithOTP({required String verId}) async {
    if (state.otpCode.invalid) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      final userResult = await _userRepository.signUpWithOTP(
        state.otpCode.value,
        verId,
      );

      final userModel = UserData(
        id: userResult.user?.uid,
        phone: userResult.user?.phoneNumber,
      );
      final isUserExist = await _userRepository.isUserExist();
      if (!isUserExist) {
        await _userRepository.insertUserToDatabase(
          user: userModel,
        );
      }
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, errorMessage: e.message));
    }
  }
}
