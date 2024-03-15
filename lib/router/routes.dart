import 'package:asl/ui/pages/pages.dart';
import 'package:get/get.dart';

class AppRoutes {
  static final listRoutes = [
    GetPage(name: '/', page: () => const SignInPage()),
    GetPage(name: '/signup', page: () => const SignUpPage()),
    GetPage(name: '/home', page: () => const MainPage())
  ];
}