import 'package:eimunisasi_nakes/features/appointment/presentation/screens/wrapper_appointment_screen.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:go_router/go_router.dart';

import '../features/appointment/presentation/screens/appointment_history/appointment_detail_screen.dart';
import '../features/appointment/presentation/screens/appointment_history/appointment_screen.dart';
import 'models/route_model.dart';

class AppointmentRouter {
  static const RouteModel wrapperRoute = RouteModel(
    name: 'appointmentWrapper',
    path: 'appointment',
    parent: RootRoutePaths.dashboard,
  );

  static const RouteModel historiesRoute = RouteModel(
    name: 'appointmentHistories',
    path: 'histories',
    parent: wrapperRoute,
  );

  static const RouteModel historyDetailRoute = RouteModel(
    name: 'appointmentHistoryDetail',
    path: 'histories/:id',
    parent: wrapperRoute,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: wrapperRoute.name,
      path: wrapperRoute.path,
      builder: (_, __) => const WrapperAppointmentScreen(),
    ),
    GoRoute(
      name: historiesRoute.name,
      path: historiesRoute.path,
      builder: (_, __) => const RiwayatJanjiScreen(),
    ),
    GoRoute(
      name: historyDetailRoute.name,
      path: historyDetailRoute.path,
      builder: (_, state) {
        final id = state.pathParameters['id'] ?? '';
        return RiwayatJanjiDetailScreen(id: id);
      },
    ),
  ];
}
