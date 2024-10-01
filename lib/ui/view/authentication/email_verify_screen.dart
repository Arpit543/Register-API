
import 'package:bloc_api/core/service/urls.dart';
import 'package:bloc_api/ui/view/authentication/login_screen.dart';
import 'package:bloc_api/ui/widget/common_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../core/bloc/auth/otp_verify_bloc/otp_verify_bloc.dart';
import '../../widget/common_button.dart';
import '../../widget/common_textfield.dart';

class EmailVerifiedScreen extends StatefulWidget {
  final bool isSignUp;
  final String email;

  const EmailVerifiedScreen(
      {super.key, required this.email, required this.isSignUp});

  @override
  State<EmailVerifiedScreen> createState() => _EmailVerifiedScreenState();
}

class _EmailVerifiedScreenState extends State<EmailVerifiedScreen> {
  final otpController = TextEditingController();
  ValueNotifier<bool> submitBtnLoader = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "We have sent an OTP to this address:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              widget.email,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),
            ),
            const SizedBox(height: 20),
            CustomField(
              controller: otpController,
              hint: "Enter OTP",
              autofillHints: const [AutofillHints.oneTimeCode],
              keyboardType: TextInputType.number,
              isBottomSpace: true,
            ),
            const SizedBox(height: 20),
            BlocListener<OtpVerifyBloc, OtpVerifyState>(
              listener: (context, state) {
                if (state is OtpVerifySuccess) {
                  showSnackBar(
                      context: context,
                      isError: false,
                      message: state.otpVerifyModel.message ?? "");
                } else if (state is OtpVerifyFailed) {
                  submitBtnLoader.value = false;
                  showSnackBar(
                      context: context, isError: true, message: state.error);
                }
              },
              child: ValueListenableBuilder(
                  valueListenable: submitBtnLoader,
                  builder: (context, loading, child) {
                    return CustomBtn(
                      loading: loading,
                      name: "Submit",
                      onTap: () {
                        if (otpController.text.isNotEmpty) {
                          submitBtnLoader.value = true;
                          BlocProvider.of<OtpVerifyBloc>(context).add(UserOtpEvent(
                              url: Urls.verifyEmail,
                              body: {
                                "email": widget.email,
                                "otp": otpController.text
                              }));
                          Get.to(const LoginPage());
                        }
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
