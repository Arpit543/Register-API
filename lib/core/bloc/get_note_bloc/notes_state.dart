part of 'notes_bloc.dart';

abstract class NotesState extends Equatable {
  const NotesState();
}

class NotesInitial extends NotesState {
  @override
  List<Object> get props => [];
}

final class NotesLoading extends NotesState {
  @override
  List<Object?> get props => [];
}

final class NotesSuccess extends NotesState {
  final GetNotes getNotes;

  const NotesSuccess({required this.getNotes});

  @override
  List<Object?> get props => [];
}

final class NotesFailed extends NotesState {
  final String error;

  const NotesFailed({required this.error});

  @override
  List<Object?> get props => [];
}
