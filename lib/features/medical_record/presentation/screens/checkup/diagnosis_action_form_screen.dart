import 'package:eimunisasi_nakes/core/widgets/pasien_card.dart';
import 'package:eimunisasi_nakes/features/medical_record/logic/checkup_form_cubit/checkup_form_cubit.dart';
import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';

class DiagnosisActionFormScreen extends StatelessWidget {
  const DiagnosisActionFormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form diagnosa dan tindakan'),
      ),
      body: BlocListener<CheckupFormCubit, CheckupFormState>(
        listener: (context, state) {
          if (state.status == FormzSubmissionStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Berhasil menyimpan pemeriksaan!'),
              ),
            );
            context.pushReplacementNamed(
              RootRoutePaths.dashboard.name,
            );
          } else if (state.status == FormzSubmissionStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Terjadi kesalahan!'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                PasienCard(
                  nama: 'Rizky faturriza',
                  umur: '1 bulan 2 tahun',
                ),
                SizedBox(height: 10),
                _DiagnosaForm(),
                SizedBox(height: 10),
                _TindakanForm()
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const _NextButton(),
    );
  }
}

class _DiagnosaForm extends StatelessWidget {
  const _DiagnosaForm();

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc = BlocProvider.of<CheckupFormCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Diagnosa',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: TextField(
            onChanged: (value) => pemeriksaanBloc.changeDiagnosis(value),
            minLines: 1,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Tidak ada riwayat diagnosa',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _TindakanForm extends StatelessWidget {
  const _TindakanForm();

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc = BlocProvider.of<CheckupFormCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Tindakan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey[200],
          ),
          child: TextField(
            onChanged: (value) => pemeriksaanBloc.changeAction(value),
            minLines: 1,
            maxLines: 10,
            decoration: const InputDecoration(
              hintText: 'Tidak ada riwayat tindakan',
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context) {
    final pemeriksaanBloc = BlocProvider.of<CheckupFormCubit>(context);
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: BlocBuilder<CheckupFormCubit, CheckupFormState>(
        builder: (context, state) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero)),
            onPressed: state.status == FormzSubmissionStatus.inProgress
                ? null
                : () {
                    pemeriksaanBloc.submit();
                  },
            child: state.status == FormzSubmissionStatus.inProgress
                ? const CircularProgressIndicator()
                : const Text("Selesai"),
          );
        },
      ),
    );
  }
}
