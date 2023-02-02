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
  const Authenticated({UserData? user}) : super(user: user);

  @override
  List<Object?> get props => [user];

  @override
  String toString() => 'Authenticated { $user }';
}

class Unauthenticated extends AuthenticationState {
  @override
  String toString() => 'Unauthenticated';
}

class AuthenticationError extends AuthenticationState {
  final String message;
  const AuthenticationError({required this.message});
  @override
  String toString() => 'AuthenticationError { $message }';
}

class ResetPasswordSent extends AuthenticationState {
  @override
  String toString() => 'ResetPasswordSent';
}
