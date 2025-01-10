part of 'checkup_cubit.dart';

abstract class CheckupState extends Equatable {
  const CheckupState();

  @override
  List<Object?> get props => [];
}

class CheckupInitial extends CheckupState {}

class CheckupLoading extends CheckupState {}

class CheckupLoaded extends CheckupState {
  final BasePagination<CheckupModel>? checkupResult;

  const CheckupLoaded({required this.checkupResult});

  @override
  List<Object?> get props => [checkupResult];
}

class CheckupError extends CheckupState {
  final String message;

  const CheckupError({required this.message});

  @override
  List<Object> get props => [message];
}
