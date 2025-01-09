part of 'checkup_form_cubit.dart';

class CheckupFormState extends Equatable {
  final FormzSubmissionStatus? status;
  final String? errorMessage;
  final CheckupModel checkup;
  final PatientModel? patient;
  const CheckupFormState({
    this.status = FormzSubmissionStatus.initial,
    this.errorMessage,
    this.checkup = const CheckupModel(),
    this.patient,
  });

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        checkup,
        patient,
      ];

  CheckupFormState copyWith({
    FormzSubmissionStatus? status,
    String? errorMessage,
    CheckupModel? checkup,
    PatientModel? patient,
  }) {
    return CheckupFormState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      checkup: checkup ?? this.checkup,
      patient: patient ?? this.patient,
    );
  }
}
