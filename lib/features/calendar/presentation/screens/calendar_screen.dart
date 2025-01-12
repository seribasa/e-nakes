import 'dart:collection';

import 'package:eimunisasi_nakes/core/widgets/loading_dialog.dart';
import 'package:eimunisasi_nakes/features/calendar/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/calendar/logic/calendar/calendar_cubit.dart';
import 'package:eimunisasi_nakes/features/calendar/logic/form_calendar_activity/form_calendar_activity_cubit.dart';
import 'package:eimunisasi_nakes/features/calendar/presentation/screens/update_event_calendar_screen.dart';
import 'package:eimunisasi_nakes/injection.dart';
import 'package:eimunisasi_nakes/routers/calendar_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<CalendarCubit>()..getAllCalendar(),
        ),
        BlocProvider(
          create: (context) => getIt<FormCalendarActivityCubit>(),
        ),
      ],
      child: const _KalenderScaffold(),
    );
  }
}

class _KalenderScaffold extends StatefulWidget {
  const _KalenderScaffold();

  @override
  State<_KalenderScaffold> createState() => __KalenderScaffoldState();
}

class __KalenderScaffoldState extends State<_KalenderScaffold> {
  List<CalendarModel>? allEvents;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _onPageChangeDate = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<CalendarModel>>? _groupedEvents;
  List<CalendarModel> _selectedEvents = [];
  final kFirstDay = DateTime(DateTime.now().year - 5);
  final kLastDay = DateTime(DateTime.now().year + 5);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<CalendarModel>? allEvents) {
    _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    allEvents?.forEach((event) {
      DateTime date = DateTime.utc(event.doAt!.year, event.doAt!.month,
          event.doAt!.day, event.doAt!.hour, event.doAt!.minute);
      if (_groupedEvents?[date] == null) _groupedEvents?[date] = [];
      _groupedEvents?[date]?.add(event);
    });
  }

  List<dynamic> _getEventsfromDay(DateTime date) {
    return _groupedEvents?[date] ?? [];
  }

  CalendarBuilders calendarBuilder() {
    return CalendarBuilders(markerBuilder: (context, date, events) {
      if (events.isNotEmpty) {
        return Positioned(
          bottom: 1,
          child: Container(
            padding: const EdgeInsets.all(1.0),
            decoration:
                BoxDecoration(color: Colors.blue[900], shape: BoxShape.circle),
            constraints: const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
            child: Center(
              child: Text(
                "${events.length}",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }

  @override
  Widget build(BuildContext context) {
    final formCalendarActivityBloc = context.read<FormCalendarActivityCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.pushNamed(
                CalendarRouter.addCalendarRoute.name,
                extra: formCalendarActivityBloc,
              );
            },
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FormCalendarActivityCubit, FormCalendarActivityState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == FormzSubmissionStatus.success) {
                  context.read<CalendarCubit>().getAllCalendar();
                }
              }),
          BlocListener<CalendarCubit, CalendarState>(
              listener: (context, state) {
            if (state is CalendarDeleted) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Kegiatan berhasil dihapus"),
              ));
              context.read<CalendarCubit>().getAllCalendar();
            } else if (state is CalendarDeleting) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const LoadingDialog(
                  label: 'Menghapus...',
                ),
              );
            }
          }),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: SingleChildScrollView(
            child: BlocBuilder<CalendarCubit, CalendarState>(
                builder: (context, state) {
              if (state is CalendarFailure) {
                return const Center(child: Text('Gagal mengambil data'));
              } else if (state is CalendarLoaded) {
                allEvents = state.calendarPagination?.data;
                _groupEvents(allEvents);
              }
              DateTime? selectedDate = _selectedDay;
              _selectedEvents = _groupedEvents?[selectedDate] ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TableCalendar(
                    calendarBuilders: calendarBuilder(),
                    eventLoader: _getEventsfromDay,
                    headerStyle: const HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                    ),
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(
                        color: Colors.blue[200],
                        shape: BoxShape.circle,
                      ),
                    ),
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    calendarFormat: _calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(day, _selectedDay);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                      setState(() {
                        _onPageChangeDate = focusedDay;
                      });
                    },
                  ),
                  const SizedBox(height: 30.0),
                  (() {
                    if (_selectedDay != null) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Daftar aktivitas : ${DateFormat('dd MMMM yyyy').format(selectedDate ?? DateTime.now())}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _selectedDay = null;
                                  });
                                },
                                icon: const Icon(Icons.close_rounded),
                              )
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          ..._selectedEvents.map(
                            (event) => ListTile(
                              trailing: _PopUpMenuActivity(
                                event: event,
                              ),
                              isThreeLine: true,
                              title: Text(event.activity ?? ''),
                              subtitle: Text(
                                DateFormat('HH:mm').format(
                                  event.doAt ?? DateTime.now(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  }()),
                  SizedBox(
                    width: double.infinity,
                    child: selectedDate == null
                        ? _DataTableActivity(
                            events: allEvents,
                            onPageChangeDate: _onPageChangeDate,
                          )
                        : Container(),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _DataTableActivity extends StatelessWidget {
  final List<CalendarModel>? events;
  final DateTime? onPageChangeDate;

  const _DataTableActivity({
    required this.events,
    required this.onPageChangeDate,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CalendarCubit, CalendarState>(
      builder: (context, state) {
        return DataTable(
          headingRowHeight: 40,
          columnSpacing: 0,
          headingTextStyle: const TextStyle(
              fontFamily: 'Nunito',
              color: Colors.white,
              fontWeight: FontWeight.bold),
          dataTextStyle: const TextStyle(
            fontFamily: 'Nunito',
            color: Colors.black,
          ),
          headingRowColor: WidgetStateColor.resolveWith(
              (states) => Theme.of(context).primaryColor),
          columns: const <DataColumn>[
            DataColumn(
              label: Text(
                'Tanggal',
              ),
            ),
            DataColumn(
              label: Text(
                'Aktivitas',
              ),
            ),
          ],
          rows: () {
            if (state is CalendarLoading) {
              return [
                const DataRow(
                  cells: [
                    DataCell(Center(child: LinearProgressIndicator())),
                    DataCell(Center(child: LinearProgressIndicator())),
                  ],
                ),
              ];
            } else if (events != null && events!.isNotEmpty) {
              return events!
                  .where((e) =>
                      e.doAt!.month == onPageChangeDate!.month &&
                      e.doAt!.year == onPageChangeDate!.year)
                  .map(
                    (e) => DataRow(
                      cells: <DataCell>[
                        DataCell(
                          Text(
                            DateFormat('dd-MM-yyyy').format(e.doAt!).toString(),
                          ),
                        ),
                        DataCell(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  e.activity!,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              !e.readOnly!
                                  ? _PopUpMenuActivity(
                                      event: e,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                  .toList();
            } else {
              return [
                const DataRow(
                  cells: <DataCell>[
                    DataCell(
                      Text('-'),
                    ),
                    DataCell(
                      Text('Belum ada aktivitas'),
                    ),
                  ],
                )
              ];
            }
          }(),
        );
      },
    );
  }
}

class _PopUpMenuActivity extends StatelessWidget {
  final CalendarModel event;

  const _PopUpMenuActivity({required this.event});

  @override
  Widget build(BuildContext context) {
    final formCalendarActivityBloc = context.read<FormCalendarActivityCubit>();
    final calendarBloc = context.read<CalendarCubit>();

    confirmDeleteDialog(CalendarModel event) {
      Widget cancelButton = TextButton(
        child: const Text("Tidak"),
        onPressed: () {
          context.pop();
        },
      );
      Widget continueButton = TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.errorContainer,
        ),
        child: Text(
          "Iya",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onErrorContainer,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () async {
          calendarBloc.deleteCalendarByDocId(event.id!);
          context.pop();
        },
      );
      AlertDialog alert = AlertDialog(
        title: const Text("Konfirmasi"),
        content: Text("Anda yakin akan menghapus?\n${event.activity}"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return PopupMenuButton(
      onSelected: (item) {
        if (item == 0) {
          context.pushNamed(
            CalendarRouter.updateCalendarRoute.name,
            extra: UpdateEventCalendarScreenExtra(
              calendarModel: event,
              formCalendarActivityCubit: formCalendarActivityBloc,
            ),
          );
        } else if (item == 1) {
          confirmDeleteDialog(event);
        }
      },
      child: Icon(
        Icons.more_vert,
        color: Theme.of(context).primaryColor,
      ),
      itemBuilder: (context) => [
        PopupMenuItem<int>(
          value: 0,
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.penToSquare,
                color: Theme.of(context).primaryColor,
                size: 16,
              ),
              SizedBox(width: 10),
              Text(
                "Ubah",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: [
              FaIcon(
                FontAwesomeIcons.trashCan,
                color: Theme.of(context).colorScheme.error,
                size: 16,
              ),
              SizedBox(width: 10),
              Text(
                "Hapus",
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
