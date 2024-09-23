import 'package:bloc_api/core/Model/Streams/stream_data.dart';
import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stream_event.dart';
part 'stream_state.dart';

class StreamBloc extends Bloc<StreamEvent, StreamState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  StreamBloc({
    required AuthRepo authRepo,
    required ApiService apiService,
  })  : _authRepo = authRepo,
        _apiService = apiService,
        super(StreamInitial()) {
    on<UserStreamEvent>(_getStreams);
  }

  _getStreams(UserStreamEvent event, Emitter<StreamState> emit) async {
    emit(StreamLoading());
    await _authRepo.getStreams(
      apiService: _apiService,
      url: event.url,
      success: (stream) => emit(StreamSuccess(streamData: stream)),
      fail: (commonModel) => emit(StreamFailed(error: commonModel.message!)),
    );
  }
}
