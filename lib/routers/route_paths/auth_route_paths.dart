
import 'package:eimunisasi_nakes/routers/models/route_model.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';

class AuthRoutePaths {
  static const RouteModel passcode = RouteModel(
    name: 'passcode',
    path: 'passcode',
    parent: RootRoutePaths.authLocal,
  );

  static const RouteModel confirmPasscode = RouteModel(
    name: 'confirmPasscode',
    path: 'confirm-passcode',
    parent: RootRoutePaths.authLocal,
  );

  static const RouteModel loginWithSeribaseOauth = RouteModel(
    name: 'loginWithSeribaseOauth',
    path: 'login-with-seribase-oauth',
    parent: RootRoutePaths.auth,
  );
}
