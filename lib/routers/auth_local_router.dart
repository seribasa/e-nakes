import 'package:eimunisasi_nakes/routers/route_paths/auth_route_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/logic/cubit/local_auth_cubit/local_auth_cubit.dart';
import '../features/authentication/presentation/screens/local_auth/confirm_passcode_screen.dart';
import '../features/authentication/presentation/screens/local_auth/passcode_screen.dart';

class AuthLocalRouter {
  static List<RouteBase> routes = [
    GoRoute(
      name: AuthRoutePaths.passcode.name,
      path: AuthRoutePaths.passcode.path,
      builder: (_, __) => const PasscodeScreen(),
    ),
    GoRoute(
      name: AuthRoutePaths.confirmPasscode.name,
      path: AuthRoutePaths.confirmPasscode.path,
      builder: (_, state) {
        return BlocProvider.value(
          value: state.extra as LocalAuthCubit,
          child: const ConfirmPasscodeScreen(),
        );
      },
    ),
  ];
}
