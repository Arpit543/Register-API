part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class UserSignUpEvent extends RegisterEvent {
  final String url;
  final Map<String, dynamic> body;

  const UserSignUpEvent({required this.url, required this.body});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
