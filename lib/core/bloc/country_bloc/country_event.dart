part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();
}

class UserCountryEvent extends CountryEvent {
  final String url;

  const UserCountryEvent({required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
