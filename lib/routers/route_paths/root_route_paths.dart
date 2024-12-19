import '../models/route_model.dart';

class RootRoutePaths {
  static const RouteModel root = RouteModel(
    name: 'root',
    path: '/',
  );
  static const RouteModel error = RouteModel(
    name: 'error',
    path: '/error',
  );
  static const RouteModel notFound = RouteModel(
    name: 'notFound',
    path: '/not-found',
  );
  static const RouteModel splash = RouteModel(
    name: 'splash',
    path: '/splash',
  );
  static const RouteModel onboarding = RouteModel(
    name: 'onboarding',
    path: '/onboarding',
  );
  static const RouteModel auth = RouteModel(
    name: 'auth',
    path: '/auth',
  );
  static const RouteModel authLocal = RouteModel(
    name: 'authLocal',
    path: '/auth-local',
  );
  static const RouteModel dashboard = RouteModel(
    name: 'dashboard',
    path: '/dashboard',
  );

}
