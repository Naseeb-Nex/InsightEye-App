import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:insighteye_app/Screens/Auth/orgdetails_src.dart';
import 'package:insighteye_app/Screens/homeWrapper.dart';

import 'package:insighteye_app/components/styles.dart';
import 'package:insighteye_app/constants/constants.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginSrc extends StatefulWidget {
  const LoginSrc({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/Images/bg.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: trans,
        body: SafeArea(
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
                    // height: s.height * 0.5302,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0XFFFEFEFF).withOpacity(0.4),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: s.width * 0.0864),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: s.height * 0.0520,
                          ),
                          const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 30,
                                color: white,
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
                                    cursorColor: white,
                                    decoration:
                                        Styles().SimpleInputDec("Email Id"),
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      color: white,
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
                                    onFieldSubmitted: (value) => signIn(
                                      emailController.text,
                                      passwordController.text,
                                    ),
                                    textInputAction: TextInputAction.done,
                                    cursorColor: white,
                                    decoration:
                                        Styles().SimpleInputDec("Password"),
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 15,
                                      color: white,
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
                                            color: white,
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
                                        stops: [0.0, 1.0],
                                        colors: [
                                          Color(0XFF7A43AB),
                                          Color(0XFF57308D),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Colors.black26,
                                            offset: Offset(0, 4),
                                            blurRadius: 5.0)
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      style: Styles().buttonStyle(),
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
                                              'Login'.toUpperCase(),
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
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 20, 10, 20),
                                    //child: Text('Don\'t have an account? Create'),
                                    child: Text.rich(TextSpan(children: [
                                      const TextSpan(
                                          text: "Setup Your Organization ",
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
                                                        const OrgDetailsScreen()));
                                          },
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Montserrat",
                                          color:
                                              Color.fromARGB(255, 74, 13, 159),
                                        ),
                                      ),
                                    ])),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                      builder: (context) => const HomeWrapper())),
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
          case "invalid-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User Not Found.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests. Please try again later.";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "Email id or Password is incorrect";
        }

        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }
}
