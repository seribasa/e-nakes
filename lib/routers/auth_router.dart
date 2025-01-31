import 'package:eimunisasi_nakes/features/authentication/presentation/screens/auth/login_seribase_oauth_screen.dart';
import 'package:eimunisasi_nakes/routers/route_paths/auth_route_paths.dart';
import 'package:go_router/go_router.dart';

import '../features/profile/presentation/screens/detail_profile_screen.dart';
import '../features/profile/presentation/screens/profile_nakes_screen.dart';
import 'models/route_model.dart';
import 'route_paths/root_route_paths.dart';

class AuthRouter {
  static const profileRoute = RouteModel(
    name: 'authProfile',
    path: 'profile',
    parent: RootRoutePaths.auth,
  );

  static const profileViewRoute = RouteModel(
    name: 'authProfileView',
    path: 'view',
    parent: profileRoute,
  );

  static List<RouteBase> routes = [
    GoRoute(
      path: AuthRoutePaths.loginWithSeribaseOauth.path,
      builder: (_, __) => const LoginSeribaseOauthScreen(),
      routes: [
        GoRoute(
          name: profileRoute.name,
          path: profileRoute.path,
          builder: (_, __) => const DetailProfileScreen(),
          routes: [
            GoRoute(
              name: profileViewRoute.name,
              path: profileViewRoute.path,
              builder: (_, __) => const ProfileNakesScreen(),
            ),
          ],
        ),
      ],
    ),
  ];
}
