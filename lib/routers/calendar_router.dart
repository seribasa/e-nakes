import 'package:eimunisasi_nakes/features/calendar/logic/form_calendar_activity/form_calendar_activity_cubit.dart';
import 'package:eimunisasi_nakes/features/calendar/presentation/screens/add_event_calendar_screen.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/calendar/presentation/screens/calendar_screen.dart';
import '../features/calendar/presentation/screens/update_event_calendar_screen.dart';
import 'models/route_model.dart';

class CalendarRouter {
  static const RouteModel calendarRoute = RouteModel(
    name: 'calendar',
    path: 'calendar',
    parent: RootRoutePaths.dashboard,
  );

  static const RouteModel addCalendarRoute = RouteModel(
    name: 'addCalendar',
    path: 'add',
    parent: calendarRoute,
  );

  static const RouteModel updateCalendarRoute = RouteModel(
    name: 'updateCalendar',
    path: 'update',
    parent: calendarRoute,
  );

  static List<RouteBase> routes = [
    GoRoute(
        name: calendarRoute.name,
        path: calendarRoute.path,
        builder: (_, __) => const CalendarScreen(),
        routes: [
          GoRoute(
            path: addCalendarRoute.path,
            name: addCalendarRoute.name,
            builder: (_, state) {
              return BlocProvider.value(
                value: state.extra as FormCalendarActivityCubit,
                child: AddEventCalendarScreen(),
              );
            },
          ),
          GoRoute(
            path: updateCalendarRoute.path,
            name: updateCalendarRoute.name,
            builder: (_, state) {
              final extra = state.extra as UpdateEventCalendarScreenExtra;
              return BlocProvider.value(
                value: extra.formCalendarActivityCubit,
                child: UpdateEventCalendarScreen(
                  calendarModel: extra.calendarModel,
                ),
              );
            },
          )
        ]),
  ];
}
