import 'package:eimunisasi_nakes/routers/route_paths/root_route_paths.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/appointment/presentation/screens/registrasi/qrcode_screen.dart';
import '../features/medical_record/logic/checkup_form_cubit/checkup_form_cubit.dart';
import '../features/medical_record/presentation/screens/checkup/checkup_chart_screen.dart';
import '../features/medical_record/presentation/screens/checkup/checkup_form_screen.dart';
import '../features/medical_record/presentation/screens/checkup/checkup_screen.dart';
import '../features/medical_record/presentation/screens/checkup/diagnosis_action_form_screen.dart';
import '../features/medical_record/presentation/screens/checkup/patient_verification_screen.dart';
import '../features/medical_record/presentation/screens/wrapper_medical_record.dart';
import 'models/route_model.dart';

class MedicalRecordRouter {
  static const RouteModel wrapperRoute = RouteModel(
    name: 'medicalRecordWrapper',
    path: 'medical-record',
    parent: RootRoutePaths.dashboard,
  );
  static const RouteModel checkupRoute = RouteModel(
    name: 'checkup',
    path: 'checkup',
    parent: wrapperRoute,
  );
  static const RouteModel checkupScanRoute = RouteModel(
    name: 'checkupScan',
    path: 'scan',
    parent: checkupRoute,
  );
  static const RouteModel checkupVerificationRoute = RouteModel(
    name: 'checkupVerification',
    path: 'verification',
    parent: checkupRoute,
  );
  static const RouteModel checkupFormRoute = RouteModel(
    name: 'checkupForm',
    path: 'form',
    parent: checkupRoute,
  );
  static const RouteModel checkupChartRoute = RouteModel(
    name: 'checkupChart',
    path: 'chart',
    parent: checkupRoute,
  );
  static const RouteModel checkupDiagnosisActionRoute = RouteModel(
    name: 'checkupDiagnosisAction',
    path: 'diagnosis-action',
    parent: checkupRoute,
  );

  static List<RouteBase> routes = [
    GoRoute(
      name: wrapperRoute.name,
      path: wrapperRoute.path,
      builder: (_, __) => const WrapperRekamMedis(),
      routes: [
        GoRoute(
          name: checkupRoute.name,
          path: checkupRoute.path,
          builder: (_, __) => const CheckupScreen(),
          routes: [
            GoRoute(
              name: checkupScanRoute.name,
              path: checkupScanRoute.path,
              builder: (_, state) {
                return QrRegistrasiPemeriksaan();
              },
            ),
            GoRoute(
              name: checkupVerificationRoute.name,
              path: checkupVerificationRoute.path,
              builder: (_, state) {
                final extra = state.extra as PatientVerificationScreenExtra?;
                return PatientVerificationScreen(
                  patient: extra?.patient,
                  appointment: extra?.appointment,
                );
              },
            ),
            GoRoute(
              name: checkupFormRoute.name,
              path: checkupFormRoute.path,
              builder: (_, state) {
                final formCubit = state.extra as CheckupFormCubit;
                return BlocProvider.value(
                  value: formCubit,
                  child: const FormPemeriksaanScreen(),
                );
              },
            ),
            GoRoute(
              name: checkupChartRoute.name,
              path: checkupChartRoute.path,
              builder: (_, state) {
                final formCubit = state.extra as CheckupFormCubit;
                return BlocProvider.value(
                  value: formCubit,
                  child: CheckupChartScreen(),
                );
              },
            ),
            GoRoute(
              name: checkupDiagnosisActionRoute.name,
              path: checkupDiagnosisActionRoute.path,
              builder: (_, state) {
                final formCubit = state.extra as CheckupFormCubit;
                return BlocProvider.value(
                  value: formCubit,
                  child: DiagnosisActionFormScreen(),
                );
              },
            ),
          ],
        ),
      ],
    ),
  ];
}
