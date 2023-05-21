import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insighteye_app/Screens/Auth/login_src.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:insighteye_app/Screens/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

// ignore: must_be_immutable
class RegistrationScreen extends StatefulWidget {
  String? orgId;
  RegistrationScreen({Key? key, this.orgId}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  // our form key
  final _formKey = GlobalKey<FormState>();
  // editing Controller
  final firstNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> categorylist = ["Technician", "Supervisor"];
    return categorylist
        .map((value) => DropdownMenuItem(
              value: value,
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ))
        .toList();
  }

  String? selectedcategory;

  @override
  Widget build(BuildContext context) {
    //first name field
    final categoryselector = InputDecorator(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.category),
        contentPadding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
        hintText: "Category",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: selectedcategory,
          items: _dropDownItem(),
          onChanged: (value) {
            setState(() {
              selectedcategory = value;
            });
          },
          hint: const Text("Select category"),
          elevation: 12,
          style: const TextStyle(color: Colors.grey, fontSize: 16),
          icon: const Icon(Icons.arrow_drop_down_circle),
          iconDisabledColor: Colors.grey,
          iconEnabledColor: bluebg,
          isExpanded: true,
        ),
      ),
    );

    //email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          return null;
        },
        onSaved: (value) {
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordEditingController,
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
          firstNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //confirm password field
    final confirmPasswordField = TextFormField(
        autofocus: false,
        controller: confirmPasswordEditingController,
        obscureText: true,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "Password don't match";
          }
          return null;
        },
        onSaved: (value) {
          confirmPasswordEditingController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Confirm Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //signup button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: bluebg,
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            signUp(emailEditingController.text, passwordEditingController.text);
          },
          child: const Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: bluebg,
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(
                        height: 90,
                        child: Text(
                          "Staff Registration",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: bluebg,
                          ),
                        )),
                    const SizedBox(height: 10),
                    categoryselector,
                    const SizedBox(height: 20),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 20),
                    confirmPasswordField,
                    const SizedBox(height: 20),
                    signUpButton,
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    // check the Technitian status changer

    if (_formKey.currentState!.validate() && selectedcategory != null) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore(password)})
            // ignore: body_might_complete_normally_catch_error
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An Error occurred.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    } else {
      PanaraInfoDialog.show(
        context,
        title: "Oops",
        message: "Please verify feilds and Category",
        buttonText: "Okay",
        onTapDismiss: () {
          Navigator.pop(context);
        },
        panaraDialogType: PanaraDialogType.error,
        barrierDismissible: false,
        textColor: const Color(0XFF727272),
      );
    }
  }

  // ignore: curly_braces_in_flow_control_structures
  postDetailsToFirestore(String password) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    String? cata;

    if (selectedcategory == "Technician") {
      cata = "T";
    } else if (selectedcategory == "Supervisor") {
      cata = "S";
    }

    UserModel userModel = UserModel();

    // Update the diplayName
    user?.updateDisplayName("$cata${widget.orgId}");

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.category = selectedcategory;
    userModel.password = password;

    await firebaseFirestore
        .collection("organizations")
        .doc("${widget.orgId}")
        .collection("${selectedcategory?.toLowerCase()}")
        .doc(user.uid)
        .set(userModel.toMap())
        .then((value) {
      Fluttertoast.showToast(msg: "Account created successfully :) ");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginSrc()));
    });
  }
}
