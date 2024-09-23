part of 'state_bloc.dart';

abstract class StateState extends Equatable {
  const StateState();
}

class StateInitial extends StateState {
  @override
  List<Object> get props => [];
}

class StateLoading extends StateState {
  @override
  List<Object> get props => [];
}

class StateSuccess extends StateState {
  final stateData states;

  const StateSuccess({required this.states});

  @override
  List<Object> get props => [];
}

class StateFailed extends StateState {
  final String error;

  const StateFailed({required this.error});

  @override
  List<Object> get props => [];
}
