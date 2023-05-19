import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insighteye_app/Screens/Admin/admin_home_src.dart';
import 'package:insighteye_app/Screens/Auth/login_src.dart';
import 'package:provider/provider.dart';


class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();

    if (firebaseUser != null) {
      return const AdminHomeSrc();
    }
    return const LoginSrc();
  }
}