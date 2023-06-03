import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/Auth/firebase_auth/auth_methods.dart';
import 'package:insighteye_app/Screens/Auth/login_src.dart';
import 'package:insighteye_app/Screens/homeWrapper.dart';
import 'package:insighteye_app/components/styles.dart';
import 'package:insighteye_app/constants/constants.dart';

class OrgRegistrationSrc extends StatefulWidget {
  const OrgRegistrationSrc({super.key});

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
  final TextEditingController _orgnameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _orgtypeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phnController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _fullnameController.dispose();
    _orgnameController.dispose();
    _emailController.dispose();
    _orgtypeController.dispose();
    _passwordController.dispose();
    _addressController.dispose();
    _phnController.dispose();
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
      fname: _fullnameController.text,
      orgname: _orgnameController.text,
      email: _emailController.text,
      pass: _passwordController.text,
      orgtype: _orgtypeController.text,
      phn: _orgtypeController.text,
      address: _addressController.text,
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // Full Name Text Feild
                        TextFormField(
                          controller: _fullnameController,
                          onSaved: (value) {
                            _fullnameController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: Styles().SimpleInputDec('Full Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please enter the Full Name");
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // Oragnization Name Text Feild
                        TextFormField(
                          controller: _orgnameController,
                          onSaved: (value) {
                            _orgnameController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration:
                              Styles().SimpleInputDec('Orgnization Name'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please enter the Orgnization Name");
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // Oragnization Type Text Feild
                        TextFormField(
                          controller: _orgtypeController,
                          onSaved: (value) {
                            _orgtypeController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration:
                              Styles().SimpleInputDec('Orgnization Type'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please enter the Orgnization Type");
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // Organization Address Text Feild
                        TextFormField(
                          controller: _addressController,
                          onSaved: (value) {
                            _addressController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration:
                              Styles().SimpleInputDec('Organization Address'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Please enter the Organization Address");
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _phnController,
                          onSaved: (value) {
                            _phnController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          decoration: Styles().SimpleInputDec("Mobile Number"),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return ("Phone Number feild can't be empty");
                            } else if (value.length != 10) {
                              return ("invalid Phone Number");
                            }
                            return null;
                          },
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        // Email
                        TextFormField(
                          controller: _emailController,
                          onSaved: (value) {
                            _emailController.text = value!;
                          },
                          decoration: Styles().SimpleInputDec("E-mail address"),
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
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: _passwordController,
                          onSaved: (value) {
                            _passwordController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          decoration: Styles().SimpleInputDec("Password*"),
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
                          style: const TextStyle(
                            fontFamily: "Montserrat",
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    const Text(
                                      "I accept all terms and conditions.",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "Montserrat"),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        fontSize: 12,
                                        fontFamily: "Montserrat"),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: Styles().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: Styles().buttonStyle(),
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
                                      "Register".toUpperCase(),
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
                        ),
                        const SizedBox(height: 30.0),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        child: const Text(
                          "Have an account?",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: navigateToLogin,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: const Text(
                            " Log in.",
                            style: TextStyle(
                              fontFamily: "Montserrat",
                              color: bluebg,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
