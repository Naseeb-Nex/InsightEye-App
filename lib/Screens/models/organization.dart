import 'package:cloud_firestore/cloud_firestore.dart';

class Organization {
  final String orgid;
  final String orgname;
  final String orgtype;
  final String address;

  const Organization({
    required this.orgid,
    required this.orgtype,
    required this.orgname,
    required this.address,
  });
  
  // sending data to our server
  Map<String, dynamic> toJson() => {
        "orgid": orgid,
        "orgname": orgname,
        "orgtype": orgtype,
        "address": address,
      };

  static Organization fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Organization(
      orgid: snapshot["orgid"],
      orgname: snapshot["orgname"],
      orgtype: snapshot["orgtype"],
      address: snapshot["address"],
    );
  }
}
