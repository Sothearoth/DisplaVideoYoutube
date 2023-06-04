import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login.dart';
import 'utils/app_preference.dart';
import 'utils/locale.dart';


Future<void> main() async {
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
        home: LoginScreen());
  }
}
