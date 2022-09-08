import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                      const Flexible(
                        child: _GambarNakes(
                          gambarNakesUrl: null,
                        ),
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _NamaNakes(
                              namaNakes: state.user?.email,
                            ),
                            const Text(
                              'Profesi/Spesialis',
                            ),
                            const Text(
                              'Biografi',
                            ),
                            const _KontakCardNakes(
                              nomorTelepon: '085211011002',
                              alamat:
                                  'Jl. Raya Cibadak No. 1, Cibadak, Cimahi Utara, Kota Cimahi, Jawa Barat 40512',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const _TempatPraktekNakes(
                    namaTempatPraktek: 'Klinik Cibadak',
                  ),
                  const _JadwalNakes(
                    jadwal: {
                      'hari': ['Senin', 'Rabu'],
                      'waktu': ['08.00 - 16.00', '08.00 - 16.00']
                    },
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
              'https://cdn0-production-images-kly.akamaized.net/WzN7WyLJIUKB0rcUbnpm1MlKKzI=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2368558/original/008993600_1538023053-Klinik_Mediska_CIkampek.jpg'),
    );
  }
}

class _KontakCardNakes extends StatelessWidget {
  final String? nomorTelepon;
  final String? alamat;
  const _KontakCardNakes(
      {Key? key, required this.nomorTelepon, required this.alamat})
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
            onPressed: () {},
          ),
          IconButton(
            icon: FaIcon(
              FontAwesomeIcons.solidMessage,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {},
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(jadwal?['hari'][0] ?? ''),
              Text(jadwal?['waktu'][0] ?? ''),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(jadwal!['hari'][1] ?? ''),
              Text(jadwal!['waktu'][1] ?? ''),
            ],
          ),
        ],
      ),
    );
  }
}
