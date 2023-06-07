import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/main_app.dart';
import 'package:get/get.dart';

import 'config/http_config.dart';
import 'login.dart';
import 'utils/app_preference.dart';
import 'utils/locale.dart';


Future<void> main() async {

  // config HTTP
/*  HttpOverrides.global =  MyHttpOverrides();*/

  //  Ensure Widget Initialized
  WidgetsFlutterBinding.ensureInitialized();

  // init preference
  await AppPreference.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: LocaleString(),
        home: AppPreference.getLogin().isNull ? LoginScreen() : MainAppScreen());
  }
}
