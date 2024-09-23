import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/authModel/register_model.dart';
import '../../repository/auth_repo.dart';
import '../../service/api_services.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterScreenBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  RegisterScreenBloc({
    required AuthRepo authRepo,
    required ApiService apiService,
  })  : _authRepo = authRepo,
        _apiService = apiService,
        super(RegisterInitial()) {
    on<UserSignUpEvent>(_onRegister);
  }

  _onRegister(UserSignUpEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    await _authRepo.signUp(
      apiService: _apiService,
      url: event.url,
      body: event.body,
      success: (registerModel) =>
          emit(RegisterSuccess(registerModel: registerModel)),
      fail: (commonModel) => emit(RegisterFailed(error: commonModel.message!)),
    );
  }
}
