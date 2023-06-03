import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/components/adminpendingcard.dart';
import 'package:insighteye_app/constants/constants.dart';

// ignore: must_be_immutable
class PendingPgmListingSrc extends StatefulWidget {
  String? orgId;
  PendingPgmListingSrc({Key? key, this.orgId}) : super(key: key);

  @override
  _PendingPgmListingSrcState createState() => _PendingPgmListingSrcState();
}

class _PendingPgmListingSrcState extends State<PendingPgmListingSrc> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
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
                      "Pending Program Viewer",
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
                    child: Pgmcardwrapper(
                      orgId: widget.orgId,
                    ),
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
    return StreamBuilder<QuerySnapshot>(
        // TODO : this code is not updating
        // we want to update this code
        stream: FirebaseFirestore.instance.collection("organizations")
          .doc("${widget.orgId}").collection('Programs').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
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
          return Column(
            children: [
              const SizedBox(height: 10),
              for (var i = 0; i < allpgm.length; i++) ...[
                const SizedBox(
                  height: 5,
                ),
                AdminpendingCard(
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
                  techname: allpgm[i]['techname'],
                  custdocname: allpgm[i]['custdocname'],
                )
              ]
            ],
          );
        });
  }
}
