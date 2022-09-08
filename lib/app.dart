import 'package:eimunisasi_nakes/core/common/loading.dart';
import 'package:eimunisasi_nakes/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/authentication/data/repositories/user_repository.dart';
import 'features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'features/authentication/presentation/screens/auth/login_phone_screen.dart';
import 'features/authentication/presentation/screens/local_auth/passcode_screen.dart';
import 'features/authentication/presentation/screens/splash/splash_screen.dart';

class App extends StatelessWidget {
  const App({Key? key, required UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  final UserRepository _userRepository;
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _userRepository,
      child: BlocProvider(
        create: (context) => AuthenticationBloc(userRepository: _userRepository)
          ..add(AppStarted()),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final AppRouter _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _appRouter.onGenerateRoute,
        theme: ThemeData(fontFamily: 'Nunito'),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Uninitialized) {
              return const SplashScreen();
            } else if (state is Loading) {
              return const LoadingScreen();
            } else if (state is Authenticated) {
              return const PasscodeScreen();
            } else if (state is Unauthenticated) {
              return const LoginPhoneScreen();
            }
            return Container();
          },
        ));
  }
}
