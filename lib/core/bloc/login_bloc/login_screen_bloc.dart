import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Model/authModel/login_data.dart';
import '../../repository/auth_repo.dart';
import '../../service/api_services.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  LoginScreenBloc({
    required AuthRepo authRepo,
    required ApiService apiService,
  })  : _authRepo = authRepo,
        _apiService = apiService,
        super(LoginInitial()) {
    on<UserLoginEvent>(_onLogin);
  }

  _onLogin(UserLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    await _authRepo.login(
      apiService: _apiService,
      url: event.url,
      body: event.body,
      success: (loginModel) => emit(LoginSuccess(loginModel: loginModel)),
      fail: (commonModel) =>
          emit(LoginFailed(error: commonModel.message ?? "")),
    );
  }
}
