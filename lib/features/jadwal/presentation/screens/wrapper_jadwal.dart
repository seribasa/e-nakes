import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/registrasi/registrasi_screen.dart';
import 'package:eimunisasi_nakes/features/jadwal/presentation/screens/riwayat%20janji/riwayat_janji_screen.dart';
import 'package:eimunisasi_nakes/features/klinik/logic/bloc/klinik_bloc/klinik_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WrapperJadwal extends StatelessWidget {
  const WrapperJadwal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KlinikBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Jadwal'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: const <Widget>[
              _RiwayatJanjiButton(),
              SizedBox(height: 20),
              _RegistrasiButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RiwayatJanjiButton extends StatelessWidget {
  const _RiwayatJanjiButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KlinikBloc, KlinikState>(
      builder: (context, state) {
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
                    builder: (context) => const RiwayatJanjiScreen()),
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
      },
    );
  }
}

class _RegistrasiButton extends StatelessWidget {
  const _RegistrasiButton({Key? key}) : super(key: key);
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
