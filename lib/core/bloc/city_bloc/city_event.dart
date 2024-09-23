part of 'city_bloc.dart';

abstract class CityEvent extends Equatable {
  const CityEvent();
}

class UserCityEvent extends CityEvent{
  final String url;
  final String stateId;
  const UserCityEvent({required this.url, required this.stateId});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
