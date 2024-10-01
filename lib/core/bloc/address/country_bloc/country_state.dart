part of 'country_bloc.dart';

abstract class CountryState extends Equatable {
  const CountryState();
}

class CountryInitial extends CountryState {
  @override
  List<Object> get props => [];
}

class CountryLoading extends CountryState {
  @override
  List<Object> get props => [];
}

class CountrySuccess extends CountryState {
  final countryData country;

  const CountrySuccess({required this.country});

  @override
  List<Object> get props => [];
}

class CountryFailed extends CountryState {
  final String error;

  const CountryFailed({required this.error});

  @override
  List<Object> get props => [];
}
