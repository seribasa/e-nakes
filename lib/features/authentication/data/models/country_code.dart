import 'package:formz/formz.dart';

enum CountryCodeValidationError { invalid }

class CountryCode extends FormzInput<String, CountryCodeValidationError> {
  const CountryCode.pure() : super.pure('');

  const CountryCode.dirty([super.value = '']) : super.dirty();

  static final RegExp _otpRegExp = RegExp(r'^\d{2,3}$');

  @override
  CountryCodeValidationError? validator(String? value) {
    return _otpRegExp.hasMatch(value ?? '')
        ? null
        : CountryCodeValidationError.invalid;
  }
}
