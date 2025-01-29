import 'package:app/core/utils/token_preference.dart';
import 'package:app/pages/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  TokenPreference.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Color(0xFF493AD5),
          scaffoldBackgroundColor: Color(0xFF5f5f5)),
      home: SplashScreen(),
    );
  }
}
