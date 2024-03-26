part of 'services.dart';

class UserService {
  late bool _isAuthenticated;

  UserService() {
    _isAuthenticated =
        false; // Initialize the member variable in the constructor body
  }

  bool get isAuth => _isAuthenticated;

  static Future<ApiReturnValue<Map<String, dynamic>>> signIn(
      String email, String password) async {
    try {
      final headers = {'Content-Type': 'application/json'};
      final body = jsonEncode({"email": email, "password": password});
      final response =
          await http.post(Uri.parse(Apis.login), headers: headers, body: body);

      var message = jsonDecode(response.body)['message'];
      var isError = jsonDecode(response.body)['error'];

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body)['loginResult'];
        return ApiReturnValue(value: result, message: message, error: isError);
      } else {
        return ApiReturnValue(message: message, error: isError);
      }
    } catch (e) {
      log("[${DateTime.now()}] $e",
          error: "There is error when login", name: "Response");
      return ApiReturnValue(message: "There is Error when login", error: true);
    }
  }

  static Future<ApiReturnValue<Map<String, dynamic>>> signUp(
      String name, String email, String password) async {
    if (password.length < 8) {
      return ApiReturnValue(
          message: "Password must be greater than 8 char", error: true);
    }
    try {
      final headers = {'Content-Type': 'application/json'};
      final body =
          jsonEncode({"email": email, "name": name, "password": password});
      final response = await http.post(Uri.parse(Apis.register),
          headers: headers, body: body);

      var message = jsonDecode(response.body)['message'];
      var isError = jsonDecode(response.body)['error'];

      if (response.statusCode == 201) {
        return ApiReturnValue(message: message, error: isError);
      } else {
        return ApiReturnValue(message: message, error: true);
      }
    } catch (e) {
      log("[${DateTime.now()}] $e",
          error: "There is error when register", name: "Response");
      return ApiReturnValue(
          message: 'Error when register account', error: true);
    }
  }

  void checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getString('token') != '';
  }

  void setLogin(bool value) async {
    // isAuthenticated = value;
    // final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = value;
    // return prefs.getString('token') != null;
  }
}
