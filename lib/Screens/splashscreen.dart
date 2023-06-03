import 'dart:async';
import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/Auth/firebase_auth/authwrapper.dart';
import 'package:insighteye_app/constants/constants.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isVisible = false;

  _SplashScreenState() {
    Timer(const Duration(milliseconds: 2000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const AuthenticationWrapper()),
            (route) => false);
      });
    });

    Timer(const Duration(milliseconds: 10), () {
      setState(() {
        _isVisible =
            true; // Now it is showing fade effect and navigating to Login page
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO : Re Design the splash screen with animation
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).primaryColor
          ],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: const [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: const Duration(milliseconds: 1200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: SizedBox(
                height: 140.0,
                width: 140.0,
                child: Center(
                  child: Image.asset(
                      "assets/Icons/appicon.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "insightEye",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontWeight: FontWeight.w700,
                  fontSize: 33,
                  color: white,
                  decoration: TextDecoration.none),
            )
          ],
        ),
      ),
    );
  }
}
