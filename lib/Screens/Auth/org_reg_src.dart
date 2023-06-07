import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/Auth/firebase_auth/auth_methods.dart';
import 'package:insighteye_app/Screens/Auth/login_src.dart';
import 'package:insighteye_app/Screens/homeWrapper.dart';
import 'package:insighteye_app/constants/constants.dart';

// ignore: must_be_immutable
class OrgRegistrationSrc extends StatefulWidget {
  String? orgname;
  String? orgtype;
  String? orgAddress;

  OrgRegistrationSrc({super.key, this.orgname, this.orgtype, this.orgAddress});

  @override
  State<StatefulWidget> createState() {
    return _OrgRegistrationSrcState();
  }
}

class _OrgRegistrationSrcState extends State<OrgRegistrationSrc> {
  bool checkboxValue = false;
  bool checkedValue = false;
  FirebaseFirestore fb = FirebaseFirestore.instance;
  bool vLoading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();
  // Form Key
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();
  final TextEditingController _phnController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cpasswordController.dispose();
    _phnController.dispose();
  }

  void signUpUser() async {
    print("wokring");
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      fname: _fullnameController.text,
      orgname: "${widget.orgname}",
      email: _emailController.text,
      pass: _passwordController.text,
      orgtype: "${widget.orgtype}",
      phn: _phnController.text,
      address: "${widget.orgAddress}",
    );

    if (res == "Your Organization registered") {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeWrapper(),
          ),
          (route) => false);
      setState(() {
        _isLoading = false;
      });

      //
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginSrc(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Responsive Size
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
        backgroundColor: Colors.transparent,
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: s.height * 0.1382,
              ),
              Center(
                child: Container(
                  width: s.width * 0.9,
                  height: s.height * 0.6771,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(41),
                      color: const Color(0xFFFEFEFF)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: s.width * 0.0864),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: s.height * 0.0529,
                        ),
                        const Text(
                          'Admin Login',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Montserrat"),
                        ),
                        SizedBox(
                          height: s.height * 0.0367,
                        ),
                        Form(
                          key: _formKey,
                            child: Column(
                          children: [
                            TextFormField(
                              autofocus: false,
                              controller: _fullnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Name can't be Empty");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _fullnameController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Admin Name",
                                fillColor: Colors.white,
                                filled: true,
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: s.height * 0.0269),
                            TextFormField(
                              controller: _phnController,
                              onSaved: (value) {
                                _phnController.text = value!;
                              },
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Phone Number feild can't be empty");
                                } else if (value.length != 10) {
                                  return ("invalid Phone Number");
                                }
                                return null;
                              },
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Admin Ph:",
                                fillColor: Colors.white,
                                filled: true,
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: s.height * 0.0269),
                            TextFormField(
                              controller: _emailController,
                              onSaved: (value) {
                                _emailController.text = value!;
                              },
                              keyboardType: TextInputType.emailAddress,
                              autofocus: false,
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
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Admin Email",
                                fillColor: Colors.white,
                                filled: true,
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: s.height * 0.0269,
                            ),
                            TextFormField(
                              controller: _passwordController,
                              onSaved: (value) {
                                _passwordController.text = value!;
                              },
                              textInputAction: TextInputAction.next,
                              obscureText: true,
                              validator: (val) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (val!.isEmpty) {
                                  return ("Password is required for login");
                                }
                                if (!regex.hasMatch(val)) {
                                  return ("Enter Valid Password(Min. 6 Character)");
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Password",
                                fillColor: Colors.white,
                                filled: true,
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: s.height * 0.0269,
                            ),
                            TextFormField(
                              controller: _cpasswordController,
                              onSaved: (value) {
                                _cpasswordController.text = value!;
                              },
                              textInputAction: TextInputAction.done,
                              obscureText: true,
                              validator: (value) {
                                if (_cpasswordController.text !=
                                    _passwordController.text) {
                                  return "Password don't match";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Conform Password",
                                fillColor: Colors.white,
                                filled: true,
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: s.height * 0.0372,
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
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 5.0)
                                ],
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all(
                                      const Size(50, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: _isLoading
                                      ? const Center(
                                          child: CircularProgressIndicator(
                                            color: white,
                                          ),
                                        )
                                      : Text(
                                          "See Plans".toUpperCase(),
                                          style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontFamily: "Montserrat"),
                                        ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    signUpUser();
                                  }
                                },
                              ),
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
