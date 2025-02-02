import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/core/extension/context_ext.dart';
import 'package:eimunisasi_nakes/features/clinic/logic/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/common/method_helper.dart';
import '../../../../injection.dart';
import '../../../authentication/data/models/user.dart';

class ClinicProfileScreen extends StatelessWidget {
  final String id;
  const ClinicProfileScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ClinicBloc>()
        ..add(
          ClinicProfileSelected(clinicId: id),
        ),
      child: const _ClinicProfileScaffold(),
    );
  }
}

class _ClinicProfileScaffold extends StatelessWidget {
  const _ClinicProfileScaffold();

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
        child: BlocBuilder<ClinicBloc, ClinicState>(
          builder: (context, state) {
            if (state is ClinicLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ClinicFailure) {
              return const Center(
                child: Text('Data gagal dimuat'),
              );
            } else if (state is ClinicFetchData) {
              return Column(
                children: [
                  _NamaKlinik(
                    namaKlinik: state.clinic?.name,
                  ),
                  _MottoKlinik(mottoKlinik: state.clinic?.motto),
                  _GambarKlinik(
                    gambarKlinikUrl: state.clinic?.photos,
                  ),
                  _KontakCardKlinik(
                    nomorTelepon: state.clinic?.phoneNumber,
                    alamat: state.clinic?.address,
                    namaKlinik: state.clinic?.name,
                  ),
                  _JadwalKlinik(
                    jadwal: state.clinic?.schedules,
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
  const _NamaKlinik({required this.namaKlinik});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(namaKlinik!,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
  }
}

class _MottoKlinik extends StatelessWidget {
  final String? mottoKlinik;
  const _MottoKlinik({this.mottoKlinik});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(mottoKlinik ?? ''));
  }
}

class _GambarKlinik extends StatelessWidget {
  final List<String>? gambarKlinikUrl;
  const _GambarKlinik({required this.gambarKlinikUrl});

  @override
  Widget build(BuildContext context) {
    if (gambarKlinikUrl == null || gambarKlinikUrl!.isEmpty) {
      return const SizedBox();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 200,
        child: PageView.builder(
          itemCount: gambarKlinikUrl!.length,
          itemBuilder: (context, index) {
            return CachedNetworkImage(
              imageUrl: gambarKlinikUrl![index],
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, progress) => Center(
                child: CircularProgressIndicator(
                  value: progress.progress,
                ),
              ),
              errorWidget: (context, url, error) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 50,
                    color: context.theme.colorScheme.error,
                  ),
                  const Text('Gagal memuat gambar'),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _KontakCardKlinik extends StatelessWidget {
  final String? nomorTelepon;
  final String? alamat;
  final String? namaKlinik;
  const _KontakCardKlinik({
    required this.nomorTelepon,
    required this.namaKlinik,
    this.alamat,
  });

  @override
  Widget build(BuildContext context) {
    void onCopyAddress() {
      if (alamat != null) {
        Clipboard.setData(ClipboardData(text: alamat!));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Alamat berhasil disalin'),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Alamat',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: onCopyAddress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(alamat ?? ''),
                const Icon(Icons.copy),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Kontak',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
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
  final List<Schedule>? jadwal;
  const _JadwalKlinik({required this.jadwal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Jadwal',
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          () {
            if (jadwal == null || jadwal!.isEmpty) {
              return const Center(child: Text('Tidak ada jadwal'));
            }
            final length = jadwal?.length ?? 0;
            List<Widget> list = [];
            for (int i = 0; i < length; i++) {
              list.add(
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(jadwal?[i].day?.name ?? ''),
                    Text("${jadwal?[i].time}"),
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
