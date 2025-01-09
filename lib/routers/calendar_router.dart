import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:go_router/go_router.dart';
import '../features/calendar/presentation/screens/calendar_screen.dart';
import 'models/route_model.dart';

class CalendarRouter {
  static const RouteModel calendarRoute = RouteModel(
    name: 'calendar',
    path: 'calendar',
    parent: RootRoutePaths.dashboard,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: calendarRoute.name,
      path: calendarRoute.path,
      builder: (_, __) => const CalendarScreen(),
    ),
  ];
}
