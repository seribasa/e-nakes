import 'package:bloc_test/bloc_test.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_member_model.dart';
import 'package:eimunisasi_nakes/features/clinic/data/models/clinic_model.dart';
import 'package:eimunisasi_nakes/features/clinic/data/repositories/clinic_repository.dart';
import 'package:eimunisasi_nakes/features/clinic/logic/bloc/clinic_bloc/clinic_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockClinicRepository extends Mock implements ClinicRepository {}

void main() {
  late ClinicBloc clinicBloc;
  late MockClinicRepository mockClinicRepository;

  setUp(() {
    mockClinicRepository = MockClinicRepository();
    clinicBloc = ClinicBloc(mockClinicRepository);
  });

  tearDown(() {
    clinicBloc.close();
  });

  group('ClinicBloc', () {
    const tClinicId = '1';
    final tClinic = ClinicModel(
      id: tClinicId,
    );
    final tClinicMember = [
      ClinicMemberModel(
        healthWorkerName: 'Test Name',
        healthWorkerId: 'hw123',
        clinicId: 'c456',
        clinicName: 'Test Clinic',
      )
    ];

    test('initial state should be ClinicStateInitial', () {
      expect(clinicBloc.state, equals(ClinicStateInitial()));
    });

    blocTest<ClinicBloc, ClinicState>(
      'emits [ClinicLoading, ClinicFetchData] when ClinicProfileSelected is added successfully',
      build: () {
        when(() => mockClinicRepository.getClinic(id: tClinicId))
            .thenAnswer((_) async => tClinic);
        return clinicBloc;
      },
      act: (bloc) => bloc.add(const ClinicProfileSelected(clinicId: tClinicId)),
      expect: () => [
        ClinicLoading(),
        ClinicFetchData(clinic: tClinic),
      ],
    );

    blocTest<ClinicBloc, ClinicState>(
      'emits [ClinicLoading, ClinicFailure] when ClinicProfileSelected fails',
      build: () {
        when(() => mockClinicRepository.getClinic(id: tClinicId))
            .thenThrow(Exception());
        return clinicBloc;
      },
      act: (bloc) => bloc.add(const ClinicProfileSelected(clinicId: tClinicId)),
      expect: () => [
        ClinicLoading(),
        const ClinicFailure(error: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );

    blocTest<ClinicBloc, ClinicState>(
      'emits [ClinicLoading, ClinicMemberDataFetched] when ClinicMembershipSelected is added successfully',
      build: () {
        when(() => mockClinicRepository.getClinicMember(id: tClinicId))
            .thenAnswer((_) async => tClinicMember);
        return clinicBloc;
      },
      act: (bloc) =>
          bloc.add(const ClinicMembershipSelected(clinicId: tClinicId)),
      expect: () => [
        ClinicLoading(),
        ClinicMemberDataFetched(data: tClinicMember),
      ],
    );

    blocTest<ClinicBloc, ClinicState>(
      'emits [ClinicLoading, ClinicFailure] when ClinicMembershipSelected fails',
      build: () {
        when(() => mockClinicRepository.getClinicMember(id: tClinicId))
            .thenThrow(Exception());
        return clinicBloc;
      },
      act: (bloc) =>
          bloc.add(const ClinicMembershipSelected(clinicId: tClinicId)),
      expect: () => [
        ClinicLoading(),
        const ClinicFailure(error: 'Terjadi kesalahan, silahkan coba lagi'),
      ],
    );
  });
}
