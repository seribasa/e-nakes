import 'package:eimunisasi_nakes/routers/appointment_router.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class WrapperAppointmentScreen extends StatelessWidget {
  const WrapperAppointmentScreen({super.key});

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
          context.pushNamed(AppointmentRouter.historiesRoute.name);
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
