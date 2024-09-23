part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

final class ForgotPasswordLoading extends ForgotPasswordState {
  @override
  List<Object> get props => [];
}

final class ForgotPasswordSuccess extends ForgotPasswordState {
  final String message;

  const ForgotPasswordSuccess({required this.message});

  @override
  List<Object> get props => [];
}

final class ForgotPasswordFailed extends ForgotPasswordState {
  final String error;

  const ForgotPasswordFailed({required this.error});

  @override
  List<Object> get props => [];
}
