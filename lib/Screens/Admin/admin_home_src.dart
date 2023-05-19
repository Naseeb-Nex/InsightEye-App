import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/Auth/firebase_auth/auth_methods.dart';
import 'package:insighteye_app/Screens/Auth/login_src.dart';

class AdminHomeSrc extends StatefulWidget {
  const AdminHomeSrc({super.key});

  @override
  State<AdminHomeSrc> createState() => _AdminHomeSrcState();
}

class _AdminHomeSrcState extends State<AdminHomeSrc> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Icons/home.png",
                  width: s.width,
                  height: s.height * 0.4,
                  fit: BoxFit.cover,
                ),
                const Text(
                  "Admin Home",
                  softWrap: true,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 40,
                    fontWeight: FontWeight.w600,
                    color: Colors.deepPurple,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: s.height * 0.05),
                InkWell(
                  onTap: () {
                    AuthMethods().signOut();
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginSrc()));
                    },
                  child: Container(
                    width: s.width * 0.4,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.deepPurple.shade200,
                        boxShadow: [
                          BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 3,
                              color: Colors.black.withOpacity(0.1))
                        ]),
                    child: Center(
                      child: Text(
                        "LogOut",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 15,
                            color: Colors.white,
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
}