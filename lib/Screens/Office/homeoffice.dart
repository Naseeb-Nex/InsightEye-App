import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/constants/constants.dart';

import 'package:insighteye_app/Screens/Auth/login_src.dart';

class HomeOffice extends StatefulWidget {
  const HomeOffice({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeOfficeState createState() => _HomeOfficeState();
}

class _HomeOfficeState extends State<HomeOffice> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Icons/warning.png",
                  width: s.width * 0.5,
                  height: s.height * 0.3,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Oops! Something went wrong",
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "Nunito",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cheryred,
                  ),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.width * 0.1),
                  child: const Text(
                    "You are login form the wrong email check the email id and log in again... : )",
                    softWrap: true,
                    style: TextStyle(
                      fontFamily: "Nunito",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: s.height * 0.05),
                InkWell(
                  onTap: () => logout(context),
                  child: Container(
                    width: s.width * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: redbg,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              color: black.withOpacity(0.1))
                        ]),
                    child: const Center(
                      child: Text(
                        "LogOut",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15,
                            color: cheryred,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => const LoginSrc()));
  }
}
