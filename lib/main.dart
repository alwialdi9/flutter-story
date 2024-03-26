import 'package:asl/cubit/cubit.dart';
import 'package:asl/extentions/translation.dart';
import 'package:asl/router/routes.dart';
import 'package:asl/services/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sp = await SharedPreferences.getInstance();
  bool language = sp.getBool('enableID') ?? false;
  if (sp.getString('token') != '') {
    UserService().setLogin(true);
  }

  runApp(MyApp(
    // token: token,
    language: language,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.language});
  // final String token;
  final bool language;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserCubit()),
        BlocProvider(create: (_) => StoryCubit()),
        BlocProvider(create: (_) => ImageCubit()),
      ],
      child: GetMaterialApp.router(
        title: 'Story App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        getPages: AppRoutes().listRoutes,
        initialBinding: BindingsBuilder(() {
          Get.put(UserService());
        }),
        translations: Messages(),
        locale: language ? const Locale('id', 'ID') : const Locale('en', 'US'),
      ),
    );
  }
}
