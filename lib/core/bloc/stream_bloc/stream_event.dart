part of 'stream_bloc.dart';

abstract class StreamEvent extends Equatable {
  const StreamEvent();
}

class UserStreamEvent extends StreamEvent {
  final String url;

  const UserStreamEvent({required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
