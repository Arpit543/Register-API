part of 'login_screen_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class UserLoginEvent extends LoginEvent {
  final String url;
  final Map<String, dynamic> body;

  const UserLoginEvent({required this.url, required this.body});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
