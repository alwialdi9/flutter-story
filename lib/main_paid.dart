import 'package:asl/flavor_config.dart';
import 'package:asl/main.dart';
import 'package:asl/services/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sp = await SharedPreferences.getInstance();
  bool language = sp.getBool('enableID') ?? false;
  if (sp.getString('token') != '') {
    UserService().setLogin(true);
  }

  FlavorConfig(
    flavor: FlavorType.paid,
    values: const FlavorValues(
      titleApp: "Story Paid App",
    ),
  );

  runApp(MyApp(
    language: language,
  ));
}