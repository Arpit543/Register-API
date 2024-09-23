import 'package:bloc_api/core/Model/Notes/GetNotes.dart';
import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notes_event.dart';
part 'notes_state.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  NotesBloc({required AuthRepo authRepo, required ApiService apiService})
      : _authRepo = authRepo,
        _apiService = apiService,
        super(NotesInitial()) {
    on<UserNotesEvent>(_getNotesFromAPI);
  }

  _getNotesFromAPI(UserNotesEvent event, Emitter<NotesState> emit) async {
    emit(NotesLoading());
    await _authRepo.fetchNotes(
      apiService: _apiService,
      url: event.url,
      uuid: event.userUuid,
      success: (getNotes) => emit(NotesSuccess(getNotes: getNotes)),
      failure: (commonModel) => emit(NotesFailed(error: commonModel.message ?? "")),

    );
  }
}
