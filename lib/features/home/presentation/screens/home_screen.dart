import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/wrapper_jadwal.dart';
import 'package:eimunisasi_nakes/features/kalender/presentation/screens/kalender_screen.dart';
import 'package:eimunisasi_nakes/features/klinik/presentation/screens/wrapper_klinik.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/wrapper_rekam_medis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../authentication/data/models/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HelloHeader(
                      data: state.data,
                    ),
                    const _AppoinmentToday(),
                    const Flexible(child: _MenuList()),
                  ]),
            ),
          );
        }
        return Column(children: const [
          Text('Unknown'),
        ]);
      },
    );
  }
}

class _HelloHeader extends StatelessWidget {
  final UserData data;
  const _HelloHeader({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Halo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            data.phone == '' || data.phone == null
                ? Text(
                    data.email!,
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                : Text(
                    data.phone!,
                    style: Theme.of(context).textTheme.caption,
                  ),
          ]),
          const CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(
                "https://avatars.githubusercontent.com/u/56538058?v=4"),
          ),
        ],
      ),
    );
  }
}

class _MenuList extends StatelessWidget {
  const _MenuList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map> data = [
      {
        'title': 'Kalender',
        'icon': FontAwesomeIcons.calendar,
        'route': const KalenderScreen(),
      },
      {
        'title': 'Klinik',
        'icon': FontAwesomeIcons.hospital,
        'route': const WrapperKlinik(),
      },
      {
        'title': 'Jadwal',
        'icon': FontAwesomeIcons.clipboardList,
        'route': const WrapperJadwal(),
      },
      {
        'title': 'Rekam Medis',
        'icon': FontAwesomeIcons.bookMedical,
        'route': const WrapperRekamMedis(),
      }
    ];
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Menu',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Flexible(
            child: GridView.builder(
                itemCount: data.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 1.2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 40,
                  mainAxisSpacing: 5,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => data[index]['route'],
                    )),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: FaIcon(
                              data[index]['icon'],
                              size: 30,
                              color: Colors.blue[100],
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Colors.blue[300],
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          data[index]['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class _AppoinmentToday extends StatelessWidget {
  const _AppoinmentToday({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Jadwal Pasien Hari Ini',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {},
                child: const Text(
                  'Lihat Semua',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.blue[300],
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: const [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: CachedNetworkImageProvider(
                              'https://avatars.githubusercontent.com/u/56538058?v=4'),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Rizky Faturrahman',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.blue[200],
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          FaIcon(
                            FontAwesomeIcons.calendarDays,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            '28 Februari 2022',
                            style: TextStyle(color: Colors.white),
                          ),
                          FaIcon(
                            FontAwesomeIcons.clock,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            '08:00 - 09:00 AM',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
