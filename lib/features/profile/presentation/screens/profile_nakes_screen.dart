import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileNakesScreen extends StatelessWidget {
  const ProfileNakesScreen({Key? key}) : super(key: key);

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
                          gambarNakesUrl: state.user?.clinic?.photos,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _NamaNakes(
                              namaNakes: state.user?.fullName,
                            ),
                            Text(
                              state.user?.profession ?? '',
                            ),
                            Text(
                              state.user?.birthDate
                                      .toString()
                                      .split(' ')
                                      .first ??
                                  '',
                            ),
                            state.user?.phone != null && state.user?.phone != ''
                                ? _KontakCardNakes(
                                    nomorTelepon: state.user?.phone,
                                  )
                                : const SizedBox()
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
  const _NamaNakes({Key? key, required this.namaNakes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerLeft,
        child: Text(namaNakes ?? '',
            style: const TextStyle(fontWeight: FontWeight.bold)));
  }
}

class _GambarNakes extends StatelessWidget {
  final List<String>? gambarNakesUrl;
  const _GambarNakes({Key? key, required this.gambarNakesUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: gambarNakesUrl?.last ??
              'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
    );
  }
}

class _KontakCardNakes extends StatelessWidget {
  final String? nomorTelepon;
  const _KontakCardNakes({Key? key, required this.nomorTelepon})
      : super(key: key);

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
              final Uri _phoneLaunchUri = Uri(
                scheme: 'tel',
                path: nomorTelepon,
              );
              if (await canLaunchUrl(_phoneLaunchUri)) {
                await launchUrl(_phoneLaunchUri);
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
              final Uri _smsLaunchUri = Uri(
                scheme: 'sms',
                path: nomorTelepon,
              );
              if (await canLaunch(_smsLaunchUri.toString())) {
                await launch(_smsLaunchUri.toString());
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
    Key? key,
    required this.namaTempatPraktek,
  }) : super(key: key);

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
  final Map? jadwal;
  const _JadwalNakes({Key? key, required this.jadwal}) : super(key: key);

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
          ...jadwal?.entries.map(
                (e) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(e.key ?? ''),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            ...e.value
                                .map(
                                  (e) => Text(e ?? ''),
                                )
                                .toList(),
                          ],
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1,
                    ),
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
