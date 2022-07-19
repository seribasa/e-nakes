import 'dart:collection';

import 'package:eimunisasi_nakes/core/widgets/loading_dialog.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/kalender/logic/calendar/calendar_cubit.dart';
import 'package:eimunisasi_nakes/features/kalender/logic/form_calendar_activity/form_calendar_activity_cubit.dart';
import 'package:eimunisasi_nakes/features/kalender/presentation/screens/tambah_event_kalender_screen.dart';
import 'package:eimunisasi_nakes/features/kalender/presentation/screens/update_event_kalender_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:formz/formz.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class KalenderScreen extends StatefulWidget {
  const KalenderScreen({Key? key}) : super(key: key);

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
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
      DateTime date = DateTime.utc(event.date!.year, event.date!.month,
          event.date!.day, event.date!.hour, event.date!.minute);
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
                    fontWeight: FontWeight.bold),
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
    final _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final _formCalendarActivityBloc =
        BlocProvider.of<FormCalendarActivityCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalender"),
        actions: [
          BlocBuilder(
            bloc: _authBloc,
            builder: (context, state) {
              return IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                                value: _formCalendarActivityBloc,
                                child: const TambahEventKalenderScreen(),
                              ))));
            },
          )
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FormCalendarActivityCubit, FormCalendarActivityState>(
              listener: (context, state) {
            if (state.status == FormzStatus.submissionSuccess) {
              context.read<CalendarCubit>().getAllCalendar();
            }
          }),
          BlocListener<CalendarCubit, CalendarState>(
              listener: (context, state) {
            if (state is CalendarDeleted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Kegiatan berhasil dihapus"),
              ));
              context.read<CalendarCubit>().getAllCalendar();
            } else if (state is CalendarDeleting) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const LoadingDialog(
                  label: 'Deleting...',
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
                allEvents = state.listCalendarModel;
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
                        formatButtonVisible: false, titleCentered: true),
                    calendarStyle: CalendarStyle(
                        todayDecoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle),
                        selectedDecoration: BoxDecoration(
                            color: Colors.blue[200], shape: BoxShape.circle)),
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
                                'Daftar aktivitas : ' +
                                    DateFormat('dd MMMM yyyy')
                                        .format(selectedDate ?? DateTime.now())
                                        .toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 15,
                                ),
                              ),
                              CircleAvatar(
                                foregroundColor: Colors.white,
                                backgroundColor: Theme.of(context).accentColor,
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _selectedDay = null;
                                      });
                                    },
                                    icon: const Icon(Icons.close_rounded)),
                              )
                            ],
                          ),
                          const SizedBox(height: 5.0),
                          ..._selectedEvents.map((event) => ListTile(
                                trailing: _PopUpMenuActivity(
                                  event: event,
                                ),
                                isThreeLine: true,
                                title: Text(event.activity ?? ''),
                                subtitle: Text(DateFormat('HH:mm')
                                    .format(event.date ?? DateTime.now())),
                              )),
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
                          : Container()),
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
  const _DataTableActivity(
      {Key? key, required this.events, required this.onPageChangeDate})
      : super(key: key);

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
            headingRowColor: MaterialStateColor.resolveWith(
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
                        e.date!.month == onPageChangeDate!.month &&
                        e.date!.year == onPageChangeDate!.year)
                    .map(
                      (e) => DataRow(
                        cells: <DataCell>[
                          DataCell(
                            Text(DateFormat('dd-MM-yyyy')
                                .format(e.date!)
                                .toString()),
                          ),
                          DataCell(Row(
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
                          )),
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
            }());
      },
    );
  }
}

class _PopUpMenuActivity extends StatelessWidget {
  final CalendarModel event;
  const _PopUpMenuActivity({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formCalendarActivityBloc =
        BlocProvider.of<FormCalendarActivityCubit>(context);
    final _calendarBloc = BlocProvider.of<CalendarCubit>(context);

    confirmDeleteDialog(CalendarModel event) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: const Text("No"),
        onPressed: () {
          Navigator.pop(context);
        },
      );
      Widget continueButton = TextButton(
        child: const Text(
          "Yes",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          _calendarBloc.deleteCalendarByDocId(event.documentID!);
          Navigator.pop(context);
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Konfirmasi"),
        content: Text("Anda yakin akan menghapus?\n\n${event.activity}"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );
      // show the dialog
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                        value: _formCalendarActivityBloc,
                        child: UpdateEventKalenderScreen(
                          calendarModel: event,
                        ),
                      )));
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
            children: const [
              FaIcon(
                FontAwesomeIcons.penToSquare,
                color: Colors.blue,
              ),
              SizedBox(width: 10),
              Text("Ubah"),
            ],
          ),
        ),
        PopupMenuItem<int>(
          value: 1,
          child: Row(
            children: const [
              FaIcon(
                FontAwesomeIcons.trashCan,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text("Hapus"),
            ],
          ),
        ),
      ],
    );
  }
}
