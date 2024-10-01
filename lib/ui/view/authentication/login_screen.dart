import 'package:bloc_api/core/service/shredPreferences.dart';
import 'package:bloc_api/core/service/validation.dart';
import 'package:bloc_api/ui/view/authentication/dash_board.dart';
import 'package:bloc_api/ui/view/authentication/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/bloc/auth/forgot_password_bloc/forgot_password_bloc.dart';
import '../../../core/bloc/auth/login_bloc/login_screen_bloc.dart';
import '../../../core/service/urls.dart';
import '../../widget/common_button.dart';
import '../../widget/common_snackbar.dart';
import '../../widget/common_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final forgotEmailController = TextEditingController();
  final ValueNotifier<bool> loginSubmitBtnLoader = ValueNotifier(false);
  static late final SharedPreferences _prefs;

  @override
  void initState() {
    init();
    super.initState();
  }

  static Future<SharedPreferences> init() async =>
      _prefs = await SharedPreferences.getInstance();

  final ValueNotifier<bool> obscureTextPassword = ValueNotifier(true);
  String emailError = "";
  bool emailValid = false;
  final ValueNotifier<bool> forgotSubmitBtnLoader = ValueNotifier(false);

  bool checkEmail() {
    if (emailController.text.isEmpty) {
      emailError = 'Required Email';
      emailValid = false;
      setState(() {});
      return false;
    } else if (!isValidEmail(emailController.text)) {
      emailError = 'Enter valid Email Id';
      emailValid = false;
      setState(() {});
      return false;
    } else {
      emailValid = true;
      setState(() {});
      return true;
    }
  }

  bool passwordValid = true;
  String passwordError = "";

  bool checkPassword() {
    if (passwordController.text.isEmpty) {
      passwordError = "Please enter password";
      passwordValid = false;
      setState(() {});
      return false;
    } else {
      passwordValid = true;
      setState(() {});
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(width * 0.04), // Responsive padding
            child: Column(
              children: [
                SizedBox(height: height * 0.1), // Responsive spacing
                Text.rich(
                  TextSpan(children: [
                    TextSpan(
                      text: "Welcome ",
                      style: TextStyle(
                        fontSize: width * 0.1,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    TextSpan(
                      text: "Back",
                      style: TextStyle(
                        fontSize: width * 0.1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
                _loginForm(),
                SizedBox(height: height * 0.02), // Responsive spacing
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      forgotPasswordSheet();
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02), // Responsive spacing
                BlocListener<LoginScreenBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      _prefs.setString(Preferences.token,
                          state.loginModel.data?.accessToken ?? "");
                      _prefs.setBool(Preferences.isLogin, true);
                      _prefs.setString(Preferences.userUuid,
                          state.loginModel.data?.uuid ?? "");
                      _prefs.setString(Preferences.streamUuid,
                          state.loginModel.data?.streamUuid ?? "");
                      _prefs.setString(Preferences.userName,
                          state.loginModel.data?.name ?? "");
                      _prefs.setString(
                          "email", state.loginModel.data?.email ?? "");
                      showSnackBar(
                          isError: false,
                          message: "Login Successfully.",
                          context: context);
                      Get.to(const DashboardScreen());
                    } else if (state is LoginFailed) {
                      showSnackBar(
                          isError: true,
                          message: state.error,
                          context: context);
                    }
                  },
                  child: CustomBtn(
                    loading: false,
                    name: "Log In",
                    onTap: () {
                      if (checkEmail() && checkPassword()) {
                        BlocProvider.of<LoginScreenBloc>(context).add(
                          UserLoginEvent(
                            url: Urls.login,
                            body: {
                              "email": emailController.text,
                              "password": passwordController.text,
                            },
                          ),
                        );
                      }
                    },
                    borderColor: Colors.black,
                    textColor: Colors.white,
                    btnColor: Colors.blueGrey,
                  ),
                ),
                SizedBox(height: height * 0.02), // Responsive spacing
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterScreen(),
                      ),
                    );
                  },
                  child: Text(
                    'Don\'t have an account? Sign Up',
                    style: TextStyle(
                        fontSize: width * 0.045, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Form(
      key: _loginKey,
      child: Column(
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.05), // Responsive spacing
          CustomField(
            controller: emailController,
            hint: "Email",
            autofillHints: const [AutofillHints.email],
            error: emailValid ? null : emailError,
            onChanged: (value) {
              if (value.isNotEmpty) checkEmail();
            },
            keyboardType: TextInputType.emailAddress,
          ),
          ValueListenableBuilder(
            valueListenable: obscureTextPassword,
            builder: (context, value, child) {
              return CustomField(
                controller: passwordController,
                isBottomSpace: false,
                hint: "Password",
                obscureText: value,
                error: passwordValid ? null : passwordError,
                suffixIcon: IconButton(
                  icon: Icon(value
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined),
                  onPressed: () {
                    obscureTextPassword.value = !obscureTextPassword.value;
                  },
                ),
                onChanged: (value) {
                  if (value.isNotEmpty) checkPassword();
                },
              );
            },
          ),
        ],
      ),
    );
  }

  void forgotPasswordSheet() {
    showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SafeArea(
          child: Container(
            height: 300,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontSize: 20,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.clear),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 5, color: Colors.black),
                CustomField(
                  controller: forgotEmailController,
                  hint: "Email",
                  autofillHints: const [AutofillHints.email],
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    if (value.isNotEmpty) checkEmail();
                  },
                ),
                BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ForgotPasswordSuccess) {
                      showSnackBar(
                          context: context,
                          isError: false,
                          message: state.message);
                      Navigator.pop(context);
                    } else if (state is ForgotPasswordFailed) {
                      showSnackBar(
                          context: context,
                          isError: true,
                          message: state.error);
                      Navigator.pop(context);
                    }
                  },
                  child: ValueListenableBuilder(
                    valueListenable: forgotSubmitBtnLoader,
                    builder: (context, loading, child) {
                      return CustomBtn(
                        name: "Submit",
                        borderColor: Colors.black,
                        textColor: Colors.white,
                        btnColor: Colors.blueGrey,
                        onTap: () {
                          if (checkEmail()) {
                            BlocProvider.of<ForgotPasswordBloc>(context).add(
                              UserForgotPasswordEvent(
                                url: Urls.resetPass,
                                body: {
                                  "email": forgotEmailController.text,
                                },
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
