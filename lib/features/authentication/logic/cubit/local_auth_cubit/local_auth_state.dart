part of 'local_auth_cubit.dart';

class LocalAuthState extends Equatable {
  const LocalAuthState({
    this.passcode = const Passcode.pure(),
    this.savedPasscode = const Passcode.pure(),
    this.confirmPasscode = '',
    this.status = FormzSubmissionStatus.initial,
    this.statusGetPasscode = FormzSubmissionStatus.initial,
    this.statusSetPasscode = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  final Passcode savedPasscode;
  final Passcode passcode;
  final String confirmPasscode;
  final FormzSubmissionStatus status;
  final FormzSubmissionStatus statusGetPasscode;
  final FormzSubmissionStatus statusSetPasscode;
  final String? errorMessage;

  @override
  List<Object?> get props => [passcode, confirmPasscode, status, statusGetPasscode, statusSetPasscode, errorMessage];

  LocalAuthState copyWith({
    Passcode? savedPasscode,
    Passcode? passcode,
    String? confirmPasscode,
    FormzSubmissionStatus? status,
    FormzSubmissionStatus? statusGetPasscode,
    FormzSubmissionStatus? statusSetPasscode,
    String? errorMessage,
  }) {
    return LocalAuthState(
      savedPasscode: savedPasscode ?? this.savedPasscode,
      passcode: passcode ?? this.passcode,
      confirmPasscode: confirmPasscode ?? this.confirmPasscode,
      status: status ?? this.status,
      statusGetPasscode: statusGetPasscode ?? this.statusGetPasscode,
      statusSetPasscode: statusSetPasscode ?? this.statusSetPasscode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}