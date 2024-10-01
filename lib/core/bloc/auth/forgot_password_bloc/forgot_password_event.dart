part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();
}

class UserForgotPasswordEvent extends ForgotPasswordEvent {
  final String url;
  final Map<String, dynamic> body;
  const UserForgotPasswordEvent({required this.url, required this.body});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
