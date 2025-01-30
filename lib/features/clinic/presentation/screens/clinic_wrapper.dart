import 'package:eimunisasi_nakes/features/clinic/logic/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:eimunisasi_nakes/features/clinic/presentation/screens/membership_screen.dart';
import 'package:eimunisasi_nakes/features/clinic/presentation/screens/clinic_profile_screen.dart';
import 'package:eimunisasi_nakes/injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';

class WrapperKlinik extends StatelessWidget {
  const WrapperKlinik({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ClinicBloc>(),
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
  const _KlinikProfileButton();
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
    return BlocBuilder<ClinicBloc, ClinicState>(
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
                    create: (context) => getIt<ClinicBloc>()
                      ..add(ClinicProfileSelected(clinicId: user?.clinic?.id)),
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
  const _KlinikKeanggotaanButton();
  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthenticationBloc>().state.user;
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
                create: (context) => getIt<ClinicBloc>()
                  ..add(ClinicMembershipSelected(clinicId: user?.clinic?.id)),
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
