part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  final UserData? user;
  const AuthenticationState({this.user});
  @override
  List<Object?> get props => [user];
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
  @override
  final UserData? user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];

  @override
  String toString() => 'Authenticated { displayName: $user }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

class ResetPasswordSent extends AuthenticationState {
  @override
  String toString() => 'ResetPasswordSent';
}
