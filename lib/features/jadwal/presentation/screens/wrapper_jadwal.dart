import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/jadwal/logic/jadwal/jadwal_cubit.dart';
import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/registrasi/registrasi_screen.dart';
import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/riwayat%20janji/riwayat_janji_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WrapperJadwal extends StatelessWidget {
  const WrapperJadwal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const <Widget>[
            _RiwayatJanjiButton(),
          ],
        ),
      ),
    );
  }
}

class _RiwayatJanjiButton extends StatelessWidget {
  const _RiwayatJanjiButton();
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<AuthenticationBloc>();
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          JadwalCubit(userData: authProvider.state.user)
                            ..getAllJadwal(),
                      child: const RiwayatJanjiScreen(),
                    )),
          );
        },
        child: Row(
          children: const [
            FaIcon(FontAwesomeIcons.clipboardList),
            SizedBox(width: 10),
            Text(
              'Riwayat Janji',
            ),
          ],
        ),
      ),
    );
  }
}

class _RegistrasiButton extends StatelessWidget {
  const _RegistrasiButton();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const RegistrasiScreen()),
          );
        },
        child: Row(
          children: const [
            FaIcon(FontAwesomeIcons.registered),
            SizedBox(width: 10),
            Text(
              'Registrasi',
            ),
          ],
        ),
      ),
    );
  }
}
