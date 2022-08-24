import 'package:eimunisasi_nakes/core/widgets/custom_text_field.dart';
import 'package:eimunisasi_nakes/core/widgets/profile_card.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/profile/presentation/screens/form_ganti_pin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailProfileScreen extends StatelessWidget {
  const DetailProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Profile saya'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProfileCard(
                    urlGambar:
                        'https://avatars.githubusercontent.com/u/56538058?v=4',
                    nama: 'Rizky',
                    pekerjaan: 'dokter anak',
                  ),
                  const SizedBox(height: 10),
                  state.user.email != null && state.user.email != ''
                      ? _EmailForm(
                          initialValue: '${state.user.email}',
                        )
                      : Container(),
                  state.user.phone != null && state.user.phone != ''
                      ? _NomorHPForm(
                          initialValue: '${state.user.phone}',
                        )
                      : Container(),
                  const SizedBox(height: 10),
                  const _GantiPasscodeButton(),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}

class _EmailForm extends StatelessWidget {
  final String? initialValue;
  const _EmailForm({Key? key, this.initialValue}) : super(key: key);

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
          initialValue: initialValue,
          keyboardType: TextInputType.emailAddress,
        ),
      ],
    );
  }
}

class _NomorHPForm extends StatelessWidget {
  final String? initialValue;
  const _NomorHPForm({Key? key, this.initialValue}) : super(key: key);

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
          initialValue: initialValue,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}

class _GantiPasscodeButton extends StatelessWidget {
  const _GantiPasscodeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: const Text("Ganti PIN"),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const GantiPINScreen();
          }));
        },
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
        child: const Text("Simpan"),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return GrafikPemeriksaanScreen();
          // }));
        },
      ),
    );
  }
}
