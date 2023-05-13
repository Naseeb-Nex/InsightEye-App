import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/Admin/admin_home_src.dart';
import 'package:insighteye_app/Screens/Auth/org_reg_src.dart';

import 'package:insighteye_app/components/theme_helper.dart';
import 'package:insighteye_app/constants/constants.dart';
// import 'package:insighteye_app/screens/registration_page.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginSrc extends StatefulWidget {
  const LoginSrc({Key? key}) : super(key: key);

  @override
  _LoginSrcState createState() => _LoginSrcState();
}

class _LoginSrcState extends State<LoginSrc> {
  // firebase Auth
  final _auth = FirebaseAuth.instance;
  // form key
  final _formKey = GlobalKey<FormState>();

  // string for displaying the error Message
  String? errorMessage;
  bool load = false;

  // Text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Responsive Size
    Size s = MediaQuery.of(context).size;

    return Container(
      width: s.width,
      height: s.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/Images/bg.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: trans,
        body: Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: s.height * 0.1094,
                    ),
                    Image.asset(
                      "assets/Icons/appicon.png",
                      width: 85,
                      height: 97,
                    ),
                    SizedBox(
                      height: s.height * 0.1041,
                    ),
                    Center(
                      child: Container(
                          width: s.width * 0.9,
                          height: s.height * 0.5302,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: const Color(0xFFFEFEFF)),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: s.width * 0.0864),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: s.height * 0.0520,
                                ),
                                const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: black,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Montserrat"),
                                ),
                                SizedBox(
                                  height: s.height * 0.0595,
                                ),
                                Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        TextFormField(
                                          autofocus: false,
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return ("Please Enter Your Email");
                                            }
                                            // reg expression for email validation
                                            if (!RegExp(
                                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                                .hasMatch(value)) {
                                              return ("Please Enter a valid email");
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            emailController.text = value!;
                                          },
                                          textInputAction: TextInputAction.next,
                                          decoration: InputDecoration(
                                            labelText: "Email Id",
                                            fillColor: Colors.white,
                                            filled: true,
                                            errorStyle: const TextStyle(
                                                fontFamily: "Montserrat"),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 10, 20, 10),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade400)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: const BorderSide(
                                                    color: Color(0XFFff0a54),
                                                    width: 2.0)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red,
                                                            width: 2.0)),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 30.0),
                                        TextFormField(
                                          autofocus: false,
                                          controller: passwordController,
                                          obscureText: true,
                                          validator: (value) {
                                            RegExp regex = RegExp(r'^.{6,}$');
                                            if (value!.isEmpty) {
                                              return ("Password is required for login");
                                            }
                                            if (!regex.hasMatch(value)) {
                                              return ("Enter Valid Password(Min. 6 Character)");
                                            }
                                            return null;
                                          },
                                          onSaved: (value) {
                                            passwordController.text = value!;
                                          },
                                          textInputAction: TextInputAction.done,
                                          decoration: InputDecoration(
                                            labelText: "Password",
                                            fillColor: Colors.white,
                                            filled: true,
                                            errorStyle: const TextStyle(
                                                fontFamily: "Montserrat"),
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 10, 20, 10),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: const BorderSide(
                                                    color: Colors.grey)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade400)),
                                            errorBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                                borderSide: const BorderSide(
                                                    color: Color(0XFFff0a54),
                                                    width: 2.0)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.0),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Color(
                                                                0XFFff4d6d),
                                                            width: 2.0)),
                                          ),
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                          ),
                                        ),
                                        const SizedBox(height: 15.0),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 0, 10, 20),
                                          alignment: Alignment.topRight,
                                          child: GestureDetector(
                                            onTap: () {
                                              // Navigator.push(
                                              //   context,
                                              //   MaterialPageRoute(
                                              //       builder: (context) =>
                                              //           const ForgotPasswordPage()),
                                              // );
                                            },
                                            child: const Text(
                                              "Forgot your password?",
                                              style: TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: "Montserrat"),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.deepPurple.shade300,
                                            gradient: const LinearGradient(
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                              stops: [0.0, 0.5, 1.0],
                                              colors: [
                                                Color(0XFF5f5bfd),
                                                Color(0XFF8725FA),
                                                Color(0XFFbf00ff),
                                              ],
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  offset: Offset(0, 4),
                                                  blurRadius: 5.0)
                                            ],
                                          ),
                                          child: ElevatedButton(
                                            style: ThemeHelper().buttonStyle(),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      40, 10, 40, 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Login'.toUpperCase(),
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontFamily:
                                                            "Montserrat"),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                      child: load
                                                          ? const SizedBox(
                                                              height: 15,
                                                              width: 15,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                      color:
                                                                          white))
                                                          : null),
                                                ],
                                              ),
                                            ),
                                            onPressed: () {
                                              signIn(emailController.text,
                                                  passwordController.text);
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.fromLTRB(
                                              10, 20, 10, 20),
                                          //child: Text('Don\'t have an account? Create'),
                                          child: Text.rich(TextSpan(children: [
                                            const TextSpan(
                                                text:
                                                    "Setup Your Organization ",
                                                style: TextStyle(
                                                    fontFamily: "Montserrat")),
                                            TextSpan(
                                              text: 'Here',
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              OrgRegistrationSrc()));
                                                },
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat",
                                                color: Color(0XFF8725FA),
                                              ),
                                            ),
                                          ])),
                                        ),
                                      ],
                                    )),
                              ],
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // login function
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        load = true;
      });
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const AdminHomeSrc())),
                });
        setState(() {
          load = false;
        });
      } on FirebaseAuthException catch (error) {
        setState(() {
          load = false;
        });
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";

            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "userLogin-found":
            errorMessage = "Login this email doesn't exist.";
            break;
          case "userLogin":
            errorMessage = "Login this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Something went wrong.. Try again!";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage =
                "Something went wrong. Please check your internet connection?";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }
}
