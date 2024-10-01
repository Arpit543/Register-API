part of 'otp_verify_bloc.dart';

abstract class OtpVerifyEvent extends Equatable {
  const OtpVerifyEvent();
}

class UserOtpEvent extends OtpVerifyEvent {
  final String url;
  final Map<String, dynamic> body;

  const UserOtpEvent({required this.url, required this.body});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
