import 'package:bloc_api/core/bloc/get_note_bloc/notes_bloc.dart';
import 'package:bloc_api/core/bloc/stream_bloc/stream_bloc.dart';
import 'package:bloc_api/core/bloc/upload_notes_bloc/note_upload_bloc.dart';
import 'package:bloc_api/core/repository/auth_repo.dart';
import 'package:bloc_api/core/service/api_services.dart';
import 'package:bloc_api/core/service/shredPreferences.dart';
import 'package:bloc_api/ui/view/authentication/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import 'core/bloc/address/city_bloc/city_bloc.dart';
import 'core/bloc/address/country_bloc/country_bloc.dart';
import 'core/bloc/address/state_bloc/state_bloc.dart';
import 'core/bloc/auth/forgot_password_bloc/forgot_password_bloc.dart';
import 'core/bloc/auth/login_bloc/login_screen_bloc.dart';
import 'core/bloc/auth/otp_verify_bloc/otp_verify_bloc.dart';
import 'core/bloc/auth/register_bloc/register_bloc.dart';
import 'core/bloc/subject_bloc/subject_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AuthRepo authRepo;
  late final ApiService apiService;

  @override
  void initState() {
    authRepo = AuthRepo();
    apiService = ApiService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return LoginScreenBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return RegisterScreenBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return CountryBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return StateBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return CityBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return StreamBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return SubjectBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return OtpVerifyBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return NotesBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return ForgotPasswordBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
        BlocProvider(
          create: (context) {
            return NoteUploadBloc(
              apiService: apiService,
              authRepo: authRepo,
            );
          },
        ),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "RegisterAPI",
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Gilroy",
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
