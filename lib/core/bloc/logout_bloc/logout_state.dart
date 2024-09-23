part of 'logout_bloc.dart';

sealed class LogoutState extends Equatable {
  const LogoutState();
}

final class LogoutInitial extends LogoutState {
  @override
  List<Object> get props => [];
}
