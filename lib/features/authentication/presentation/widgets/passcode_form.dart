import 'package:eimunisasi_nakes/routers/route_paths/auth_route_paths.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:go_router/go_router.dart';

import '../../logic/cubit/local_auth_cubit/local_auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PasscodeForm extends StatelessWidget {
  const PasscodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _TextHeader(),
            const SizedBox(height: 16),
            _PasscodeInput(),
            const SizedBox(height: 16),
            const _NextButton(),
          ],
        ),
      ),
    );
  }
}

class _TextHeader extends StatelessWidget {
  const _TextHeader();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalAuthCubit, LocalAuthState>(
      builder: (context, state) {
        return Text(state.savedPasscode.isNotValid
            ? "Silahkan Atur PIN Anda!"
            : "Silahkan Masukkan PIN Anda!");
      },
    );
  }
}

class _PasscodeInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalAuthCubit, LocalAuthState>(
      builder: (context, state) {
        return Column(
          children: [
            TextField(
              maxLength: 4,
              key: const Key('passcodeForm_passcodeInput_textField'),
              onChanged: (value) =>
                  context.read<LocalAuthCubit>().passcodeChanged(value),
              keyboardType: TextInputType.number,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'PIN',
                helperText: 'Masukkan 4-digit PIN',
                errorText: state.passcode.isNotValid ? 'Format salah!' : null,
              ),
            ),
            const SizedBox(height: 16),
            state.savedPasscode.isNotValid
                ? const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "*Ini berguna sebagai kunci keamanan tambahan.",
                      style: TextStyle(fontSize: 12, color: Colors.red),
                    ))
                : Container(),
          ],
        );
      },
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocalAuthCubit, LocalAuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSuccess) {
          context.goNamed(RootRoutePaths.dashboard.name);
        } else if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Gagal'),
              ),
            );
        }
      },
      child: BlocBuilder<LocalAuthCubit, LocalAuthState>(
        builder: (context, state) {
          if (state.status.isInProgress) {
            return const CircularProgressIndicator();
          }

          return ElevatedButton(
            key: const Key('passcodeForm_next_raisedButton'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              if (state.savedPasscode.isNotValid) {
                if (state.passcode.isValid) {
                  context.pushNamed(
                    AuthRoutePaths.confirmPasscode.name,
                    extra: context.read<LocalAuthCubit>(),
                  );
                }
              } else {
                context
                    .read<LocalAuthCubit>()
                    .checkPasscode(state.passcode.value);
              }
            },
            child: const Text('Selanjutnya'),
          );
        },
      ),
    );
  }
}
