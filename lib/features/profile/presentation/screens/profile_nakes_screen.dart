import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class ProfileNakesScreen extends StatelessWidget {
  const ProfileNakesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Nakes'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is Authenticated) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Profile Nakes',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: _GambarNakes(
                          gambarNakesUrl: state.user?.photo,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _NamaNakes(
                              'Nama: ${state.user?.fullName}',
                            ),
                            if (state.user?.profession != null) ...[
                              Text(
                                'Profesi: ${state.user?.profession}',
                              ),
                            ],
                            if (state.user?.birthDate != null) ...[
                              Text(
                                'Tanggal Lahir: ${DateFormat('dd MMMM yyyy').format(state.user!.birthDate!)}',
                              ),
                            ],
                            if (state.user?.phone != null &&
                                state.user?.phone != '') ...[
                              _KontakCardNakes(
                                nomorTelepon: state.user?.phone,
                              )
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                  _TempatPraktekNakes(
                    namaTempatPraktek: state.user?.clinic?.name,
                  ),
                  _JadwalNakes(
                    jadwal: state.user?.schedules,
                    jadwalImunisasi: state.user?.schedulesImunisasi,
                  ),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      )),
    );
  }
}

class _NamaNakes extends StatelessWidget {
  final String? namaNakes;
  const _NamaNakes(this.namaNakes);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        namaNakes ?? '',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _GambarNakes extends StatelessWidget {
  final String? gambarNakesUrl;
  const _GambarNakes({required this.gambarNakesUrl});

  @override
  Widget build(BuildContext context) {
    if (gambarNakesUrl == null) {
      return CircleAvatar(
        radius: 50,
        child: const Icon(
          FontAwesomeIcons.userNurse,
          size: 50,
        ),
      );
    }
    return CircleAvatar(
      radius: 50,
      backgroundImage: CachedNetworkImageProvider(
        gambarNakesUrl!,
      ),
    );
  }
}

class _KontakCardNakes extends StatelessWidget {
  final String? nomorTelepon;
  const _KontakCardNakes({required this.nomorTelepon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.phone,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              final Uri phoneLaunchUri = Uri(
                scheme: 'tel',
                path: nomorTelepon,
              );
              if (await canLaunchUrl(phoneLaunchUri)) {
                await launchUrl(phoneLaunchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tidak dapat membuka aplikasi telepon'),
                  ),
                );
              }
            },
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidMessage,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () async {
              final Uri smsLaunchUri = Uri(
                scheme: 'sms',
                path: nomorTelepon,
              );
              if (await canLaunchUrl(smsLaunchUri)) {
                await launchUrl(smsLaunchUri);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Tidak dapat membuka aplikasi sms'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _TempatPraktekNakes extends StatelessWidget {
  final String? namaTempatPraktek;
  const _TempatPraktekNakes({
    required this.namaTempatPraktek,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Tempat Praktek',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(namaTempatPraktek ?? ''),
        ],
      ),
    );
  }
}

class _JadwalNakes extends StatelessWidget {
  final List<Schedule>? jadwal;
  final List<Schedule>? jadwalImunisasi;
  const _JadwalNakes({required this.jadwal, this.jadwalImunisasi});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Jadwal Praktek',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          ...jadwal?.map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.day?.name ?? ''),
                    const Divider(thickness: 1),
                    Text("${e.startTime} - ${e.endTime}"),
                  ],
                ),
              ) ??
              [],
          const SizedBox(
            height: 10,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Jadwal Praktek Imunisasi',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 10,
          ),
          ...jadwalImunisasi?.map(
                (e) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(e.day?.name ?? ''),
                    const Divider(thickness: 1),
                    Text("${e.startTime} - ${e.endTime}"),
                  ],
                ),
              ) ??
              [],
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
