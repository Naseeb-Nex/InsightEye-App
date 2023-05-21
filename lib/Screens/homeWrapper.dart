// ignore: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/screens/Office/homeoffice.dart';

import 'Admin/homeadminsrc.dart';
import 'Technician/hometech.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeWrapperState createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
  User? user = FirebaseAuth.instance.currentUser;
  String? userType;
  String? orgId;
  @override
  void initState() {
    super.initState();
    String displayName = user?.displayName ?? '';
    if (user != null && displayName != "") {
      setState(() {
        userType = displayName.substring(0, 1);
        orgId = displayName.substring(1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (userType == "T") {
      return HomeTech(orgId: orgId);
    } else if (userType == "A") {
      return HomeAdmin(orgId: orgId);
    }
    return const HomeOffice();
  }
}
