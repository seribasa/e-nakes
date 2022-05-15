part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class Loading extends AuthenticationState {
  @override
  String toString() => 'Loading';
}

class Authenticated extends AuthenticationState {
  final UserData data;

  const Authenticated(this.data);

  @override
  List<Object> get props => [data];

  @override
  String toString() => 'Authenticated { displayName: $data }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

class ResetPasswordSent extends AuthenticationState {
  @override
  String toString() => 'ResetPasswordSent';
}
