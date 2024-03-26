import 'package:asl/middlewares/middlewares.dart';
import 'package:asl/ui/pages/pages.dart';
import 'package:get/get.dart';

class AppRoutes {
  final List<GetPage> listRoutes = [
    GetPage(name: '/signin', page: () => const SignInPage()),
    GetPage(name: '/signup', page: () => const SignUpPage()),
    GetPage(
        name: '/',
        page: () => const MainPage()),
        // middlewares: [UserMiddleware()]),
    GetPage(
        name: '/detail_story',
        page: () => const DetailPage()),
        // middlewares: [UserMiddleware()]),
  ];
}
