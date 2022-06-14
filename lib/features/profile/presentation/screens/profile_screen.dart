import 'package:cached_network_image/cached_network_image.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const <Widget>[
            _ProfileCard(),
            SizedBox(height: 20),
            _MyProfileButton(),
            Expanded(
                child: Center(
              child: Text('Profile Screen'),
            )),
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
                primary: Colors.red[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () =>
                  context.read<AuthenticationBloc>().add(LoggedOut()),
              child: const Text('Keluar'),
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
        style: ElevatedButton.styleFrom(
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: () {},
        child: Row(
          children: const [
            FaIcon(FontAwesomeIcons.userNurse),
            SizedBox(width: 10),
            Text(
              'Profil Saya',
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state is Authenticated) {
          return ListTile(
            leading: const CircleAvatar(
              radius: 25,
              backgroundImage: CachedNetworkImageProvider(
                  "https://picsum.photos/250?image=9"),
            ),
            title: const Text(
              'Rizky Faturriza',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              state.data.email ?? '',
              style: const TextStyle(color: Colors.black),
            ),
          );
        }
        return Container(
          color: Colors.blue,
          child: const ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            title: Text('Nama'),
            subtitle: Text('Nakes'),
          ),
        );
      },
    );
  }
}
