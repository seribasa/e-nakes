import 'package:eimunisasi_nakes/features/klinik/logic/bloc/klinik_bloc/klinik_bloc.dart';
import 'package:eimunisasi_nakes/features/klinik/presentation/screens/keanggotaan_screen.dart';
import 'package:eimunisasi_nakes/features/klinik/presentation/screens/profile_klinik_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';

class WrapperKlinik extends StatelessWidget {
  const WrapperKlinik({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KlinikBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Klinik'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: const <Widget>[
              _KlinikProfileButton(),
              SizedBox(height: 20),
              _KlinikKeanggotaanButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class _KlinikProfileButton extends StatelessWidget {
  const _KlinikProfileButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _user = context.read<AuthenticationBloc>().state.user;
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
                  builder: (context) => BlocProvider(
                    create: (context) => KlinikBloc()
                      ..add(KlinikProfilePressed(clinicId: _user?.clinic?.id)),
                    child: const ProfileKlinikScreen(),
                  ),
                ),
              );
            },
            child: Row(
              children: const [
                FaIcon(FontAwesomeIcons.envelopesBulk),
                SizedBox(width: 10),
                Text(
                  'Profil Klinik',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _KlinikKeanggotaanButton extends StatelessWidget {
  const _KlinikKeanggotaanButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _user = context.read<AuthenticationBloc>().state.user;
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
                create: (context) => KlinikBloc()
                  ..add(KlinikKeanggotaanPressed(clinicId: _user?.clinic?.id)),
                child: const KeanggotaanKlinikScreen(),
              ),
            ),
          );
        },
        child: Row(
          children: const [
            FaIcon(FontAwesomeIcons.userNurse),
            SizedBox(width: 10),
            Text(
              'Keanggotaan',
            ),
          ],
        ),
      ),
    );
  }
}
