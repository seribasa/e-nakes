import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app.dart';
import '../../features/authentication/data/repositories/user_repository.dart';
import '../../features/authentication/logic/cubit/local_auth_cubit/local_auth_cubit.dart';
import '../../features/authentication/logic/cubit/login_phone_cubit/login_phone_cubit.dart';
import '../../features/authentication/presentation/screens/auth/login_email_screen.dart';
import '../../features/authentication/presentation/screens/auth/login_phone_screen.dart';
import '../../features/authentication/presentation/screens/auth/otp_screen.dart';
import '../../features/authentication/presentation/screens/auth/register_screen.dart';
import '../../features/bottom_navbar/presentation/screens/bottom_navbar.dart';
import '../../features/authentication/presentation/screens/local_auth/confirm_passcode_screen.dart';

class AppRouter {
  // final LoginCubit _loginEmailCubit = LoginCubit(UserRepository());
  final LocalAuthCubit _localAuthCubit = LocalAuthCubit();
  final LoginPhoneCubit _loginPhoneCubit = LoginPhoneCubit(UserRepository());
  // final AuthenticationBloc _authCubit =
  //     AuthenticationBloc(userRepository: UserRepository());
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => App(
            userRepository: UserRepository(),
          ),
        );
      case '/home':
        return MaterialPageRoute(
          builder: (_) => const BottomNavbarWrapper(),
        );
      case '/loginPhone':
        return MaterialPageRoute(
          builder: (_) => const LoginPhoneScreen(),
        );
      case '/loginEmail':
        return MaterialPageRoute(
          builder: (_) => const LoginEmailScreen(),
        );
      case '/registerEmail':
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case '/otp':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _loginPhoneCubit,
            child: const OTPScreen(),
          ),
        );
      case '/confirmPasscode':
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _localAuthCubit,
            child: const ConfirmPasscodeScreen(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const AppView(),
        );
    }
  }

  void dispose() {
    _loginPhoneCubit.close();
  }
}
