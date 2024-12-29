import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:go_router/go_router.dart';

import '../features/klinik/presentation/screens/wrapper_klinik.dart';
import 'models/route_model.dart';

class ClinicRouter {
  static const RouteModel wrapperRoute = RouteModel(
    name: 'clinicWrapper',
    path: 'clinic',
    parent: RootRoutePaths.dashboard,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: wrapperRoute.name,
      path: wrapperRoute.path,
      builder: (_, __) => const WrapperKlinik(),
    ),
  ];
}
