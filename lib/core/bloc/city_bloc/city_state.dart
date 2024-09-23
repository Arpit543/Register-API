part of 'city_bloc.dart';

abstract class CityState extends Equatable {
  const CityState();
}

final class CityInitial extends CityState {
  @override
  List<Object> get props => [];
}

final class CityLoading extends CityState {
  @override
  List<Object> get props => [];
}

final class CitySuccess extends CityState {
  final cityData cityModel;

  const CitySuccess({required this.cityModel});

  @override
  List<Object> get props => [];
}

final class CityFailed extends CityState {
  final String error;

  const CityFailed({required this.error});

  @override
  List<Object> get props => [];
}
