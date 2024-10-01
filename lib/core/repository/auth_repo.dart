import 'package:bloc_api/core/Model/Notes/GetNotes.dart';
import 'package:bloc_api/core/Model/Streams/stream_data.dart';
import 'package:bloc_api/core/Model/addressModel/city_data.dart';
import 'package:bloc_api/core/Model/addressModel/country_data.dart';
import 'package:bloc_api/core/Model/addressModel/state_data.dart';
import 'package:bloc_api/core/Model/authModel/otp_verify_model.dart';
import 'package:bloc_api/core/Model/authModel/register_model.dart';
import 'package:bloc_api/core/service/api_services.dart';

import '../Model/Streams/subject_data.dart';
import '../Model/authModel/forgot_password.dart';
import '../Model/authModel/login_data.dart';
import '../Model/common_model.dart';

class AuthRepo {
  signUp({
    required ApiService apiService,
    required String url,
    required Map<String, dynamic> body,
    required Function(RegisterUserData registerModel) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result = await apiService.postMethod(
        url: url, body: body, isAuthentication: false);
    try {
      RegisterUserData model = RegisterUserData.fromJson(result);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false, message: model.message ?? "Error in Registration"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  getCountry({
    required ApiService apiService,
    required String url,
    required Function(countryData country) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result = await apiService.postMethod(url: url, isAuthentication: false);
    try {
      countryData model = countryData.fromJson(result);
      print(model);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false,
            message: model.message ?? "Error in Getting Country"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  getStreams({
    required ApiService apiService,
    required String url,
    required Function(StreamData stream) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result = await apiService.postMethod(url: url, isAuthentication: false);

    try {
      StreamData streamData = StreamData.fromJson(result);
      print(streamData);

      if (streamData.success == true) {
        success(streamData);
      } else {
        fail(CommonModel(
            success: false,
            message: streamData.message ?? "Error in Getting Streams"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  getSubjects({
    required ApiService apiService,
    required String url,
    required String uuid,
    required Function(subjectData subject) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result =
        await apiService.postMethod(url: url, body: {"stream_uuid": uuid});
    try {
      subjectData model = subjectData.fromJson(result);
      print(model);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false,
            message: model.message ?? "Error in Getting States"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  getStates({
    required ApiService apiService,
    required String url,
    required String countryId,
    required Function(stateData states) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result =
        await apiService.postMethod(url: url, body: {"country_id": countryId});
    try {
      stateData model = stateData.fromJson(result);
      print(model);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false,
            message: model.message ?? "Error in Getting States"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  getCityList({
    required ApiService apiService,
    required String url,
    required String state,
    required Function(cityData cityModel) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result =
        await apiService.postMethod(url: url, body: {"state_id": state});
    try {
      cityData model = cityData.fromJson(result);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false, message: model.message ?? "Error in Getting City"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  otpVerify({
    required ApiService apiService,
    required String url,
    required Map<String, dynamic> body,
    required Function(OtpVerifyModel otpVerifyModel) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result = await apiService.postMethod(
        url: url, body: body, isAuthentication: false);
    try {
      OtpVerifyModel model = OtpVerifyModel.fromJson(result);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false, message: model.message ?? "Error in Otp Verify"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  login({
    required ApiService apiService,
    required String url,
    required Map<String, dynamic> body,
    required Function(LoginModel loginModel) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result = await apiService.postMethod(
        url: url, body: body, isAuthentication: false);
    try {
      print("Result: $result");
      LoginModel model = LoginModel.fromJson(result);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false, message: model.message ?? "Error in Login"));
      }
    } catch (e) {
      print("Failed: $e");
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  //Get Notes
  getNotes({
    required ApiService apiService,
    required String url,
    required String uuid,
    required Function(GetNotes getNotes) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result = await apiService.postMethod(
        url: url, body: {"user_uuid": uuid}, isAuthentication: true);
    print("Notes --------------------- $result");
    try {
      GetNotes model = GetNotes.fromJson(result);
      print("Model data ;----------------------- ${model.data}");
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false,
            message: model.message ?? "Error in Getting Notes"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  Future<void> fetchNotes({
    required ApiService apiService,
    required String url,
    required String uuid,
    required Function(GetNotes getNotes) success,
    required Function(CommonModel commonModel) failure,
  }) async {
    try {
      var result = await apiService.postMethod(
        url: url,
        body: {"user_uuid": uuid},
        isAuthentication: true,
      );

      print("Notes response: $result");

      GetNotes model = GetNotes.fromJson(result);

      print("Parsed Model Data: ${model.data}");

      if (model.success == true) {
        success(model);
      } else {
        failure(CommonModel(
          success: false,
          message: model.message ?? "Error in Getting Notes",
        ));
      }
    } catch (error) {
      print("Error fetching notes: $error");
      failure(CommonModel(success: false, message: error.toString()));
    }
  }

  forgotPassword({
    required ApiService apiService,
    required String url,
    required Map<String, dynamic> body,
    required Function(ForgotPasswordModel forgotPasswordModel) success,
    required Function(CommonModel commonModel) fail,
  }) async {
    var result = await apiService.postMethod(
        url: url, body: body, isAuthentication: false);
    try {
      ForgotPasswordModel model = ForgotPasswordModel.fromJson(result);
      if (model.success == true) {
        success(model);
      } else {
        fail(CommonModel(
            success: false,
            message: model.message ?? "Error in Forgot Password"));
      }
    } catch (e) {
      fail(CommonModel(success: false, message: e.toString()));
    }
  }

  Future<void> uploadNotes({
    required ApiService apiService,
    required String url,
    required Map<String, dynamic> body,
    required Function(CommonModel getNotes) success,
    required Function(CommonModel commonModel) failure,
  }) async {
    try {
      var result = await apiService.postMethod(
        url: url,
        body: body,
        isAuthentication: true,
      );

      print("Notes response: $result");

      CommonModel model = CommonModel.fromJson(result);

      print("Parsed Model Data: ${model.data}");

      if (model.success == true) {
        success(model);
      } else {
        failure(CommonModel(
          success: false,
          message: model.message ?? "Error in Getting Notes",
        ));
      }
    } catch (error) {
      print("Error fetching notes: $error");
      failure(CommonModel(success: false, message: error.toString()));
    }
  }
}
