import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  StreamSubscription<AuthState>? _authSubscription;

  AuthenticationBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(Uninitialized()) {
    _authSubcription();
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }

  void _authSubcription() {
    _authSubscription = _userRepository.onAuthStateChange.listen((
      event,
    ) {
      final authEvent = event.event;
      if (authEvent == AuthChangeEvent.signedIn) {
        add(LoggedIn());
        return;
      }
    });
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
