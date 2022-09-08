import 'package:eimunisasi_nakes/core/widgets/profile_card.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/profile/presentation/screens/detail_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _userProvider = context.read<AuthenticationBloc>().state.user;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ProfileCard(
              urlGambar: _userProvider?.photo,
              nama: _userProvider?.fullName,
              pekerjaan: _userProvider?.profession,
            ),
            const SizedBox(height: 20),
            const _MyProfileButton(),
          ],
        ),
      )),
      bottomNavigationBar: _LogoutButton(),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: 50,
            width: double.infinity,
            child: ElevatedButton(
              key: const Key('logout_continue_raisedButton'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                primary: Colors.red[700],
              ),
              onPressed: () =>
                  context.read<AuthenticationBloc>().add(LoggedOut()),
              child: Row(
                children: const [
                  FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                  SizedBox(width: 10),
                  Text(
                    'Keluar',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MyProfileButton extends StatelessWidget {
  const _MyProfileButton({Key? key}) : super(key: key);
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
            return const DetailProfileScreen();
          }));
        },
        child: Row(
          children: const [
            FaIcon(FontAwesomeIcons.userNurse),
            SizedBox(width: 10),
            Text(
              'Tenaga Kesehatan',
            ),
          ],
        ),
      ),
    );
  }
}
