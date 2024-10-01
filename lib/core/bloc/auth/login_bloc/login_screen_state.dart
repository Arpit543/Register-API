part of 'login_screen_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
}

final class LoginSuccess extends LoginState {
  final LoginModel loginModel;

  const LoginSuccess({required this.loginModel});

  @override
  List<Object> get props => [];
}

final class LoginFailed extends LoginState {
  final String error;

  const LoginFailed({required this.error});

  @override
  List<Object> get props => [];
}
