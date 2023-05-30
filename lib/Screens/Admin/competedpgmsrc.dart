import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:intl/intl.dart';

import 'package:insighteye_app/components/allcompletedpgmcard.dart';

// ignore: must_be_immutable
class Completedpgmsrc extends StatefulWidget {
  String? orgId;
  Completedpgmsrc({Key? key, this.orgId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CompletedpgmsrcState createState() => _CompletedpgmsrcState();
}

class _CompletedpgmsrcState extends State<Completedpgmsrc> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Stack(fit: StackFit.expand, children: [
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade600,
              limegreen,
            ],
            begin: FractionalOffset.center,
            end: FractionalOffset.topCenter,
          ),
        ),
      ),
      Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: s.width,
                height: s.height * 1 / 7,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            child: const Center(
                              child: Icon(
                                Icons.arrow_back,
                                color: white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          "Programs",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.person,
                            color: Colors.transparent,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Completed Program Viewer",
                      style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40)),
                    color: newbg,
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Pgmcardwrapper(orgId: widget.orgId),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    ]);
  }
}

// ignore: must_be_immutable
class Pgmcardwrapper extends StatefulWidget {
  String? orgId;
  Pgmcardwrapper({Key? key, this.orgId}) : super(key: key);

  @override
  State<Pgmcardwrapper> createState() => _PgmcardwrapperState();
}

class _PgmcardwrapperState extends State<Pgmcardwrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String cday = DateFormat('MM d y').format(now);
    return StreamBuilder<QuerySnapshot>(
        // this code is not updating
        // we want to update this code
        stream: FirebaseFirestore.instance
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Completedpgm")
            .doc("Day")
            .collection(cday)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(
                        child: Text(
                          "Something Went Wrong :(",
                          style: TextStyle(
                              fontFamily: "Montserrat",
                              fontSize: 17,
                              color: cheryred),
                        ),
                      );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: bluebg,
              ),
            );
          }

          List allpgm = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            allpgm.add(a);
            a['uid'] = document.id;
          }).toList();
          allpgm.sort((a, b) => a["priority"].compareTo(b["priority"]));
          return Column(
            children: [
              const SizedBox(height: 10),
              for (var i = 0; i < allpgm.length; i++) ...[
                const SizedBox(
                  height: 5,
                ),
                Allcompletedpgmcard(
                  uid: allpgm[i]['uid'],
                  name: allpgm[i]['name'],
                  address: allpgm[i]['address'],
                  loc: allpgm[i]['loc'],
                  phn: allpgm[i]['phn'],
                  pgm: allpgm[i]['pgm'],
                  chrg: allpgm[i]['chrg'],
                  type: allpgm[i]['type'],
                  upDate: allpgm[i]['upDate'],
                  upTime: allpgm[i]['upTime'],
                  docname: allpgm[i]['docname'],
                  status: allpgm[i]['status'],
                  techuid: allpgm[i]['techuid'],
                  techname: allpgm[i]['techname'],
                  assignedtime: allpgm[i]['assignedtime'],
                  assigneddate: allpgm[i]['assigneddate'],
                  priority: allpgm[i]['priority'],
                  camount: allpgm[i]['camount'],
                  ctime: allpgm[i]['ctime'],
                  remarks: allpgm[i]['remarks'],
                )
              ],
              // Completedpgmcard(
              //     uid: 'uid',
              //     name: 'name',
              //     address: 'address',
              //     loc: 'loc',
              //     phn: 'phn',
              //     pgm: 'pgm',
              //     chrg: '1000',
              //     type: 'type',
              //     upDate: 'upDate',
              //     upTime: 'upTime',
              //     docname: 'docname',
              //     status: 'status',
              //     techuid: 'techuid',
              //     techname: 'techname',
              //     assignedtime: 'assignedtime',
              //     assigneddate: 'assigneddate',
              //     priority: 'priority',
              //     camount: '500',
              //     ctime: 'ctime',
              //     remarks: 'remarks',
              //   )
            ],
          );
        });
  }
}
