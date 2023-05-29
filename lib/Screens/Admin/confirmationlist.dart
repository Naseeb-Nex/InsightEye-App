import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/components/confirmationcard.dart';
import 'package:insighteye_app/constants/constants.dart';
// iconsax

// ignore: must_be_immutable
class Confirmationlist extends StatefulWidget {
  String? orgId;
   Confirmationlist({Key? key, this.orgId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ConfirmationlistState createState() => _ConfirmationlistState();
}

class _ConfirmationlistState extends State<Confirmationlist> {
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
        appBar: AppBar(
          centerTitle: true,
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.arrow_back_rounded)),
          elevation: 0,
          title: const Text(
            "Confirmation List",
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
          child: Column(
            children: [
              SizedBox(height: s.height * 0.01),
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
                  child:  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Confrimationcardwrapper(
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
class Confrimationcardwrapper extends StatefulWidget {
  String? orgId;
   Confrimationcardwrapper({Key? key,  this.orgId}) : super(key: key);

  @override
  State<Confrimationcardwrapper> createState() =>
      _confrimationcardwrapperState();
}

// ignore: camel_case_types
class _confrimationcardwrapperState extends State<Confrimationcardwrapper> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        // this code is not updating
        // we want to update this code
        stream:
            FirebaseFirestore.instance.collection("organizations")
          .doc("${widget.orgId}").collection('ConfirmList').snapshots(),
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

          // sorting by priority
          allpgm.sort((a, b) => a["priority"].compareTo(b["priority"]));

          return Column(
            children: [
              const SizedBox(height: 10),
              for (var i = 0; i < allpgm.length; i++) ...[
                const SizedBox(
                  height: 5,
                ),
                Confirmationcard(
                  orgId: widget.orgId,
                  // TODO : find why UID is changing?
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
                  custdocname: allpgm[i]['custdocname'],
                  prospec: allpgm[i]['prospec'],
                  instadate: allpgm[i]['instadate'],
                  status: allpgm[i]['status'],
                  techname: allpgm[i]['techname'],
                  assignedtime: allpgm[i]['assignedtime'],
                  assigneddate: allpgm[i]['assigneddate'],
                  priority: allpgm[i]['priority'],
                  techuid: allpgm[i]['techuid'],
                )
              ]
            ],
          );
        });
  }
}
