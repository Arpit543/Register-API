import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repository/auth_repo.dart';
import '../../../service/api_services.dart';


part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ApiService _apiService;
  final AuthRepo _authRepo;

  ForgotPasswordBloc({
    required ApiService apiService,
    required AuthRepo authRepo,
  })  : _apiService = apiService,
        _authRepo = authRepo,
        super(ForgotPasswordInitial()) {
    on<UserForgotPasswordEvent>(_onForgotPassword);
  }

  _onForgotPassword(
      UserForgotPasswordEvent event, Emitter<ForgotPasswordState> emit) async {
    emit(ForgotPasswordLoading());
    await _authRepo.forgotPassword(
      apiService: _apiService,
      url: event.url,
      body: event.body,
      success: (forgotPasswordModel) => emit(
          ForgotPasswordSuccess(message: forgotPasswordModel.message ?? "")),
      fail: (commonModel) =>
          emit(ForgotPasswordFailed(error: commonModel.message ?? "")),
    );
  }
}
