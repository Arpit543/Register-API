part of 'note_upload_bloc.dart';

abstract class NoteUploadEvent extends Equatable {
  const NoteUploadEvent();
}

class UserUploadEvent extends NoteUploadEvent {
  final String url;
  final Map<String, dynamic> body;

  const UserUploadEvent({
    required this.url,
    required this.body,
  });

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
