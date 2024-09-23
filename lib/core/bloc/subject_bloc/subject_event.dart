part of 'subject_bloc.dart';

sealed class SubjectEvent extends Equatable {
  const SubjectEvent();
}

class UserSubjectEvent extends SubjectEvent {
  final String url;
  final String uuid;

  const UserSubjectEvent({required this.uuid, required this.url});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
