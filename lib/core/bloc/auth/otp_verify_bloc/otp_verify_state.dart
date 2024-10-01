part of 'otp_verify_bloc.dart';

abstract class OtpVerifyState extends Equatable {
  const OtpVerifyState();
}

class OtpVerifyInitial extends OtpVerifyState {
  @override
  List<Object> get props => [];
}

class OtpVerifyLoading extends OtpVerifyState {
  @override
  List<Object> get props => [];
}

class OtpVerifySuccess extends OtpVerifyState {
  final OtpVerifyModel otpVerifyModel;

  const OtpVerifySuccess({required this.otpVerifyModel});

  @override
  List<Object> get props => [];
}

class OtpVerifyFailed extends OtpVerifyState {
  final String error;

  const OtpVerifyFailed({required this.error});

  @override
  List<Object> get props => [];
}
