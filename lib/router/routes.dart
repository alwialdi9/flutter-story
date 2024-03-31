import 'package:asl/ui/pages/pages.dart';
import 'package:get/get.dart';

class AppRoutes {
  final List<GetPage> listRoutes = [
    GetPage(name: '/signin', page: () => const SignInPage()),
    GetPage(name: '/signup', page: () => const SignUpPage()),
    GetPage(name: '/maps', page: () => const MapsPage()),
    GetPage(
        name: '/',
        page: () => const MainPage()),
    GetPage(
        name: '/detail_story',
        page: () => const DetailPage()),
  ];
}
