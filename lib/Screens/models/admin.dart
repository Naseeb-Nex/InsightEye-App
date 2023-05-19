import 'package:cloud_firestore/cloud_firestore.dart';

class Admin {
  final String adminid;
  final String fname;
  final String email;
  final String pass;
  final String phn;

  const Admin({
    required this.fname,
    required this.pass,
    required this.adminid,
    required this.email,
    required this.phn,
  });

  Map<String, dynamic> toJson() => {
        "fname": fname,
        "pass": pass,
        "adminid": adminid,
        "email": email,
        "phn": phn,
      };

  static Admin fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Admin(
      fname: snapshot["fname"],
      pass: snapshot["pass"],
      adminid: snapshot["adminid"],
      email: snapshot["email"],
      phn: snapshot["phn"],
    );
  }
}
