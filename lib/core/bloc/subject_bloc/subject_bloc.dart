import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/Streams/subject_data.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  SubjectBloc({required AuthRepo authRepo, required ApiService apiService})
      : _authRepo = authRepo,
        _apiService = apiService,
        super(SubjectInitial()) {
    on<UserSubjectEvent>(_getSubjectList);
  }

  _getSubjectList(UserSubjectEvent event, Emitter<SubjectState> emit) async {
    emit(SubjectLoading());
    await _authRepo.getSubjects(
        apiService: _apiService,
        url: event.url,
        uuid: event.uuid,
        success: (subjectData) => emit(SubjectSuccess(subject: subjectData)),
        fail: (commonModel) =>
            emit(SubjectFailed(error: commonModel.message!)));
  }
}
