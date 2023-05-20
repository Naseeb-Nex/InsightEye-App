import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/models/authentication.dart';
import 'package:insighteye_app/Screens/splashscreen.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:provider/provider.dart';

// DatePicker
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        locale: const Locale('en', 'US'),
        supportedLocales: const[
           Locale('en', 'US'), // English
        ],
        title: 'InsightEye',
        theme: ThemeData(
          primaryColor: primaryColor,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: accentColor),
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: const Color(0xFFEEF1F8),
          fontFamily: "Montserrat",
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            errorStyle: TextStyle(height: 0),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}