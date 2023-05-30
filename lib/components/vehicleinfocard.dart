import 'package:flutter/material.dart';
import 'package:insighteye_app/components/vehiclelogcard.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:insighteye_app/Screens/models/vehicleusagehistory.dart';
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
// package
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:motion_toast/motion_toast.dart';
// components
import 'package:insighteye_app/components/loadingDialog.dart';

// ignore: must_be_immutable
class VechicleInfoCard extends StatefulWidget {
  String? name;
  String? desc;
  String? type;
  String? status;
  String? statusdesc;
  String? techname;
  String? techuid;
  String? vdocname;
  String? update;
  String? uptime;
  String? orgId;

  VechicleInfoCard({
    Key? key,
    this.name,
    this.desc,
    this.type,
    this.status,
    this.statusdesc,
    this.techname,
    this.techuid,
    this.vdocname,
    this.update,
    this.orgId,
    this.uptime,
  }) : super(key: key);

  @override
  State<VechicleInfoCard> createState() => _VechicleInfoCardState();
}

class _VechicleInfoCardState extends State<VechicleInfoCard> {
  bool _isviz = false;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Container(
      width: MediaQuery.of(context).size.width,
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
      child: Padding(
        padding: EdgeInsets.all(s.width * 0.03),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => showDialog(
                          context: context,
                          builder: ((context) => VehiclelogDialog(
                            orgId: widget.orgId,
                              type: widget.type,
                              name: widget.name,
                              docname: widget.vdocname))),
                      child: Container(
                        width: s.width * 0.2,
                        height: s.width * 0.2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: vybg),
                        clipBehavior: Clip.hardEdge,
                        child: Vehicleimagewrapper(widget.type),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: s.width * 0.02),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "${widget.name}",
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                VStatuswrapper(status: widget.status),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: Text(
                                    "${widget.desc}",
                                    style: const TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: _isviz,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container(
                      padding: EdgeInsets.all(s.width * 0.03),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 3,
                            color: black.withOpacity(.05),
                            offset: const Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Text(
                              "More Option",
                              style: TextStyle(
                                color: Color(0xff828a96),
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: s.width * 0.15,
                            height: 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color(0xff828a96),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: const Color(0XFFf2f4f8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.person_outline_rounded,
                                      color: Color(0XFF224c84),
                                      size: 25,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "${widget.techname}",
                                      style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                        color: Color(0XFF224c84),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () => recall(context, widget.vdocname),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        color: black.withOpacity(.05),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: const Text(
                                    "Recall",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                      color: cheryred,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Center(
              child: widget.status == "Ongoing"
                  ? Container(
                      height: s.width * 0.2,
                      alignment: Alignment.bottomRight,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: InkWell(
                                onTap: () => setState(() {
                                  _isviz = !_isviz;
                                }),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: white,
                                    boxShadow: [
                                      BoxShadow(
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        color: black.withOpacity(.05),
                                        offset: const Offset(1, 1),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Iconsax.arrow_down_1,
                                      color: Colors.blueGrey),
                                ),
                              ),
                            ),
                          ]),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> recall(BuildContext context, String? docname) async {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    String techvdoc = DateFormat('MM d').format(now);
    // Vehicle Usage history
    String update = DateFormat('d MM y').format(now);
    String uptime = DateFormat('h:mma').format(now);
    String usagedocname = DateFormat('MM d y kk:mm:ss').format(now);

    // Vehicle Usage history
    VehicleUsageHistory vusage = VehicleUsageHistory(
        name: widget.name,
        upDate: update,
        upTime: uptime,
        techuid: widget.techuid,
        docname: usagedocname,
        techname: widget.techname,
        type: widget.type,
        status: "Recall");

    showDialog(context: context, builder: ((context) => const LoadingDialog()));
    await fb
    .collection("organizations")
          .doc("${widget.orgId}")
        .collection("technician")
        .doc(widget.techuid)
        .collection("Vehicle")
        .doc(techvdoc)
        .delete();

    // history added
    await fb.collection("organizations")
          .doc("${widget.orgId}")
        .collection("GarageUsage")
        .doc(usagedocname)
        .set(vusage.toMap())
        .then((v) => print("Vehicle assigned history added"));

    // status change
    await fb.collection("organizations")
          .doc("${widget.orgId}").collection("Garage").doc(docname).set(
        {"status": "Available", "techname": "none", "techuid": "none"},
        SetOptions(merge: true));

    Navigator.of(context).pop();
    Navigator.pop(context);
    MotionToast.success(
      title: Text(
        "Vehicle Recalled from ${widget.techname}",
        style: const TextStyle(
          fontFamily: "Montserrat",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      description: const Text(
        "Successfully vehicle Impounded",
        style: TextStyle(
          fontFamily: "Montserrat",
          fontSize: 12,
          fontWeight: FontWeight.w300,
        ),
      ),
    ).show(context);
  }
}

// ignore: must_be_immutable
class VehiclelogDialog extends StatefulWidget {
  String? type;
  String? name;
  String? docname;
  String? orgId;

  VehiclelogDialog({super.key, this.type, this.name, this.docname, this.orgId});

  @override
  State<VehiclelogDialog> createState() => _VehiclelogDialogState();
}

class _VehiclelogDialogState extends State<VehiclelogDialog> {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: white,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 3,
                  color: black.withOpacity(.2),
                  offset: const Offset(0.5, 1),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  width: s.width * 0.2,
                  height: s.width * 0.2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 3,
                          blurRadius: 4,
                          color: black.withOpacity(.2),
                          offset: const Offset(1, 1),
                        ),
                      ],
                      color: vybg),
                  clipBehavior: Clip.hardEdge,
                  child: Vehicleimagewrapper(widget.type),
                ),
                const SizedBox(height: 10),
                Text(
                  "${widget.name}",
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: s.height * 0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    color: white,
                    border: Border.all(
                      color: bluebg,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(5),
                        decoration: const BoxDecoration(
                            color: bluebg,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: const Center(
                          child: Text(
                            "Vehicle Log",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: white),
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                  stream: fb.collection("organizations")
          .doc("${widget.orgId}")
                                      .collection("Garage")
                                      .doc(widget.docname)
                                      .collection("VehicleLog")
                                      .orderBy('docname', descending: true)
                                      .limit(20)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
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

                                    final List vehicle = [];
                                    snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      Map a = document.data()
                                          as Map<String, dynamic>;
                                      vehicle.add(a);
                                      // a['uid'] = document.id;
                                    }).toList();
                                    return Column(
                                      children: [
                                        Container(
                                            child: vehicle.isEmpty
                                                ? Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                s.width * 0.01),
                                                    child: Image.asset(
                                                        "assets/Icons/no_result.png"),
                                                  )
                                                : null),
                                        for (var i = 0;
                                            i < vehicle.length;
                                            i++) ...[
                                          Vehiclelogcard(
                                            techname: vehicle[i]['techname'],
                                            docname: vehicle[i]['docname'],
                                            upDate: vehicle[i]['upDate'],
                                            upTime: vehicle[i]['upTime'],
                                            start: vehicle[i]['start'],
                                            end: vehicle[i]['end'],
                                            edited: vehicle[i]['edited'],
                                          )
                                        ]
                                      ],
                                    );
                                  }),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class Vehicleimagewrapper extends StatelessWidget {
  String? type;
  Vehicleimagewrapper(this.type, {super.key});

  @override
  Widget build(BuildContext context) {
    if (type == "Scooter") {
      return Image.asset(
        "assets/Icons/scooter.jpg",
        fit: BoxFit.cover,
      );
    } else if (type == "Truck") {
      return Image.asset(
        "assets/Icons/truck.png",
        fit: BoxFit.cover,
      );
    } else if (type == "Self Vehicle") {
      return Image.asset(
        "assets/Icons/self_vehicle.jpg",
        fit: BoxFit.cover,
      );
    }
    return Image.asset(
      "assets/Icons/bike.jpg",
      fit: BoxFit.cover,
    );
  }
}

// ignore: must_be_immutable
class VStatuswrapper extends StatelessWidget {
  String? status;
  VStatuswrapper({super.key, this.status});

  @override
  Widget build(BuildContext context) {
    if (status == "Ongoing") {
      return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: yellowbg,
          boxShadow: [
            BoxShadow(
              spreadRadius: 1,
              blurRadius: 1,
              color: black.withOpacity(.05),
              offset: const Offset(1, 1),
            ),
          ],
        ),
        child: Text(
          "$status",
          style: const TextStyle(
            fontFamily: "Montserrat",
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: yellowfg,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: greenbg,
        boxShadow: [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 1,
            color: black.withOpacity(.05),
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: Text(
        "$status",
        style: const TextStyle(
          fontFamily: "Montserrat",
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.green,
        ),
      ),
    );
  }
}
