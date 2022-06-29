import 'package:eimunisasi_nakes/features/kalender/data/models/calendar_model.dart';
import 'package:eimunisasi_nakes/features/kalender/presentation/screens/tambah_event_kalender_screen.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class KalenderScreen extends StatefulWidget {
  const KalenderScreen({Key? key}) : super(key: key);

  @override
  State<KalenderScreen> createState() => _KalenderScreenState();
}

class _KalenderScreenState extends State<KalenderScreen> {
  List<CalendarModel>? allEvents;
  confirmDeleteDialog(BuildContext context, dynamic event) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () async {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Konfirmasi"),
      content: Text("Apakah anda yakin akan menghapus ${event.title}?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _onPageChangeDate = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<CalendarModel>>? _groupedEvents;
  List<CalendarModel> _selectedEvents = [];
  final kFirstDay = DateTime(DateTime.now().year - 5);
  final kLastDay = DateTime(DateTime.now().year + 5);

  @override
  void initState() {
    // NotificationService().cancelNotificationAll();
    // Hive.box<CalendarsHive>('calendar_activity')
    //     .deleteAll(Hive.box<CalendarsHive>('calendar_activity').keys);
    super.initState();
  }

  @override
  void dispose() {
    // allEvents.asMap().forEach((i, v) {
    //   addActivityHive(activity: v.activity, date: v.date);
    // });
    // Hive.close();
    super.dispose();
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  _groupEvents(List<CalendarModel>? allEvents) {
    // _groupedEvents = LinkedHashMap(equals: isSameDay, hashCode: getHashCode);
    allEvents?.forEach((event) {
      DateTime date = DateTime.utc(
          event.date!.year, event.date!.month, event.date!.day, 12);
      if (_groupedEvents![date] == null) _groupedEvents![date] = [];
      _groupedEvents![date]?.add(event);
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
            padding: EdgeInsets.all(1.0),
            decoration: BoxDecoration(
                color: Theme.of(context).accentColor, shape: BoxShape.circle),
            constraints: BoxConstraints(minWidth: 15.0, minHeight: 15.0),
            child: Center(
              child: Text(
                "${events.length}",
                textAlign: TextAlign.center,
                style: TextStyle(
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Kalender"),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TambahEventKalenderScreen())))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
        child: SingleChildScrollView(
          child: StreamBuilder<List<CalendarModel>>(
              stream: null,
              builder: (context, AsyncSnapshot<List<CalendarModel>> snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error'));
                }
                allEvents = snapshot.data;
                _groupEvents(allEvents);

                DateTime selectedDate = _selectedDay;
                _selectedEvents = _groupedEvents?[selectedDate] ?? [];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TableCalendar(
                      calendarBuilders: calendarBuilder(),
                      eventLoader: _getEventsfromDay,
                      headerStyle: HeaderStyle(
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
                        // No need to call `setState()` here
                        _focusedDay = focusedDay;
                        setState(() {
                          _onPageChangeDate = focusedDay;
                        });
                      },
                    ),
                    SizedBox(height: 30.0),
                    (_selectedDay != null
                        ? Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Daftar aktivitas : ' +
                                        DateFormat('dd MMMM yyyy')
                                            .format(selectedDate)
                                            .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                    ),
                                  ),
                                  CircleAvatar(
                                    foregroundColor: Colors.white,
                                    backgroundColor:
                                        Theme.of(context).accentColor,
                                    child: IconButton(
                                        onPressed: () {
                                          // setState(() {
                                          //   _selectedDay = null;
                                          // });
                                        },
                                        icon: Icon(Icons.close_rounded)),
                                  )
                                ],
                              ),
                              SizedBox(height: 5.0),
                              // ..._selectedEvents.map((event) => ListTile(
                              //       title: Text(event.activity),
                              //       subtitle: Text(DateFormat('dd-MM-yyyy')
                              //           .format(event.date)
                              //           .toString()),
                              //     )),
                            ],
                          )
                        : Container()),
                    SizedBox(
                        width: double.infinity,
                        child: (selectedDate == null
                            ? DataTable(
                                headingRowHeight: 40,
                                // dataRowHeight: DataRowHeight.flexible(),
                                headingTextStyle: TextStyle(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                dataTextStyle: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.black,
                                ),
                                headingRowColor: MaterialStateColor.resolveWith(
                                    (states) => Theme.of(context).primaryColor),
                                columns: <DataColumn>[
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
                                rows: allEvents!
                                    .where((e) =>
                                        e.date!.month ==
                                            _onPageChangeDate.month &&
                                        e.date!.year == _onPageChangeDate.year)
                                    .map(
                                      (e) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                            Text(DateFormat('dd-MM-yyyy')
                                                .format(e.date!)
                                                .toString()),
                                          ),
                                          DataCell(Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  e.activity!,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              !e.readOnly!
                                                  ? PopupMenuButton(
                                                      onSelected: (item) =>
                                                          null,
                                                      initialValue: 2,
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      ),
                                                      itemBuilder: (context) =>
                                                          [
                                                        PopupMenuItem<int>(
                                                            value: 0,
                                                            child:
                                                                Text("Ubah")),
                                                        PopupMenuItem<int>(
                                                            value: 1,
                                                            child:
                                                                Text("Hapus")),
                                                      ],
                                                    )
                                                  : Container(),
                                            ],
                                          )),
                                        ],
                                      ),
                                    )
                                    .toList())
                            : null))
                  ],
                );
              }),
        ),
      ),
    );
  }
}

class _Calendar extends StatelessWidget {
  const _Calendar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ListEvent extends StatelessWidget {
  const _ListEvent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
