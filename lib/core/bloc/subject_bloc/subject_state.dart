part of 'subject_bloc.dart';

sealed class SubjectState extends Equatable {
  const SubjectState();
}

final class SubjectInitial extends SubjectState {
  @override
  List<Object> get props => [];
}

class SubjectLoading extends SubjectState {
  @override
  List<Object> get props => [];
}

class SubjectSuccess extends SubjectState {
  final subjectData subject;

  const SubjectSuccess({required this.subject});

  @override
  List<Object?> get props => [];
}

class SubjectFailed extends SubjectState {
  final String error;

  const SubjectFailed({required this.error});

  @override
  List<Object> get props => [];
}
