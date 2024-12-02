import 'package:country_code_picker/country_code_picker.dart';
import '../../data/repositories/user_repository.dart';
import '../../logic/cubit/login_phone_cubit/login_phone_cubit.dart';
import '../screens/auth/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginPhoneForm extends StatelessWidget {
  const LoginPhoneForm({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginPhoneCubit, LoginPhoneState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        } else if (state.verId != null) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (_) => BlocProvider(
                      create: (_) =>
                          LoginPhoneCubit(context.read<UserRepository>())
                            ..phoneChanged(state.phone.value)
                            ..countryCodeChanged(state.countryCode.value)
                            ..verIdChanged(state.verId!),
                      child: const OTPScreen(),
                    )),
          );
        }
      },
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Selamat Datang',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const Text("Silahkan Login dengan Nomor Ponsel Anda"),
              const SizedBox(height: 16),
              _PhoneInput(),
              const SizedBox(height: 16),
              _LoginButton(),
              _LoginWithEmailButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhoneInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPhoneCubit, LoginPhoneState>(
      builder: (context, state) {
        return Row(
          children: [
            CountryCodePicker(
              onInit: (countryCode) => context
                  .read<LoginPhoneCubit>()
                  .countryCodeChanged(countryCode!.dialCode!),
              onChanged: (countryCode) => context
                  .read<LoginPhoneCubit>()
                  .countryCodeChanged(countryCode.dialCode!),
              initialSelection: 'ID',
              showCountryOnly: false,
              showOnlyCountryWhenClosed: false,
              alignLeft: false,
            ),
            Expanded(
              child: TextField(
                key: const Key('loginPhoneForm_phoneInput_textField'),
                onChanged: (phone) =>
                    context.read<LoginPhoneCubit>().phoneChanged(phone),
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Nomor Ponsel',
                  helperText: 'Contoh: 876543210',
                  errorText: state.phone.isNotValid
                      ? 'Format salah! Contoh: 876543210'
                      : null,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPhoneCubit, LoginPhoneState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('loginPhoneForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state.phone.isValid
                      ? () => context.read<LoginPhoneCubit>().sendOTPCode()
                      : null,
                  child: const Text('Masuk'),
                ),
              );
      },
    );
  }
}

class _LoginWithEmailButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginPhoneCubit, LoginPhoneState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            key: const Key('loginPhoneForm_continueEmail_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: state.status.isInProgress
                ? null
                : () => Navigator.pushNamed(context, '/loginEmail'),
            child: const Text('Masuk dengan Email'),
          ),
        );
      },
    );
  }
}
