import 'package:eimunisasi_nakes/core/widgets/error.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/profile/presentation/screens/detail_profile_screen.dart';
import 'package:eimunisasi_nakes/routers/appointment_router.dart';
import 'package:eimunisasi_nakes/routers/calendar_router.dart';
import 'package:eimunisasi_nakes/routers/clinic_router.dart';
import 'package:eimunisasi_nakes/routers/medical_record_router.dart';
import 'package:eimunisasi_nakes/routers/profile_router.dart';
import 'package:eimunisasi_nakes/routers/route_paths/auth_route_paths.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/common/loading.dart';
import '../features/authentication/presentation/screens/auth/login_seribase_oauth_screen.dart';
import '../features/authentication/presentation/screens/local_auth/passcode_screen.dart';
import '../features/authentication/presentation/screens/splash/splash_screen.dart';
import '../features/bottom_navbar/presentation/screens/bottom_navbar.dart';
import 'auth_local_router.dart';
import 'auth_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: RootRoutePaths.root.name,
      path: RootRoutePaths.root.path,
      builder: (context, state) {
        final error = state.uri.queryParameters['error'];
        final errorCode = state.uri.queryParameters['error_code'];
        final errorDescription = state.uri.queryParameters['error_description'];

        if (error != null && errorCode != null && errorDescription != null) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error),
                ),
              );
            },
          );
        }

        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (BuildContext context, AuthenticationState state) {
            if (state is AuthenticationError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is Uninitialized) {
              return const SplashScreen();
            } else if (state is Loading) {
              return const LoadingScreen();
            } else if (state is Authenticated) {
              return const PasscodeScreen();
            } else if (state is Unauthenticated) {
              return const LoginSeribaseOauthScreen();
            } else if (state is AuthenticationError) {
              return Scaffold(
                body: ErrorContainer(
                  title: state.message,
                  message: 'Coba Lagi',
                  onRefresh: () {
                    context.read<AuthenticationBloc>().add(AppStarted());
                  },
                ),
              );
            }
            return Container();
          },
        );
      },
    ),
    GoRoute(
      name: RootRoutePaths.auth.name,
      path: RootRoutePaths.auth.path,
      routes: AuthRouter.routes,
      redirect: (_, state) {
        if (state.fullPath == RootRoutePaths.auth.fullPath) {
          return AuthRoutePaths.loginWithSeribaseOauth.fullPath;
        }
        return null;
      },
    ),
    GoRoute(
      name: RootRoutePaths.authLocal.name,
      path: RootRoutePaths.authLocal.path,
      routes: AuthLocalRouter.routes,
      redirect: (_, state) {
        if (state.fullPath == RootRoutePaths.authLocal.fullPath) {
          return AuthRoutePaths.passcode.fullPath;
        }
        return null;
      },
    ),
    GoRoute(
      name: RootRoutePaths.dashboard.name,
      path: RootRoutePaths.dashboard.path,
      builder: (_, __) => BottomNavbarWrapper(),
      routes: [
        ...AppointmentRouter.routes,
        ...CalendarRouter.routes,
        ...ClinicRouter.routes,
        ...MedicalRecordRouter.routes,
      ],
    ),
    GoRoute(
      path: RootRoutePaths.profile.path,
      name: RootRoutePaths.profile.name,
      builder: (context, state) {
        return DetailProfileScreen();
      },
      routes: ProfileRouter.routes,
    ),
    GoRoute(
      name: RootRoutePaths.error.name,
      path: RootRoutePaths.error.path,
      builder: (context, state) {
        final title = state.uri.queryParameters['error'];
        final desc = state.uri.queryParameters['error_description'];

        return Scaffold(
          body: ErrorContainer(
            title: title,
            message: desc,
          ),
        );
      },
    ),
  ],
  errorBuilder: (context, state) {
    return Scaffold(
      body: ErrorContainer(
        title: 'Error',
        message: state.error.toString(),
      ),
    );
  },
);
