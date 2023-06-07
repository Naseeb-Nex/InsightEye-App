import 'package:flutter/material.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:insighteye_app/screens/Technician/Detailingsrc.dart';

// ignore: must_be_immutable
class TechPgmCard extends StatelessWidget {
  String? uid;
  String? name;
  String? address;
  String? loc;
  String? phn;
  String? pgm;
  String? chrg;
  String? type;
  String? upDate;
  String? upTime;
  String? docname;
  String? status;
  String? techuid;
  String? techname;
  String? prospec;
  String? instadate;
  String? assignedtime;
  String? assigneddate;
  String? priority;
  String? custdocname;
  String? orgId;

  TechPgmCard({
    Key? key,
    this.uid,
    this.name,
    this.address,
    this.loc,
    this.phn,
    this.pgm,
    this.chrg,
    this.type,
    this.upDate,
    this.upTime,
    this.docname,
    this.status,
    this.techuid,
    this.techname,
    this.prospec,
    this.instadate,
    this.assignedtime,
    this.assigneddate,
    this.priority,
    this.custdocname,
    this.orgId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Detailingsrc(
                    uid: uid,
                    name: name,
                    address: address,
                    loc: loc,
                    phn: phn,
                    pgm: pgm,
                    chrg: chrg,
                    type: type,
                    upDate: upDate,
                    upTime: upTime,
                    docname: docname,
                    status: status,
                    techuid: techuid,
                    techname: techname,
                    assignedtime: assignedtime,
                    assigneddate: assigneddate,
                    priority: priority,
                    prospec: prospec,
                    instadate: instadate,
                    custdocname: custdocname,
                    orgId: orgId,
                  ))),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 10),
              blurRadius: 20,
              color: secondbg.withOpacity(0.23),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "$type Program",
                style: const TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$name",
                      style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      strutStyle: const StrutStyle(fontSize: 12.0),
                      text: TextSpan(
                    text: "$address",
                    style: const TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 15,
                        color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/Icons/pin.png", width: 23, height: 23),
                              const SizedBox(width: 5,),
                              Text(
                                "$loc",
                                style: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    _makePhoneCall(phn!);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 4,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 1),
                          )
                        ]),
                    height: 45,
                    width: 42,
                    child: const Center(
                      child: Icon(
                        Icons.call,
                        size: 25,
                        color: techbg,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launch(launchUri.toString());
  }
}
