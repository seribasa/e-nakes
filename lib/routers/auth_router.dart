import 'package:eimunisasi_nakes/features/authentication/presentation/screens/auth/login_seribase_oauth_screen.dart';
import 'package:eimunisasi_nakes/routers/route_paths/auth_route_paths.dart';
import 'package:go_router/go_router.dart';

class AuthRouter {
  static List<RouteBase> routes = [
    GoRoute(
      path: AuthRoutePaths.loginWithSeribaseOauth.path,
      builder: (_, __) => const LoginSeribaseOauthScreen(),
    ),
  ];
}
