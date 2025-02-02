import 'package:go_router/go_router.dart';

import '../../../../routers/route_paths/root_route_paths.dart';
import '../../logic/bloc/authentication_bloc/authentication_bloc.dart';
import '../screens/auth/reset_email_password.dart';

import '../../logic/cubit/login_cubit/login_cubit.dart';
import '../screens/auth/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginEmailForm extends StatelessWidget {
  const LoginEmailForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Otentikasi gagal!'),
              ),
            );
        } else if (state.status.isSuccess) {
          context.read<AuthenticationBloc>().add(LoggedIn());
          context.goNamed(RootRoutePaths.root.name);
        }
      },
      child: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Silahkan Login dengan Email Anda"),
            const SizedBox(height: 16),
            _EmailInput(),
            const SizedBox(height: 8),
            _PasswordInput(),
            const SizedBox(height: 8),
            _LoginButton(),
            const SizedBox(height: 4),
            _SignUpButton(),
            _ResetEmailPasswordButton(),
          ],
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextField(
          key: const Key('loginEmailForm_emailInput_textField'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: 'contoh: example@mail.com',
            errorText: state.email.isNotValid ? 'Format email salah!' : null,
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextField(
          key: const Key('loginEmailForm_passwordInput_textField'),
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText: state.password.isNotValid ? 'invalid password' : null,
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  key: const Key('loginForm_continue_raisedButton'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: state.status.isSuccess
                      ? () => context.read<LoginCubit>().logInWithCredentials()
                      : null,
                  child: const Text('Masuk'),
                ),
              );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      key: const Key('loginEmailForm_createAccount_flatButton'),
      onPressed: () => Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RegisterScreen())),
      child: Text(
        'Buat Akun',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}

class _ResetEmailPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      key: const Key('resetEmailPasswordForm_createAccount_flatButton'),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ResetEmailPasswordScreen())),
      child: Text(
        'Lupa Password? Klik Disini',
        style: TextStyle(color: theme.primaryColor),
      ),
    );
  }
}
