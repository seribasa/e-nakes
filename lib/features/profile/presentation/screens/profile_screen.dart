import 'package:eimunisasi_nakes/core/extension/context_ext.dart';
import 'package:eimunisasi_nakes/features/profile/presentation/widgets/profile_card.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<AuthenticationBloc>().state.user;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            ProfileCard(
              urlGambar: userProvider?.photo,
              nama: userProvider?.fullName,
              pekerjaan: userProvider?.profession,
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
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Keluar'),
          content: const Text('Apakah Anda yakin ingin keluar?'),
          actions: [
            ElevatedButton(
                key: const Key('logout_cancel_raisedButton'),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: context.theme.colorScheme.primary,
                ),
                onPressed: () => context.pop(),
                child: const Text('Batal')),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                key: const Key('logout_confirm_textButton'),
                onPressed: () {
                  context.pop();
                  context.read<AuthenticationBloc>().add(LoggedOut());
                },
                child: Text(
                  'Ya, Keluar',
                  style: TextStyle(color: Colors.pink[400]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
              key: const Key('logout_raisedButton'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: context.theme.colorScheme.error,
              ),
              onPressed: () => _showLogoutDialog(context),
              child: const Row(
                children: [
                  FaIcon(FontAwesomeIcons.arrowRightFromBracket),
                  SizedBox(width: 10),
                  Text('Keluar'),
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
  const _MyProfileButton();

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
          context.pushNamed(RootRoutePaths.profile.name);
        },
        child: const Row(
          children: [
            FaIcon(FontAwesomeIcons.userNurse),
            SizedBox(width: 10),
            Text('Tenaga Kesehatan'),
          ],
        ),
      ),
    );
  }
}
