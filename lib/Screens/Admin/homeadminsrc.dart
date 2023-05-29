import 'package:flutter/material.dart';
import 'package:insighteye_app/screens/Admin/monthlyreportsrc.dart';
import 'package:insighteye_app/screens/Admin/vechicleportal.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:insighteye_app/constants/constants.dart';

import 'package:insighteye_app/components/techreportcard.dart';

import 'package:insighteye_app/Screens/models/user_model.dart';
// Iconsax
import 'package:iconsax/iconsax.dart';

import 'pendingpgmlistingsrc.dart';
import 'package:insighteye_app/screens/Admin/competedpgmsrc.dart';
import 'package:insighteye_app/screens/Admin/confirmationlist.dart';
import 'package:insighteye_app/Screens/Auth/login_src.dart';
import 'package:insighteye_app/screens/register.dart';
import 'package:insighteye_app/screens/Admin/techprofile.dart';
import 'package:insighteye_app/screens/Admin/techstatus.dart';

class HomeAdmin extends StatefulWidget {
  const HomeAdmin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeAdminState createState() => _HomeAdminState();
}

class _HomeAdminState extends State<HomeAdmin> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  FirebaseFirestore fb = FirebaseFirestore.instance;
  int p = 0, c = 0;
  int touchedIndex = 0;
  bool rpstatus = false;
  String? orgId;
  String? uid;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      String displayName = user?.displayName ?? '';
      if (user != null && displayName != "") {
        setState(() {
          orgId = displayName.substring(1);
          uid = user?.uid;
        });
      }
      pgmsetup();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    // Date
    DateTime now = DateTime.now();

    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    return Stack(fit: StackFit.expand, children: [
      Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(38, 0, 91, 1),
              Color.fromRGBO(55, 48, 255, 1),
            ],
            begin: FractionalOffset.center,
            end: FractionalOffset.topCenter,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(
            backgroundColor: const Color(0XFF403795),
            child: Builder(
              builder: (context) => SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: s.height * 0.2,
                        decoration: BoxDecoration(
                          // borderRadius: BorderRadius.only(
                          //   bottomLeft: Radius.circular(20),
                          //   bottomRight: Radius.circular(20),
                          // ),
                          borderRadius: BorderRadius.circular(25),
                          image: const DecorationImage(
                            image: AssetImage("assets/Icons/drawyerbg.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(s.height * 0.01),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/Icons/admin.png",
                                height: s.height * 0.12,
                              ),
                              const Center(
                                child: Text(
                                  "Admin",
                                  style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      // Navigation List

                      Padding(
                        padding: EdgeInsets.only(
                            left: s.width * 0.04,
                            right: s.width * 0.1,
                            bottom: s.height * 0.03,
                            top: s.height * 0.03),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(s.width * 0.02),
                              child: InkWell(
                                onTap: () => Scaffold.of(context).closeDrawer(),
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: white),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Iconsax.home,
                                        color: white,
                                      ),
                                      SizedBox(
                                        width: s.width * 0.04,
                                      ),
                                      const Text(
                                        "Home",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(s.width * 0.02),
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).closeDrawer();
                                },
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Monthlyrepotsrc(
                                                orgId: orgId,
                                              ))),
                                  // TODO: https://dribbble.com/shots/20780383-Fitness-App follow this link to design
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: white),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Iconsax.receipt_1,
                                          color: white,
                                        ),
                                        SizedBox(
                                          width: s.width * 0.04,
                                        ),
                                        const Text(
                                          "Monthly Report",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 15,
                                            fontWeight: FontWeight.normal,
                                            color: white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(s.width * 0.02),
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).closeDrawer();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RegistrationScreen(
                                                  orgId: orgId)));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: white),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Iconsax.user_add,
                                        color: white,
                                      ),
                                      SizedBox(
                                        width: s.width * 0.04,
                                      ),
                                      const Text(
                                        "Staff Registration",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(s.width * 0.02),
                              child: InkWell(
                                onTap: () {
                                  Scaffold.of(context).closeDrawer();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((BuildContext context) =>
                                              Vehicleportal(
                                                orgId: orgId,
                                              ))));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: white),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Iconsax.truck,
                                        color: white,
                                      ),
                                      SizedBox(
                                        width: s.width * 0.04,
                                      ),
                                      const Text(
                                        "Vehicle Portal",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal,
                                          color: white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
        appBar: AppBar(
          centerTitle: true,
          leading: Builder(
            builder: (context) => InkWell(
              onTap: () => Scaffold.of(context).openDrawer(),
              child: Padding(
                padding: EdgeInsets.all(s.width * 0.03),
                child: Image.asset(
                  "assets/Icons/menu.png",
                  color: white,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: InkWell(
                onTap: () => logout(context),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.asset("assets/Icons/logout.png"),
                ),
              ),
            )
          ],
          elevation: 0,
          title: const Text(
            "Admin Panel",
            style: TextStyle(
              fontFamily: "Nunito",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Container(
                  width: s.width,
                  height: s.height * 0.1,
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: s.height * 0.009),
                      const TabBar(
                        tabs: [
                          Tab(
                            text: "Home",
                          ),
                          Tab(
                            text: "Report",
                          )
                        ],
                        labelColor: white,
                        indicatorColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        // indicatorWeight: ,
                        padding: EdgeInsets.only(left: 30, right: 30),
                        unselectedLabelColor: Color(0xFF636bff),

                        // Rectangular Indicator

                        // indicatorSize: TabBarIndicatorSize.tab,
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: s.width * 0.1),
                        // indicator: BoxDecoration(
                        //     gradient: LinearGradient(colors: [
                        //       Color(0XFF90caf9),
                        //       Color(0xff1e88e5)
                        //     ]),
                        //     borderRadius: BorderRadius.circular(50),
                        //     color: Colors.white),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40)),
                      color: Color(0Xffedf2fb),
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: TabBarView(
                      children: [
                        RefreshIndicator(
                          onRefresh: () => pgmsetup(),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 20,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          color: black.withOpacity(.1),
                                          offset: const Offset(-1, 2),
                                        ),
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Program Status",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 22,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      // Row(
                                      //   children: [
                                      //     InkWell(
                                      //       onTap: () => Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   const Pendingsrc())),
                                      //       child: Container(
                                      //         padding: EdgeInsets.all(10),
                                      //         decoration: BoxDecoration(
                                      //             borderRadius:
                                      //                 BorderRadius.circular(
                                      //                     20),
                                      //             color: white,
                                      //             boxShadow: [
                                      //               BoxShadow(
                                      //                 spreadRadius: 1,
                                      //                 blurRadius: 3,
                                      //                 color: black
                                      //                     .withOpacity(.1),
                                      //                 offset: Offset(-1, 2),
                                      //               ),
                                      //             ]),
                                      //         child: Flexible(
                                      //           flex: 1,
                                      //           fit: FlexFit.loose,
                                      //           child: Column(
                                      //             children: [
                                      //               Container(
                                      //                 decoration: BoxDecoration(
                                      //                     borderRadius:
                                      //                         BorderRadius
                                      //                             .circular(25),
                                      //                     color: const Color(
                                      //                         0XFFFED4D6),
                                      //                     boxShadow: [
                                      //                       BoxShadow(
                                      //                         spreadRadius: 1,
                                      //                         blurRadius: 3,
                                      //                         color: Colors
                                      //                             .black
                                      //                             .withOpacity(
                                      //                                 0.2),
                                      //                         offset:
                                      //                             const Offset(
                                      //                                 0, 5),
                                      //                       ),
                                      //                     ]),
                                      //                 child: Column(
                                      //                   mainAxisAlignment:
                                      //                       MainAxisAlignment
                                      //                           .center,
                                      //                   crossAxisAlignment:
                                      //                       CrossAxisAlignment
                                      //                           .center,
                                      //                   children: [
                                      //                     const Text(
                                      //                       "Pending",
                                      //                       style: TextStyle(
                                      //                         fontFamily:
                                      //                             "Nunito",
                                      //                         fontSize: 19,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold,
                                      //                         color: Color(
                                      //                             0XFFff5c8a),
                                      //                       ),
                                      //                       textAlign: TextAlign
                                      //                           .center,
                                      //                       maxLines: 2,
                                      //                     ),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                                   .only(
                                      //                               top: 10),
                                      //                       child: Text(
                                      //                         "$p",
                                      //                         style:
                                      //                             const TextStyle(
                                      //                           fontFamily:
                                      //                               "Nunito",
                                      //                           fontSize: 19,
                                      //                           fontWeight:
                                      //                               FontWeight
                                      //                                   .bold,
                                      //                           color: Color(
                                      //                               0XFFff5c8a),
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     InkWell(
                                      //       onTap: () => Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   const Completedpgmsrc())),
                                      //       child: Flexible(
                                      //         fit: FlexFit.tight,
                                      //         child: Container(
                                      //           padding: EdgeInsets.all(10),
                                      //           decoration: BoxDecoration(
                                      //               borderRadius:
                                      //                   BorderRadius.circular(
                                      //                       20),
                                      //               color: white,
                                      //               boxShadow: [
                                      //                 BoxShadow(
                                      //                   spreadRadius: 1,
                                      //                   blurRadius: 3,
                                      //                   color: black
                                      //                       .withOpacity(.1),
                                      //                   offset: Offset(-1, 2),
                                      //                 ),
                                      //               ]),
                                      //           child: Column(
                                      //             children: [
                                      //               Container(
                                      //                 decoration: BoxDecoration(
                                      //                     borderRadius:
                                      //                         BorderRadius
                                      //                             .circular(25),
                                      //                     color: const Color(
                                      //                         0XFFDBF4F1),
                                      //                     boxShadow: [
                                      //                       BoxShadow(
                                      //                         spreadRadius: 1,
                                      //                         blurRadius: 3,
                                      //                         color: Colors
                                      //                             .black
                                      //                             .withOpacity(
                                      //                                 0.2),
                                      //                         offset:
                                      //                             const Offset(
                                      //                                 0, 5),
                                      //                       ),
                                      //                     ]),
                                      //                 child: Column(
                                      //                   mainAxisAlignment:
                                      //                       MainAxisAlignment
                                      //                           .center,
                                      //                   crossAxisAlignment:
                                      //                       CrossAxisAlignment
                                      //                           .center,
                                      //                   children: [
                                      //                     const Text(
                                      //                       "Completed",
                                      //                       style: TextStyle(
                                      //                         fontFamily:
                                      //                             "Nunito",
                                      //                         fontSize: 19,
                                      //                         fontWeight:
                                      //                             FontWeight
                                      //                                 .bold,
                                      //                         color: Color(
                                      //                             0XFF52b788),
                                      //                       ),
                                      //                       textAlign: TextAlign
                                      //                           .center,
                                      //                       maxLines: 2,
                                      //                     ),
                                      //                     Padding(
                                      //                       padding:
                                      //                           const EdgeInsets
                                      //                                   .only(
                                      //                               top: 10),
                                      //                       child: Text(
                                      //                         "$p",
                                      //                         style:
                                      //                             const TextStyle(
                                      //                           fontFamily:
                                      //                               "Nunito",
                                      //                           fontSize: 19,
                                      //                           fontWeight:
                                      //                               FontWeight
                                      //                                   .bold,
                                      //                           color: Color(
                                      //                               0XFFff5c8a),
                                      //                         ),
                                      //                       ),
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //               ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      Row(
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: InkWell(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PendingPgmListingSrc(
                                                            orgId: orgId,
                                                          ))),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 3,
                                                        color: black
                                                            .withOpacity(.1),
                                                        offset:
                                                            const Offset(-1, 2),
                                                      ),
                                                    ]),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                              .blue.shade50),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Image.asset(
                                                        "assets/Icons/pending.png",
                                                        width: 20,
                                                        height: 20,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFFff5c8a),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const Text(
                                                      "Programs",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFFff5c8a),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      "$p",
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFFff5c8a),
                                                        fontSize: 27,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            flex: 1,
                                            fit: FlexFit.tight,
                                            child: InkWell(
                                              onTap: () => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Completedpgmsrc(
                                                            orgId: orgId,
                                                          ))),
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        spreadRadius: 1,
                                                        blurRadius: 3,
                                                        color: black
                                                            .withOpacity(.1),
                                                        offset:
                                                            const Offset(-1, 2),
                                                      ),
                                                    ]),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Colors
                                                              .blue.shade50),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10),
                                                      child: Image.asset(
                                                        "assets/Icons/completed.png",
                                                        width: 22,
                                                        height: 22,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const Text(
                                                      "Completed",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFF52b788),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const Text(
                                                      "Programs",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFF52b788),
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    const SizedBox(height: 15),
                                                    Text(
                                                      "$c",
                                                      style: const TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color:
                                                            Color(0XFF52b788),
                                                        fontSize: 27,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: InkWell(
                                  onTap: (() => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Confirmationlist(
                                                orgId: orgId,
                                              )))),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 15),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: white,
                                        boxShadow: [
                                          BoxShadow(
                                              spreadRadius: 2,
                                              blurRadius: 7,
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: const Offset(5, 0))
                                        ]),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Image.asset(
                                                  "assets/Icons/confimmsg.png",
                                                )),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              "Confirmation List",
                                              style: TextStyle(
                                                fontFamily: "Montserrat",
                                                fontSize: 17,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: fb
                                              .collection("organizations")
                                              .doc("$orgId")
                                              .collection('ConfirmList')
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasError) {
                                              print('Something went Wrong');
                                            }
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 10),
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: limegreen2),
                                                  padding:
                                                      const EdgeInsets.all(11),
                                                  child: const Text(
                                                    "0",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: white),
                                                  ),
                                                ),
                                              );
                                            }

                                            String? confimsize = snapshot
                                                .data!.docs.length
                                                .toString();

                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 10),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: confimsize == "0"
                                                        ? limegreen2
                                                        : cheryred),
                                                padding:
                                                    const EdgeInsets.all(11),
                                                child: Text(
                                                  confimsize,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: white),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Technician Status",
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                height: 300,
                                child: Center(
                                    child: Techcardspace(
                                  orgId: orgId,
                                )),
                              ),
                              const SizedBox(
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                        RefreshIndicator(
                          onRefresh: () => pgmsetup(),
                          child: ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              SizedBox(
                                height: s.height * 0.03,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: s.width * 0.03),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: s.width * 0.06,
                                      vertical: s.height * 0.03),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            color: black.withOpacity(0.1))
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "OVERVIEW",
                                        style: TextStyle(
                                            color: bluebg,
                                            fontFamily: "Montserrat",
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Divider(
                                        endIndent: 10,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      AspectRatio(
                                        aspectRatio: 1.3,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: rpstatus
                                              ? StreamBuilder<
                                                  DocumentSnapshot<
                                                      Map<String, dynamic>>>(
                                                  stream: fb
                                                      .collection(
                                                          "organizations")
                                                      .doc("$orgId")
                                                      .collection("Reports")
                                                      .doc(year)
                                                      .collection("Month")
                                                      .doc(month)
                                                      .collection(day)
                                                      .doc("Counter")
                                                      .snapshots(),
                                                  builder: (_, snapshot) {
                                                    if (snapshot.hasError) {
                                                      return Text(
                                                          'Error = ${snapshot.error}');
                                                    }

                                                    if (snapshot.hasData) {
                                                      var output =
                                                          snapshot.data!.data();
                                                      double a = 0,
                                                          c = 0,
                                                          pro = 0,
                                                          p = 0;

                                                      if (output != null) {
                                                        var assigned =
                                                            output['assigned'];
                                                        var competed =
                                                            output['completed'];
                                                        var pending =
                                                            output['pending'];
                                                        var processing = output[
                                                            'processing'];

                                                        if (assigned != null) {
                                                          a = assigned
                                                              .toDouble();
                                                        } else {
                                                          a = 0;
                                                        }

                                                        if (pending != null) {
                                                          p = pending
                                                              .toDouble();
                                                        } else {
                                                          p = 0;
                                                        }

                                                        if (processing !=
                                                            null) {
                                                          pro = processing
                                                              .toDouble();
                                                        } else {
                                                          pro = 0;
                                                        }

                                                        if (competed != null) {
                                                          c = competed
                                                              .toDouble();
                                                        } else {
                                                          c = 0;
                                                        }
                                                      }
                                                      return PieChart(
                                                        PieChartData(
                                                            borderData:
                                                                FlBorderData(
                                                              show: false,
                                                            ),
                                                            sectionsSpace: 0,
                                                            centerSpaceRadius:
                                                                0,
                                                            sections:
                                                                showingSections(
                                                                    a,
                                                                    p,
                                                                    c,
                                                                    pro)),
                                                      );
                                                    }

                                                    return const Center(
                                                        child:
                                                            CircularProgressIndicator());
                                                  },
                                                )
                                              : Container(
                                                  clipBehavior: Clip.hardEdge,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  child: Image.asset(
                                                    'assets/gif/emptyreport.gif',
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: s.width * 0.3,
                                            alignment: Alignment.centerLeft,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      color: const Color(
                                                          0xFF70e000),
                                                    ),
                                                    SizedBox(
                                                      width: s.width * 0.02,
                                                    ),
                                                    const Text(
                                                      "Completed",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 13,
                                                        // color: Color(0xff70e000),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      color: const Color(
                                                          0xFFd62839),
                                                    ),
                                                    SizedBox(
                                                      width: s.width * 0.02,
                                                    ),
                                                    const Text(
                                                      "Pending",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 13,
                                                        // color: Color(0xffd62839),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      color: const Color(
                                                          0xFF1e96fc),
                                                    ),
                                                    SizedBox(
                                                      width: s.width * 0.02,
                                                    ),
                                                    const Text(
                                                      "Processing",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 13,
                                                        // color: Color(0xffd62839),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: 10,
                                                      height: 10,
                                                      color: const Color(
                                                          0xFFffd500),
                                                    ),
                                                    SizedBox(
                                                      width: s.width * 0.02,
                                                    ),
                                                    const Text(
                                                      "Assigned",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Montserrat",
                                                        fontSize: 13,
                                                        // color: Color(0xffd62839),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Text(
                                        "*Today's Summary",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 10,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: s.width * 0.03),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: s.width * 0.06,
                                      vertical: s.height * 0.03),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: white,
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            color: black.withOpacity(0.1))
                                      ]),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "REPORT",
                                        style: TextStyle(
                                            color: bluebg,
                                            fontFamily: "Montserrat",
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Divider(
                                        endIndent: 10,
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                          stream: fb
                                              .collection("organizations")
                                              .doc("$orgId")
                                              .collection("Employee")
                                              .snapshots(),
                                          builder: (BuildContext context,
                                              AsyncSnapshot<QuerySnapshot>
                                                  snapshot) {
                                            if (snapshot.hasError) {}
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Center(
                                                child: SizedBox(
                                                  width: s.width * 0.25,
                                                  height: s.width * 0.25,
                                                  child: const LoadingIndicator(
                                                    indicatorType: Indicator
                                                        .ballClipRotateMultiple,
                                                    colors: [bluebg],
                                                  ),
                                                ),
                                              );
                                            }

                                            final List techprofile = [];
                                            snapshot.data!.docs.map(
                                                (DocumentSnapshot document) {
                                              Map a = document.data()
                                                  as Map<String, dynamic>;
                                              techprofile.add(a);
                                              // a['uid'] = document.id;
                                            }).toList();
                                            return Column(
                                              children: [
                                                for (var i = 0;
                                                    i < techprofile.length;
                                                    i++) ...[
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 5.0),
                                                    child: Techreportcard(
                                                      name: techprofile[i]
                                                          ['name'],
                                                      username: techprofile[i]
                                                          ['username'],
                                                    ),
                                                  )
                                                ]
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    ]);
  }

  List<PieChartSectionData> showingSections(
      double a, double p, double c, double pro) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff70e000),
            value: c == 0 ? 1 : c,
            title: '${c.toInt()}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/ophthalmology-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff70e000),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xffffd500),
            value: a == 0 ? 1 : a,
            title: '${a.toInt()}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/librarian-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xffffd500),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xffd62839),
            value: p == 0 ? 1 : p,
            title: '${p.toInt()}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xffd62839),
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff1e96fc),
            value: pro == 0 ? 1 : pro,
            title: '${pro.toInt()}',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
            badgeWidget: _Badge(
              'assets/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: const Color(0xff1e96fc),
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw 'Oh no';
      }
    });
  }

  // Future<void> fetchreport() async {
  //   DateTime now = DateTime.now();

  //   // Report
  //   String day = DateFormat('d').format(now);
  //   String month = DateFormat('MM').format(now);
  //   String year = DateFormat('y').format(now);

  // fb
  //     .collection("Reports")
  //     .doc(year)
  //     .collection("Month")
  //     .doc(month)
  //     .collection(day)
  //     .doc("Counter")
  //       .get();
  // }

  pgmsetup() async {
    DateTime now = DateTime.now();
    String cday = DateFormat('MM d y').format(now);

    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    // Check report is initailized or not
    fb
        .collection("organizations")
        .doc("$orgId")
        .collection("Reports")
        .doc(year)
        .collection("Month")
        .doc(month)
        .collection(day)
        .doc("Counter")
        .get()
        .then(
      (DocumentSnapshot doc) {
        if (!doc.exists) {
          setState(() {
            rpstatus = false;
          });
        } else {
          setState(() {
            rpstatus = true;
          });
        }
      },
      onError: (e) => print("Error in RPStatus: $e"),
    );

    try {
      await fb
          .collection("organizations")
          .doc("$orgId")
          .collection('Completedpgm')
          .doc("Day")
          .collection(cday)
          .get()
          .then((snap) => {
                setState(() {
                  c = snap.size;
                })
              });
      await fb
          .collection("organizations")
          .doc("$orgId")
          .collection('Programs')
          .get()
          .then((snap) => {
                setState(() {
                  p = snap.size;
                })
              });
    } catch (e) {
      print(e);
    }
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
        .pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginSrc())));
  }
}

class _Badge extends StatelessWidget {
  final String svgAsset;
  final double size;
  final Color borderColor;

  const _Badge(
    this.svgAsset, {
    Key? key,
    required this.size,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: Center(
        child: Icon(
          Icons.pending_actions_rounded,
          color: borderColor,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Techcardspace extends StatelessWidget {
  String? orgId;
  String? userid;
  Techcardspace({Key? key, this.userid, this.orgId}) : super(key: key);
  FirebaseFirestore fb = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: fb
            .collection("organizations")
            .doc("$orgId")
            .collection('Technician')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.3,
                child: const LoadingIndicator(
                  indicatorType: Indicator.ballClipRotateMultiple,
                  colors: [bluebg],
                ),
              ),
            );
          }

          final List techprofile = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            techprofile.add(a);
            // a['uid'] = document.id;
          }).toList();
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: techprofile.length,
            itemBuilder: (context, i) {
              return Techcard(
                orgId: orgId,
                name: techprofile[i]['name'],
                img: techprofile[i]['pic'],
                username: techprofile[i]['username'],
                uid: techprofile[i]['uid'],
              );
            },
          );
        });
  }
}

// ignore: must_be_immutable
class Techcard extends StatefulWidget {
  String? name;
  String? img;
  String? uid;
  String? username;
  String? orgId;
  Techcard({Key? key, this.name, this.img, this.uid, this.username, this.orgId})
      : super(key: key);

  @override
  _TechcardState createState() => _TechcardState();
}

class _TechcardState extends State<Techcard> {
  FirebaseFirestore fb = FirebaseFirestore.instance;

  var random = Random();
  List<String> techimg = [
    "assets/Icons/tech_avatar1.png",
    "assets/Icons/tech_avatar2.png",
    "assets/Icons/tech_avatar3.png",
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String cday = DateFormat('MM d y').format(now);

    // Image selection task
    int num = random.nextInt(100);
    int loc = num % 3;

    Size s = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Techstatus(
                orgId: widget.orgId,
                name: widget.name,
                img: widget.img,
                username: widget.username,
                uid: widget.uid,
              ),
            )),
        child: Container(
          width: 160,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: white,
              boxShadow: [
                BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 3,
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 2))
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Techprofilesrc(
                          name: widget.name,
                          img: widget.img,
                          username: widget.username,
                          uid: widget.uid,
                        ),
                      ),
                    ),
                    child: SizedBox(
                      width: s.width * 0.2,
                      height: s.width * 0.2,
                      child: Image.asset(
                        techimg[loc],
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: FittedBox(
                    child: Text(
                      "${widget.name}",
                      style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff273746),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.yellow),
                        ),
                        const AutoSizeText(
                          " Assingned",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff273746),
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: fb
                            .collection("organizations")
                            .doc("${widget.orgId}")
                            .collection('Technician')
                            .doc(widget.username)
                            .collection("Assignedpgm")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "0",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          // assigned list
                          final List assignedpgms = [];
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map assigned =
                                document.data() as Map<String, dynamic>;
                            assignedpgms.add(assigned);
                          }).toList();

                          return Text(
                            "${assignedpgms.length}",
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        })
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.greenAccent),
                        ),
                        const AutoSizeText(
                          " Completed",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff273746),
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: fb
                            .collection("organizations")
                            .doc("${widget.orgId}")
                            .collection('Technician')
                            .doc(widget.username)
                            .collection("Completedpgm")
                            .doc("Day")
                            .collection(cday)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "0",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          // completed list
                          final List completedpgms = [];
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map completed =
                                document.data() as Map<String, dynamic>;
                            completedpgms.add(completed);
                          }).toList();

                          return Text(
                            "${completedpgms.length}",
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        })
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cheryred),
                        ),
                        const AutoSizeText(
                          " Pending",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff273746),
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: fb
                            .collection("organizations")
                            .doc("${widget.orgId}")
                            .collection('Technician')
                            .doc(widget.username)
                            .collection("Pendingpgm")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "0",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          // pending list
                          final List pendingpgms = [];
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map pending =
                                document.data() as Map<String, dynamic>;
                            pendingpgms.add(pending);
                          }).toList();

                          return Text(
                            "${pendingpgms.length}",
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        })
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                        ),
                        const AutoSizeText(
                          " Processing",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff273746),
                          ),
                          minFontSize: 10,
                          maxLines: 1,
                        ),
                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                        stream: fb
                            .collection("organizations")
                            .doc("${widget.orgId}")
                            .collection('Technician')
                            .doc(widget.username)
                            .collection("Processingpgm")
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {}
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text(
                              "0",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            );
                          }
                          // processing list
                          final List processingpgms = [];
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map processing =
                                document.data() as Map<String, dynamic>;
                            processingpgms.add(processing);
                          }).toList();

                          return Text(
                            "${processingpgms.length}",
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w600,
                            ),
                          );
                        })
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
