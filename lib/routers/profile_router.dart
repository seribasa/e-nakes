import 'package:go_router/go_router.dart';
import '../features/profile/presentation/screens/profile_nakes_screen.dart';
import 'models/route_model.dart';
import 'route_paths/root_route_paths.dart';

class ProfileRouter {
  static const RouteModel showProfileRoute = RouteModel(
    name: 'showProfile',
    path: 'show-profile',
    parent: RootRoutePaths.profile,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: showProfileRoute.name,
      path: showProfileRoute.path,
      builder: (_, __) => const ProfileNakesScreen(),
    ),
  ];
}
