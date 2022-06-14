import 'package:eimunisasi_nakes/features/klinik/logic/bloc/klinik_bloc/klinik_bloc.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/pemeriksaan_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/daftar_pasien_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/rekam_medis_pasien_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WrapperRekamMedis extends StatelessWidget {
  const WrapperRekamMedis({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KlinikBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rekam Medis'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: const <Widget>[
              _PemeriksaanButton(),
              SizedBox(height: 20),
              _RekamMedisPasienButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PemeriksaanButton extends StatelessWidget {
  const _PemeriksaanButton({Key? key}) : super(key: key);
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
                    builder: (context) => const PemeriksaanScreen()),
              );
            },
            child: Row(
              children: const [
                FaIcon(FontAwesomeIcons.clipboardList),
                SizedBox(width: 10),
                Text(
                  'Vaksinasi dan Pemeriksaan',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _RekamMedisPasienButton extends StatelessWidget {
  const _RekamMedisPasienButton({Key? key}) : super(key: key);
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
            MaterialPageRoute(builder: (context) => const DaftarPasienScreen()),
          );
        },
        child: Row(
          children: const [
            FaIcon(FontAwesomeIcons.registered),
            SizedBox(width: 10),
            Text(
              'Rekam Medis Pasien',
            ),
          ],
        ),
      ),
    );
  }
}
