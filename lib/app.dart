import 'package:eimunisasi_nakes/injection.dart';
import 'package:eimunisasi_nakes/routers/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/themes/theme.dart';
import 'features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(
          create: (context) => getIt<AuthenticationBloc>()
            ..add(
              AppStarted(),
            ),
        ),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: themeData(isDarkMode: false),
      darkTheme: themeData(isDarkMode: true),
    );
  }
}
