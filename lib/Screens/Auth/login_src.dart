import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:insighteye_app/components/theme_helper.dart';
import 'package:insighteye_app/constants/constants.dart';
// import 'package:insighteye_app/screens/registration_page.dart';

// import 'forgot_password_page.dart';
import 'widgets/header_widget.dart';

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

  double _headerHeight = 250;

  // Text controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: const EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hey,',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                      const Text(
                        'Login Now',
                        style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                      const SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                autofocus: false,
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
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
                                decoration: ThemeHelper().textInputDecoration(
                                    'Email id', 'Enter your Email id'),
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
                                },
                                onSaved: (value) {
                                  passwordController.text = value!;
                                },
                                textInputAction: TextInputAction.done,
                                decoration: ThemeHelper().textInputDecoration(
                                    'Password', 'Enter your password'),
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 15.0),
                              Container(
                                margin:
                                    const EdgeInsets.fromLTRB(10, 0, 10, 20),
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
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Sign In'.toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: "Montserrat"),
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
                                                            color: white))
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
                                margin:
                                    const EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  const TextSpan(
                                      text: "Don\'t have an account? ",
                                      style:
                                          TextStyle(fontFamily: "Montserrat")),
                                  TextSpan(
                                    text: 'Create',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Montserrat",
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
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
                  // Navigator.of(context).pushReplacement(MaterialPageRoute(
                  //     builder: (context) => const MainNavScreen())),
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
