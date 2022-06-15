import 'package:eimunisasi_nakes/core/widgets/profile_card.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
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
                  state.data.email != null && state.data.email != ''
                      ? _EmailForm(
                          initialValue: '${state.data.email}',
                        )
                      : Container(),
                  state.data.phone != null && state.data.phone != ''
                      ? _NomorHPForm(
                          initialValue: '${state.data.phone}',
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

class _FormField extends StatelessWidget {
  final String? initialValue;
  final TextInputType? keyboardType;
  const _FormField({Key? key, this.keyboardType, this.initialValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: keyboardType,
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
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
        _FormField(
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
        _FormField(
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
        child: const Text("Ganti Passcode"),
        onPressed: () {
          // Navigator.push(context, MaterialPageRoute(builder: (context) {
          //   return GrafikPemeriksaanScreen();
          // }));
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
