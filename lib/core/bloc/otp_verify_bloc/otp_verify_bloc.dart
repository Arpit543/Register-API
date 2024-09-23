import 'package:bloc_api/core/Model/authModel/otp_verify_model.dart';
import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'otp_verify_event.dart';
part 'otp_verify_state.dart';

class OtpVerifyBloc extends Bloc<OtpVerifyEvent, OtpVerifyState> {
  final AuthRepo _authRepo;
  final ApiService _apiService;

  OtpVerifyBloc({required AuthRepo authRepo, required ApiService apiService})
      : _authRepo = authRepo,
        _apiService = apiService,
        super(OtpVerifyInitial()) {
    on<UserOtpEvent>(_getOtp);
  }

  _getOtp(UserOtpEvent event, Emitter<OtpVerifyState> emit) async {
    emit(OtpVerifyLoading());
    await _authRepo.otpVerify(
        apiService: _apiService,
        url: event.url,
        body: event.body,
        success: (otp) => emit(OtpVerifySuccess(otpVerifyModel: otp)),
        fail: (commonModel) =>
            emit(OtpVerifyFailed(error: commonModel.message!)));
  }
}
