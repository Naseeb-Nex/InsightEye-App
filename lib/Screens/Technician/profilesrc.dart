import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:insighteye_app/Screens/models/user_model.dart';
import 'package:insighteye_app/constants/constants.dart';

import 'package:insighteye_app/screens/Technician/Completedpgmview.dart';
import 'package:insighteye_app/screens/Technician/Pendingpgmview.dart';
import 'package:insighteye_app/screens/Technician/Processingpgmview.dart';

import 'package:insighteye_app/screens/Technician/resetpassword.dart';

import 'package:insighteye_app/Screens/Auth/login_src.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class Profilesrc extends StatefulWidget {
  String? uid;
  String? name;
  String? img;
  String? techuid;
  String? orgId;
  Profilesrc({Key? key, required this.uid, this.name, this.img, this.techuid, this.orgId})
      : super(key: key);

  @override
  _ProfilesrcState createState() => _ProfilesrcState();
}

class _ProfilesrcState extends State<Profilesrc> {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  int a = 0;
  int c = 0;
  int p = 0;
  int pro = 0;

  UserModel profile = UserModel();
  @override
  void initState() {
    super.initState();
    if (mounted) startup();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(38, 0, 91, 1),
                Color.fromRGBO(55, 48, 255, 1),
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: <Widget>[
                            IconButton(
                              alignment: Alignment.centerLeft,
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            const Text(
                              "My Profile",
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => logout(context),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.white)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 8),
                            child: const Text(
                              "Log out",
                              style: TextStyle(
                                  fontFamily: "Nunito",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  Container(
                    width: s.width * 0.4,
                    height: s.width * 0.4,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage("assets/Icons/tech_avatar1.png")),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "${widget.name}",
                    style: const TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: s.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 25),
                      child: Column(
                        children: [
                          const Text(
                            'My Activity',
                            style: TextStyle(
                              color: Color.fromRGBO(39, 105, 171, 1),
                              fontSize: 27,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Divider(
                            thickness: 2,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Compeltedpgmview(
                                              techuid: widget.techuid,
                                              orgId: widget.orgId,
                                            ))),
                                child: Container(
                                  width: s.width * 0.4,
                                  height: s.height * 0.1,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0XFFDBF4F1),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 5))
                                      ]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const AutoSizeText(
                                        "Completed Program",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.greenAccent,
                                        ),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "$c",
                                        style: const TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0XFF95d5b2),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Pendingpgmview(
                                              orgId: widget.orgId,
                                              techuid: widget.techuid,
                                            ))),
                                child: Container(
                                  width: s.width * 0.4,
                                  height: s.height * 0.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: const Color(0XFFFED4D6),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: const Offset(0, 5))
                                      ]),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 2),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const AutoSizeText(
                                        "Pending Program",
                                        style: TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.redAccent,
                                        ),
                                        maxLines: 2,
                                      ),
                                      Text(
                                        "$p",
                                        style: const TextStyle(
                                          fontFamily: "Nunito",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            Processingpgmview(
                                              techuid: widget.techuid,
                                              orgId: widget.orgId,
                                            ))),
                            child: Container(
                              width: s.width * 0.45,
                              height: s.height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: const Color(0XFFC8D7FE),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: const Offset(0, 5))
                                  ]),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const AutoSizeText(
                                    "Processing Program",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  ),
                                  Text(
                                    "$pro",
                                    style: const TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25, vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: white,
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(0, 5))
                              ],
                            ),
                            child: Text(
                              "Edit profile",
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.blue[400],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Resetpswdsrc(
                                        uid: widget.uid,
                                        techuid: widget.techuid,
                                        orgId: widget.orgId))),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: white,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 3,
                                      blurRadius: 5,
                                      color: Colors.black.withOpacity(0.1),
                                      offset: const Offset(0, 5))
                                ],
                              ),
                              child: Text(
                                "Change Password",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Colors.red[400],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  startup() async {
    DateTime now = DateTime.now();
    String cday = DateFormat('MM d y').format(now);
    try {
      FirebaseFirestore.instance
      .collection("organizations")
          .doc("${widget.orgId}")
          .collection("technician")
          .doc(widget.techuid)
          .get()
          .then((value) {
        profile = UserModel.fromMap(value.data());
      });

      await fb
      .collection("organizations")
          .doc("${widget.orgId}")
          .collection('technician')
          .doc(widget.techuid)
          .collection("Assignedpgm")
          .get()
          .then((snap) => {
                setState(() {
                  a = snap.size;
                })
              });

      await fb
      .collection("organizations")
          .doc("${widget.orgId}")
          .collection('technician')
          .doc(widget.techuid)
          .collection("Completedpgm")
          .doc("Day")
          .collection(cday)
          .get()
          .then((snap) => {
                setState(() {
                  c = snap.size;
                })
              });
      await fb.collection("organizations")
          .doc("${widget.orgId}")
          .collection('technician')
          .doc(widget.techuid)
          .collection("Pendingpgm")
          .get()
          .then((snap) => {
                setState(() {
                  p = snap.size;
                })
              });

      await fb.collection("organizations")
          .doc("${widget.orgId}")
          .collection('technician')
          .doc(widget.techuid)
          .collection("Processingpgm")
          .get()
          .then((snap) => {
                setState(() {
                  pro = snap.size;
                })
              });
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginSrc()));
  }
}




// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';

// class screenProfile extends StatefulWidget {
//   const screenProfile({super.key});

//   @override
//   State<screenProfile> createState() => _screenProfileState();
// }

// class _screenProfileState extends State<screenProfile> {
//   @override
//   Widget build(BuildContext context) {
//     // Responsive Size
//     Size s = MediaQuery.of(context).size;

// //for small 4 containers
//     Widget _buildSquareContainer(Color dotcolor, num, taskname) {
//       return Container(
//         width: s.width * 0.3093,
//         height: s.height * 0.1427,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(25),
//             boxShadow: [
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.35),
//                   spreadRadius: 0,
//                   blurRadius: 12,
//                   offset: Offset(4, 4))
//             ]),
//         child: Stack(
//           children: [
//             Positioned(
//               top: 15,
//               left: 15,
//               child: Container(
//                 width: 12,
//                 height: 12,
//                 decoration: BoxDecoration(
//                   color: dotcolor,
//                   shape: BoxShape.circle,
//                 ),
//               ),
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     num,
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   Text(taskname),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     }

//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(
//               height: s.height * 0.0171,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(height: 50, width: 50, child: Icon(Icons.arrow_back)),
//                 Text(
//                   'My Profile',
//                   style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
//                 ),
//                 SizedBox(
//                   height: 50,
//                   width: 50,
//                 )
//               ],
//             ),
//             SizedBox(
//               height: s.height * 0.0214,
//             ),
//             Image.asset('assets/images/fotor_2023-6-4_20_15_31 1.png'),
//             SizedBox(
//               height: s.height * 0.0128,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Thasni Thaha',
//                   style: TextStyle(fontSize: 30),
//                 ),
//                 SizedBox(
//                   width: s.width * 0.0279,
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       //write function for edit button
//                     },
//                     icon: Icon(Icons.edit_outlined))
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(18),
//               child: Container(
//                 width: s.width * 0.9162,
//                 height: s.height * 0.4828,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.25),
//                       offset: Offset(0, 0),
//                       blurRadius: 6,
//                     ),
//                   ],
//                 ),
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: s.height * 0.0107,
//                     ),
//                     Text(
//                       'Activity',
//                       style:
//                           TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: s.height * 0.0321,
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildSquareContainer(
//                                 Colors.yellow, '7', 'Assigned'),
//                             _buildSquareContainer(
//                                 Colors.green, '6', 'Completed'),
//                           ],
//                         ),
//                         SizedBox(
//                           height: s.height * 0.0729,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildSquareContainer(
//                                 Colors.blue, '5', 'Processing'),
//                             _buildSquareContainer(Colors.red, '4', 'Pending'),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(18),
//               child: ElevatedButton(
//                   onPressed: () {
//                     //logout function
//                   },
//                   style: ElevatedButton.styleFrom(
//                       fixedSize: Size(s.width * 0.9162, s.height * 0.0590),
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(15)),
//                       backgroundColor: Color(0xFF793BA8)),
//                   child: Text(
//                     'Log Out',
//                     style: TextStyle(fontSize: 18),
//                   )),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
