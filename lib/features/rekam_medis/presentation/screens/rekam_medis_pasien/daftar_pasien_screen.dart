import 'package:eimunisasi_nakes/core/widgets/search_bar_widget.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pasien/pasien_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pemeriksaan/pemeriksaan_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/rekam_medis_pasien/rekam_medis_pasien_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DaftarPasienScreen extends StatelessWidget {
  const DaftarPasienScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: const [
            _SearchBar(),
            Expanded(child: _ListPasien()),
          ],
        ),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pasienBloc = BlocProvider.of<PasienCubit>(context);
    return SearchBar(
      hintText: 'Cari Pasien (NIK) ...',
      onChanged: (val) {
        _pasienBloc.getPasienBySearch(val);
      },
      onPressed: () {},
    );
  }
}

class _ListPasien extends StatelessWidget {
  const _ListPasien({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pasienBloc = BlocProvider.of<PasienCubit>(context);
    return BlocBuilder<PasienCubit, PasienState>(
      builder: (context, state) {
        if (state is PasienLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PasienLoaded) {
          if (state.pasien.isEmpty) {
            return const Center(
              child: Text('Tidak ada pasien'),
            );
          } else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, auth) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(state.pasien.length, (index) {
                      final pasien = state.pasien[index];
                      return ListTile(
                        title: Text(
                          '${pasien.nik}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text('${pasien.nama}'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                      create: (context) => PemeriksaanCubit(
                                          userData: auth is Authenticated
                                              ? auth.data
                                              : null)
                                        ..getPemeriksaanByIdPasien(pasien.nik),
                                      child: RekamMedisPasienScreen(
                                          pasien: pasien),
                                    )),
                          );
                        },
                      );
                    }),
                  );
                },
              ),
            );
          }
        } else {
          return const Center(
            child: Text('Tidak ada data'),
          );
        }
      },
    );
  }
}
