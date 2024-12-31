import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:go_router/go_router.dart';
import '../features/rekam_medis/presentation/screens/wrapper_rekam_medis.dart';
import 'models/route_model.dart';

class MedicalRecordRouter {
  static const RouteModel wrapperRoute = RouteModel(
    name: 'medicalRecordWrapper',
    path: 'medical-record',
    parent: RootRoutePaths.dashboard,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: wrapperRoute.name,
      path: wrapperRoute.path,
      builder: (_, __) => const WrapperRekamMedis(),
    ),
  ];
}
