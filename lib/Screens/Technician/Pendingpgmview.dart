import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/components/pendingpgmcard.dart';
import 'package:insighteye_app/constants/constants.dart';

// ignore: must_be_immutable
class Pendingpgmview extends StatefulWidget {
  String? techuid;
  String? orgId;
  Pendingpgmview({Key? key, this.techuid, this.orgId}) : super(key: key);

  @override
  _PendingpgmviewState createState() => _PendingpgmviewState();
}

class _PendingpgmviewState extends State<Pendingpgmview> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cheryred,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: s.width,
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
                        child: const SizedBox(
                            height: 50,
                            width: 60,
                            child: Center(
                                child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: white,
                            ))),
                      ),
                      const Text(
                        "Pending Program List",
                        style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 60,
                      )
                    ],
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
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("organizations")
                          .doc("${widget.orgId}")
                          .collection('technician')
                          .doc(widget.techuid)
                          .collection("Pendingpgm")
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          print('Something went Wrong');
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Padding(
                            padding: EdgeInsets.only(top: s.height * 0.35),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: cheryred,
                              ),
                            ),
                          );
                        }

                        List allpgm = [];
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                          Map a = document.data() as Map<String, dynamic>;
                          allpgm.add(a);
                          a['uid'] = document.id;
                        }).toList();
                        allpgm.sort(
                            (a, b) => a["priority"].compareTo(b["priority"]));
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              child: allpgm.isEmpty
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: s.height * 0.35),
                                          child: SizedBox(
                                              height: s.width * 0.4,
                                              width: s.width * 0.4,
                                              child: Image.asset(
                                                  "assets/Icons/no_result.png")),
                                        ),
                                        const Center(
                                          child: Text(
                                            "No Programs Found",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontSize: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : null,
                            ),
                            for (var i = 0; i < allpgm.length; i++) ...[
                              const SizedBox(
                                height: 5,
                              ),
                              Pendingpgmcard(
                                orgId: widget.orgId,
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
                              )
                            ]
                          ],
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
