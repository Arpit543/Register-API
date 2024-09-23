import 'dart:async';
import 'dart:convert';

import 'package:bloc_api/core/service/shredPreferences.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Map<String, String> getHeader() {
    Map<String, String> header = {
      "Accept": "application/json",
      "Authorization": Preferences.getString(Preferences.token) == null
          ? "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vdGhlZ3VydWNoZWxhLnN1bWF5aW5mb3RlY2guY29tL2FwaS9sb2dpbiIsImlhdCI6MTcxOTgwOTc5OSwiZXhwIjoxNzM1MzYxNzk5LCJuYmYiOjE3MTk4MDk3OTksImp0aSI6InVrQTRNeXhZRHVLOGxIbXgiLCJzdWIiOiIyNTYiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7gf8Dfe18v7-Y0dti2D1PdYqhQk9QjoyMRPfWYt7irI"
          : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vdGhlZ3VydWNoZWxhLnN1bWF5aW5mb3RlY2guY29tL2FwaS9sb2dpbiIsImlhdCI6MTcxOTgwOTc5OSwiZXhwIjoxNzM1MzYxNzk5LCJuYmYiOjE3MTk4MDk3OTksImp0aSI6InVrQTRNeXhZRHVLOGxIbXgiLCJzdWIiOiIyNTYiLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.7gf8Dfe18v7-Y0dti2D1PdYqhQk9QjoyMRPfWYt7irI"
    };

    return header;
  }

  postMethod(
      {required String url,
      Map<String, dynamic>? body,
      bool isAuthentication = true}) async {
    var result;
    try {
      var response = await http.post(Uri.parse(url),
          body: body, headers: isAuthentication == true ? getHeader() : null);
      print("Header : ----------------${getHeader()}");
      result = await handleResponse(response);
    } on TimeoutException {
      result = {"success": false, "message": "Server Time out"};
    }
    return result;
  }

  Future handleResponse(http.Response response) async {
    switch (response.statusCode) {
      case 200:
        return await jsonDecode(response.body);
      case 400:
        return {"success": false, "message": "400 Bad Request"};
      case 401:
        return {"success": false, "message": "401 Unauthorised"};
      case 404:
        return {"success": false, "message": "404 Not Found"};
      case 500:
        return {"success": false, "message": "500 Internal Server Error"};
      case 503:
        return {"success": false, "message": "503 The service is unavailable"};
      case 504:
        return {"success": false, "message": "504 Gateway Timeout"};
      default:
        return {
          "success": false,
          "message":
              "Error occurred while communication with server with status code : ${response.statusCode} : ${response.body}"
        };
    }
  }
}
