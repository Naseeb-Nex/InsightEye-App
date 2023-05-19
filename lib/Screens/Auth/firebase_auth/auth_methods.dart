import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insighteye_app/Screens/models/admin.dart';
import 'package:insighteye_app/Screens/models/organization.dart';
import 'package:insighteye_app/constants/uuidgenerater.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<model.User> getUserDetails() async {
  //   User currentUser = _auth.currentUser!;

  //   DocumentSnapshot snap =
  //       await _firestore.collection('users').doc(currentUser.uid).get();

  //   return model.User.fromSnap(snap);
  // }

  //signup user
  Future<String> signUpUser({
    required String fname,
    required String pass,
    required String orgtype,
    required String orgname,
    required String email,
    required String phn,
    required String address,
  }) async {
    String res = " Some error Occured";
    try {
      if (email.isNotEmpty ||
          pass.isNotEmpty ||
          fname.isNotEmpty ||
          orgname.isNotEmpty ||
          phn.isNotEmpty ||
          address.isNotEmpty ||
          orgtype.isNotEmpty) {
        //reg user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: pass);

        final orgId = generateUniqueId();

        if (cred.user != null) {
        // Mounding Credntials
        await cred.user!.updateDisplayName("${orgId}A$fname");
      }

        //Register Orgnization
        Organization org = Organization(
          orgid: orgId,
          orgname: orgname,
          orgtype: orgtype,
          address: address,
        );

        Admin admin = Admin(
          adminid: cred.user!.uid,
          fname: fname,
          pass: pass,
          email: email,
          phn: phn,
        );

        await _firestore.collection('organizations').doc(orgId).set(
              org.toJson(),
            ).then((value)async =>{
              await _firestore.collection('organizations').doc(orgId).collection("admins").doc(cred.user!.uid).set(
              admin.toJson(),)
            });

        res = "Your Organization registered";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      res = err.toString();
    }
    Fluttertoast.showToast(msg: res);
    return res;
  }

  //logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } /*on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        res = 'user-not-found';
      } else if (err.code == 'wrong-password') {
        res = 'Password should be at least 6 characters';
      }
    }*/
    catch (err) {
      res = err.toString();
    }
    return res;
  }

  //sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
