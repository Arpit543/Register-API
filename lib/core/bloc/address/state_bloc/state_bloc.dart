import 'package:bloc/bloc.dart';
import 'package:bloc_api/core/Model/addressModel/state_data.dart';
import 'package:equatable/equatable.dart';

import '../../../repository/auth_repo.dart';
import '../../../service/api_services.dart';


part 'state_event.dart';
part 'state_state.dart';

class StateBloc extends Bloc<StateEvent, StateState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  StateBloc({required AuthRepo authRepo, required ApiService apiService})
      : _authRepo = authRepo,
        _apiService = apiService,
        super(StateInitial()) {
    on<UserStateEvent>(_getStates);
  }

  _getStates(UserStateEvent event, Emitter<StateState> emit) async {
    emit(StateLoading());
    await _authRepo.getStates(
      apiService: _apiService,
      url: event.url,
      countryId: event.countryId,
      success: (stateData) => emit(StateSuccess(states: stateData)),
      fail: (commonModel) => emit(StateFailed(error: commonModel.message!)),
    );
  }
}
