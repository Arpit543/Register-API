part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();
}

class RegisterInitial extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterLoading extends RegisterState {
  @override
  List<Object> get props => [];
}

final class RegisterSuccess extends RegisterState {
  final RegisterUserData registerModel;

  const RegisterSuccess({required this.registerModel});

  @override
  List<Object> get props => [];
}

final class RegisterFailed extends RegisterState {
  final String error;

  const RegisterFailed({required this.error});

  @override
  List<Object> get props => [];
}
