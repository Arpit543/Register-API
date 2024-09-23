part of 'stream_bloc.dart';

abstract class StreamState extends Equatable {
  const StreamState();
}

class StreamInitial extends StreamState {
  @override
  List<Object> get props => [];
}

class StreamLoading extends StreamState {
  @override
  List<Object> get props => [];
}

class StreamSuccess extends StreamState {
  final StreamData streamData;

  const StreamSuccess({required this.streamData});

  @override
  List<Object?> get props => [];
}

class StreamFailed extends StreamState {
  final String error;

  const StreamFailed({required this.error});

  @override
  List<Object> get props => [];
}
