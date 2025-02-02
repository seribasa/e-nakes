import 'package:eimunisasi_nakes/core/widgets/error.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/clinic/presentation/screens/clinic_profile_screen.dart';
import '../features/clinic/presentation/screens/clinic_wrapper.dart';
import '../features/clinic/presentation/screens/membership_screen.dart';
import 'models/route_model.dart';

class ClinicRouter {
  static const RouteModel wrapperRoute = RouteModel(
    name: 'clinicWrapper',
    path: 'clinic',
    parent: RootRoutePaths.dashboard,
  );

  static const RouteModel clinicProfileRoute = RouteModel(
    name: 'clinicProfile',
    path: 'profile/:id',
    parent: wrapperRoute,
  );

  static const RouteModel clinicMembershipRoute = RouteModel(
    name: 'clinicMembership',
    path: 'membership',
    parent: clinicProfileRoute,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: wrapperRoute.name,
      path: wrapperRoute.path,
      builder: (_, __) => const WrapperKlinik(),
      routes: [
        GoRoute(
          name: clinicProfileRoute.name,
          path: clinicProfileRoute.path,
          builder: (_, state) {
            final clinicId = state.pathParameters['id'];
            if (clinicId == null) {
              return Scaffold(
                body: ErrorContainer(
                  message: 'id diperlukan, silahkan coba lagi',
                ),
              );
            }
            return ClinicProfileScreen(id: clinicId);
          },
          routes: [
            GoRoute(
                name: clinicMembershipRoute.name,
                path: clinicMembershipRoute.path,
                builder: (_, state) {
                  final clinicId = state.pathParameters['id'];

                  if (clinicId == null) {
                    return Scaffold(
                      body: ErrorContainer(
                        message: 'id diperlukan, silahkan coba lagi',
                      ),
                    );
                  }
                  return ClinicMembershipScreen(clinicId: clinicId);
                }),
          ],
        ),
      ],
    ),
  ];
}
