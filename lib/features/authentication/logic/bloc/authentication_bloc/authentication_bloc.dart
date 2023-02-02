import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;

  AuthenticationBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(Uninitialized()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }
  void _onAppStarted(
      AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(Loading());
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final data = await _userRepository.getUser();
        emit(Authenticated(user: data));
      } else {
        emit(Unauthenticated());
      }
    } catch (_) {
      emit(Unauthenticated());
    }
  }

  void _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(Loading());
    final data = await _userRepository.getUser();
    emit(Authenticated(user: data));
  }

  void _onLoggedOut(LoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(Loading());
    await _userRepository.signOut().then((value) {
      emit(Unauthenticated());
    }).catchError((error) {
      log(
        error.toString(),
        name: 'Error LoggedOut',
      );
      emit(
        const AuthenticationError(message: 'Gagal logout. Silahkan coba lagi!'),
      );
      add(LoggedIn());
    });
  }
}
