import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/splashscreen.dart';

import 'Screens/initial Screen/introScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

    Color _primaryColor= Color(0XFF651BD2);
  Color _accentColor= Color(0XFF320181);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InsightEye',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        primarySwatch: Colors.grey,
        scaffoldBackgroundColor: Color(0xFFEEF1F8),
        fontFamily: "Montserrat",
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          errorStyle: TextStyle(height: 0),
        ),
      ),
      home:  SplashScreen(),
    );
  }
}