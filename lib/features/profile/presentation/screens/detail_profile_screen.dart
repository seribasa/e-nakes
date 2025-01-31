import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/core/widgets/custom_text_field.dart';
import 'package:eimunisasi_nakes/features/authentication/data/models/user.dart';
import 'package:eimunisasi_nakes/features/authentication/data/repositories/user_repository.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/profile/presentation/screens/profile_nakes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/widgets/image_picker.dart';
import '../../../../injection.dart';

class DetailProfileScreen extends StatelessWidget {
  const DetailProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile saya'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: _ProfilePicture(
                      imageUrl: state.user?.photo,
                    )),
                    const SizedBox(height: 10),
                    _ProfilNakesSection(
                      user: state.user,
                    ),
                    const SizedBox(height: 10),
                    _InformasiAkunSection(
                      user: state.user,
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _ProfilePicture extends StatelessWidget {
  final String? imageUrl;
  const _ProfilePicture({this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final userRepository = getIt<UserRepository>();
    Future<void> showAndSaveImage() async {
      ModalPickerImage().showPicker(
        context,
        (val) {
          if (val != null) {
            userRepository
                .updateUserAvatar(val)
                .then(
                  (value) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Berhasil mengubah foto profil'),
                    ),
                  ),
                )
                .catchError(
                  (e) => ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Gagal mengubah foto profil'),
                    ),
                  ),
                );
          }
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          imageUrl == null
              ? CircleAvatar(
                  foregroundColor: Colors.white,
                  radius: 50.0,
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          radius: 15,
                          child: IconButton(
                              alignment: Alignment.center,
                              icon: const Icon(
                                Icons.photo_camera,
                                size: 15.0,
                              ),
                              onPressed: () async {
                                showAndSaveImage();
                              }),
                        ),
                      ),
                    ],
                  ),
                )
              : CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const CachedNetworkImageProvider(
                      'https://i.pinimg.com/originals/d2/4d/db/d24ddb8271b8ea9b4bbf4b67df8cbc01.gif',
                      scale: 0.1),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.transparent,
                          backgroundImage: CachedNetworkImageProvider(
                              imageUrl ?? '',
                              scale: 0.1),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: CircleAvatar(
                          radius: 15,
                          child: IconButton(
                              alignment: Alignment.center,
                              icon: const Icon(
                                Icons.photo_camera,
                                size: 15.0,
                              ),
                              onPressed: () async {
                                showAndSaveImage();
                              }),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class _ProfilNakesSection extends StatelessWidget {
  final ProfileModel? user;
  const _ProfilNakesSection({required this.user});

  @override
  Widget build(BuildContext context) {
    final birthDate = user?.birthDate != null
        ? DateFormat('dd-M-yyyy').format(user?.birthDate ?? DateTime.now())
        : '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profil Nakes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        _NamaForm(
          initialValue: user?.fullName,
        ),
        const SizedBox(height: 10),
        _TempatLahirForm(initialValue: user?.birthPlace),
        const SizedBox(height: 10),
        _TanggalLahirForm(initialValue: birthDate),
        const SizedBox(height: 10),
        _NikForm(initialValue: user?.nik),
        const SizedBox(height: 10),
        _NoKartuKeluargaForm(initialValue: user?.kartuKeluarga),
        const SizedBox(height: 10),
        _ProfesiForm(initialValue: user?.profession),
        const SizedBox(height: 10),
        _JadwalForm(
          initialValue: user?.schedules,
        )
      ],
    );
  }
}

class _InformasiAkunSection extends StatelessWidget {
  final ProfileModel? user;
  const _InformasiAkunSection({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Informasi Akun',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 10),
        () {
          if (user?.email != null && user?.email != '') {
            return _EmailForm(
              initialValue: '${user?.email}',
            );
          } else if (user?.phone != null && user?.phone != '') {
            return _NomorHPForm(
              initialValue: '${user?.phone}',
            );
          }
          return Container();
        }(),
        const SizedBox(height: 10),
        const _ProfileViewButton(),
        // const _GantiPasscodeButton(),
      ],
    );
  }
}

class _NamaForm extends StatelessWidget {
  final String? initialValue;
  const _NamaForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text.rich(
          TextSpan(
            text: 'Nama Lengkap',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: ' (Sesuai Akte Lahir/KTP)',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                ),
              )
            ],
          ),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _TempatLahirForm extends StatelessWidget {
  final String? initialValue;
  const _TempatLahirForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tempat Lahir',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _TanggalLahirForm extends StatelessWidget {
  final String? initialValue;
  const _TanggalLahirForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tanggal Lahir',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _NikForm extends StatelessWidget {
  final String? initialValue;
  const _NikForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'NIK',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _NoKartuKeluargaForm extends StatelessWidget {
  final String? initialValue;
  const _NoKartuKeluargaForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'No KK',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _ProfesiForm extends StatelessWidget {
  final String? initialValue;
  const _ProfesiForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Profesi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _JadwalForm extends StatelessWidget {
  final List<Schedule>? initialValue;
  const _JadwalForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Jadwal',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        ...initialValue?.map(
              (e) => Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          e.day?.name ?? '',
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          e.time,
                          style: const TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ) ??
            [],
      ],
    );
  }
}

class _EmailForm extends StatelessWidget {
  final String? initialValue;
  const _EmailForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _NomorHPForm extends StatelessWidget {
  final String? initialValue;
  const _NomorHPForm({this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nomor HP',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 5),
        MyTextFormField(
          readOnly: true,
          initialValue: initialValue,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class _ProfileViewButton extends StatelessWidget {
  const _ProfileViewButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        key: const Key('my_profile_raisedButton'),
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const ProfileNakesScreen();
          }));
        },
        child: Row(
          children: const [
            FaIcon(FontAwesomeIcons.usersViewfinder),
            SizedBox(width: 10),
            Text(
              'Lihat Sebagai',
            ),
          ],
        ),
      ),
    );
  }
}
