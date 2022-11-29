import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/core/extension/string_extension.dart';
import 'package:eimunisasi_nakes/features/klinik/logic/bloc/klinik_bloc/klinik_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/method_helper.dart';

class ProfileKlinikScreen extends StatelessWidget {
  const ProfileKlinikScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Klinik'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        // child: GetUserName(),
        child: BlocBuilder<KlinikBloc, KlinikState>(
          builder: (context, state) {
            if (state is KlinikLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is KlinikFailure) {
              return const Center(
                child: Text('Data gagal dimuat'),
              );
            } else if (state is KlinikFetchData) {
              return Column(
                children: [
                  _NamaKlinik(
                    namaKlinik: state.klinik?.name,
                  ),
                  _MottoKlinik(mottoKlinik: state.klinik?.motto),
                  _GambarKlinik(
                    gambarKlinikUrl: state.klinik?.photos,
                  ),
                  _KontakCardKlinik(
                    nomorTelepon: state.klinik?.phoneNumber,
                    alamat: state.klinik?.address,
                    namaKlinik: state.klinik?.name,
                  ),
                  _JadwalKlinik(
                    jadwal: state.klinik?.schedules,
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

class _NamaKlinik extends StatelessWidget {
  final String? namaKlinik;
  const _NamaKlinik({Key? key, required this.namaKlinik}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(namaKlinik!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}

class _MottoKlinik extends StatelessWidget {
  final String? mottoKlinik;
  const _MottoKlinik({Key? key, this.mottoKlinik}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(mottoKlinik ?? ''));
  }
}

class _GambarKlinik extends StatelessWidget {
  final List<String>? gambarKlinikUrl;
  const _GambarKlinik({Key? key, required this.gambarKlinikUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: double.infinity,
        child: CachedNetworkImage(
            imageUrl: gambarKlinikUrl?.last ??
                'https://cdn0-production-images-kly.akamaized.net/WzN7WyLJIUKB0rcUbnpm1MlKKzI=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2368558/original/008993600_1538023053-Klinik_Mediska_CIkampek.jpg'),
      ),
    );
  }
}

class _KontakCardKlinik extends StatelessWidget {
  final String? nomorTelepon;
  final String? alamat;
  final String? namaKlinik;
  const _KontakCardKlinik(
      {Key? key,
      required this.nomorTelepon,
      required this.namaKlinik,
      this.alamat})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(alamat ?? ''),
          const SizedBox(
            height: 20,
          ),
          Row(
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
                  if (await canLaunchUrl(_smsLaunchUri)) {
                    await launchUrl(_smsLaunchUri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak dapat membuka aplikasi sms'),
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.mapLocationDot,
                  color: Theme.of(context).primaryColor,
                ),
                onPressed: () async {
                  navigateGoogleMapTo(namaKlinik ?? '').catchError((e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tidak dapat membuka aplikasi maps'),
                      ),
                    );
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _JadwalKlinik extends StatelessWidget {
  final Map? jadwal;
  const _JadwalKlinik({Key? key, required this.jadwal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text('Jadwal',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(
            height: 20,
          ),
          () {
            if (jadwal == null) {
              return const Center(child: Text('Tidak ada jadwal'));
            }
            final length = jadwal?['hari'].length ?? 0;
            List<Widget> list = [];
            for (int i = 0; i < length; i++) {
              list.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(jadwal!['hari'][i]?.toString().capitalize() ?? ''),
                    Text(jadwal!['waktu'][i] ?? ''),
                  ],
                ),
              );
              list.add(const SizedBox(height: 10));
            }
            return Column(
              children: list,
            );
          }(),
        ],
      ),
    );
  }
}
