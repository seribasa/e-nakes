import 'package:eimunisasi_nakes/core/widgets/search_bar_widget.dart';
import 'package:eimunisasi_nakes/features/authentication/logic/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:eimunisasi_nakes/features/appointment/presentation/screens/registrasi/qrcode_screen.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/logic/pasien/pasien_cubit.dart';
import 'package:eimunisasi_nakes/features/rekam_medis/presentation/screens/pemeriksaan/verifikasi_pasien_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PemeriksaanScreen extends StatelessWidget {
  const PemeriksaanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pemeriksaan Pasien'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            QRScanButton(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QrRegistrasiPemeriksaan()));
              },
            ),
            const SizedBox(height: 10),
            const _SearchBar(),
            const SizedBox(height: 10),
            const Expanded(
              child: _ListPasien(),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListPasien extends StatelessWidget {
  const _ListPasien();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PasienCubit, PasienState>(
      builder: (context, state) {
        if (state is PasienLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PasienLoaded) {
          if (state.patientPagination?.data == null) {
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
                    children: List.generate(
                      state.patientPagination?.data?.length ?? 0,
                      (index) {
                        final pasien = state.patientPagination?.data?[index];
                        return ListTile(
                          title: Text(
                            '${pasien?.nama}',
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          subtitle: Text('${pasien?.nik}'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => VerifikasiPasienScreen(
                                  pasien: pasien,
                                  jadwalPasienModel: null,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
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

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return SearchBarPeltops(
      hintText: 'Cari Pasien ...',
      onPressed: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(20, (index) {
                  return ListTile(
                    title: Text(
                      'Pasien $index',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(
                        'NIK $index${index + 1}${index + 2}${index + 3}${index + 4}'),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

class QRScanButton extends StatelessWidget {
  final void Function()? onTap;

  const QRScanButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width / 3,
          height: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(
                FontAwesomeIcons.qrcode,
                size: MediaQuery.of(context).size.width / 5,
                color: Colors.blue,
              ),
              const SizedBox(height: 5),
              const Text(
                'Scan QR Code',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
