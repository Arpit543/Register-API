import 'package:bloc_api/core/Model/common_model.dart';
import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'note_upload_event.dart';
part 'note_upload_state.dart';

class NoteUploadBloc extends Bloc<NoteUploadEvent, NoteUploadState> {
  final ApiService _apiService;
  final AuthRepo _authRepo;

  NoteUploadBloc({required ApiService apiService, required AuthRepo authRepo})
      : _apiService = apiService,
        _authRepo = authRepo,
        super(NoteUploadInitial()) {
    on<UserUploadEvent>(_uploadNotes);
  }

  _uploadNotes(UserUploadEvent event, Emitter<NoteUploadState> emit) async {
    emit(NoteUploadLoading());
    await _authRepo.uploadNotes(
      apiService: _apiService,
      url: event.url,
      body: event.body,
      success: (getNotes) {
        NoteUploadSuccess(commonModel: getNotes);
      },
      failure: (commonModel) {
        NoteUploadFailed(error: commonModel.message!);
      },
    );
  }
}
