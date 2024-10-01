part of 'note_upload_bloc.dart';

abstract class NoteUploadState extends Equatable {
  const NoteUploadState();
}

final class NoteUploadInitial extends NoteUploadState {
  @override
  List<Object> get props => [];
}

final class NoteUploadLoading extends NoteUploadState {
  @override
  List<Object> get props => [];
}

final class NoteUploadSuccess extends NoteUploadState {
  final CommonModel commonModel;

  const NoteUploadSuccess({required this.commonModel});

  @override
  List<Object> get props => [];
}

final class NoteUploadFailed extends NoteUploadState {
  final String error;

  const NoteUploadFailed({required this.error});

  @override
  List<Object> get props => [];
}
