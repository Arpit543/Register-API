part of 'state_bloc.dart';

abstract class StateEvent extends Equatable {
  const StateEvent();
}

class UserStateEvent extends StateEvent {
  final String url;
  final String countryId;

  const UserStateEvent({required this.countryId, required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
