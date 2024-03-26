part of 'middlewares.dart';

class UserMiddleware extends GetMiddleware {
  @override
  int? get priority => 0;

  bool isLogin = UserService().isAuth;

  @override
  RouteSettings? redirect(String? route) {
    // AuthService().checkLogin();
    // isCheckLogin();
    // final authService = isLogin;
    print(!isLogin);

    if (!isLogin) {
      print("kena disini");
      return const RouteSettings(name: '/signin');
    }
    print("gakena");

    return null;
  }

  // UserMiddleware({required this.priority});

  // Future<bool?> checkLogin() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   String token = prefs.getString('token') ?? '';
  //   print(token);
  //   return token != '';
  // }

  // bool isLogin = false;

  // void isCheckLogin() async {
  //   isLogin = (await checkLogin())!;
  // }

  
}
