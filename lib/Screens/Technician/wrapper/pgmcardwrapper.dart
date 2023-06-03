import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insighteye_app/components/programcard.dart';
import 'package:insighteye_app/constants/constants.dart';

// ignore: must_be_immutable
class Pgmcardwrapper extends StatefulWidget {
  String? techuid;
  Pgmcardwrapper({Key? key, required this.techuid}) : super(key: key);

  @override
  State<Pgmcardwrapper> createState() => _PgmcardwrapperState();
}

class _PgmcardwrapperState extends State<Pgmcardwrapper> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('technician')
            .doc("${widget.techuid}")
            .collection("Assignedpgm")
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              child: const Center(
                child: CircularProgressIndicator(
                  color: bluebg,
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
          allpgm.sort((a, b) => a["priority"].compareTo(b["priority"]));
          return Column(
            children: [
              const SizedBox(height: 10),
              for (var i = 0; i < allpgm.length; i++) ...[
                const SizedBox(
                  height: 5,
                ),
                Programcard(
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
                  prospec: allpgm[i]['prospec'],
                  instadate: allpgm[i]['instadate'],
                  assigneddate: allpgm[i]['assigneddate'],
                  priority: allpgm[i]['priority'],
                  custdocname: allpgm[i]['custdocname'],
                ),
              ],
              const SizedBox(height: 30,)
            ],
          );
        });
  }
}
