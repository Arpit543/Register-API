part of 'notes_bloc.dart';

abstract class NotesEvent extends Equatable {
  const NotesEvent();
}

class UserNotesEvent extends NotesEvent {
  final String url;
  final String userUuid;

  const UserNotesEvent({required this.userUuid, required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
