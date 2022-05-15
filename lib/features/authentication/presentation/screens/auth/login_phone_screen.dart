import '../../../data/repositories/user_repository.dart';
import '../../../logic/cubit/login_phone_cubit/login_phone_cubit.dart';
import '../../widgets/login_phone_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';

class LoginPhoneScreen extends StatelessWidget {
  const LoginPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: BlocProvider(
            create: (_) => LoginPhoneCubit(context.read<UserRepository>()),
            child: const LoginPhoneForm(),
          ),
        ),
      ),
    );
  }
}
