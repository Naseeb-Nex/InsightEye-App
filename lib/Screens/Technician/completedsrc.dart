import 'dart:math';

import 'package:flutter/material.dart';
import 'package:insighteye_app/constants/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:insighteye_app/Screens/models/customer_history.dart';
import 'package:insighteye_app/Screens/models/reportdata.dart';
import 'package:insighteye_app/Screens/models/reportstatus.dart';
import 'package:insighteye_app/Screens/Technician/hometech.dart';
import 'package:intl/intl.dart';

import 'package:insighteye_app/constants/completepgmdata.dart';
import 'package:motion_toast/motion_toast.dart';

// ignore: must_be_immutable
class Completedsrc extends StatefulWidget {
  String? address;
  String? assigneddate;
  String? assignedtime;
  String? chrg;
  String? custdocname;
  String? docname;
  String? instadate;
  String? loc;
  String? name;
  String? pgm;
  String? phn;
  String? priority;
  String? prospec;
  String? status;
  String? techname;
  String? type;
  String? uid;
  String? upDate;
  String? upTime;
  String? techuid;
  String? orgId;

  Completedsrc({
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
    this.assignedtime,
    this.assigneddate,
    this.priority,
    this.prospec,
    this.instadate,
    this.custdocname,
    this.orgId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CompletedsrcState createState() => _CompletedsrcState();
}

class _CompletedsrcState extends State<Completedsrc> {
  final TextEditingController cost = TextEditingController();
  List<String> custimg = [
    "assets/Icons/customer1.jpg",
    "assets/Icons/customer2.jpg",
    "assets/Icons/customer3.png"
  ];

  var random = Random();
  final TextEditingController remarks = TextEditingController();

  bool _err = false;
  final _formKey = GlobalKey<FormState>();
  bool _upload = false;
  bool _value = false;

  void detailsup() async {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    String completeddate = DateFormat('d MMM y').format(now);
    String completedtime = DateFormat('h:mma').format(now);
    String ccollname = DateFormat('MM d y').format(now);
    String cdocname = DateFormat('MM d y kk:mm:ss').format(now);
    String mcollname = DateFormat('MM y').format(now);
    String ycollname = DateFormat('y').format(now);

    // Daily report docname
    String daydoc = DateFormat('kk:mm:ss').format(now);

    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    Completepgmdata cpgm = Completepgmdata(
      uid: widget.uid,
      name: widget.name,
      address: widget.address,
      loc: widget.loc,
      phn: widget.phn,
      pgm: widget.pgm,
      chrg: widget.chrg,
      type: widget.type,
      upDate: widget.upDate,
      upTime: widget.upTime,
      docname: widget.docname,
      status: "completed",
      techuid: widget.techuid,
      techname: widget.techname,
      priority: widget.priority,
      assigneddate: widget.assigneddate,
      assignedtime: widget.assignedtime,
      camount: cost.text,
      remarks: remarks.text,
      cdate: completeddate,
      ctime: completedtime,
      ccollname: ccollname,
      cdocname: cdocname,
      mcollname: mcollname,
      ycollname: ycollname,
    );

    // report data
    Reportdata rpdata = Reportdata(
      name: widget.name,
      address: widget.address,
      loc: widget.loc,
      phn: widget.phn,
      pgm: widget.pgm,
      chrg: widget.chrg,
      type: widget.type,
      upDate: widget.upDate,
      upTime: widget.upTime,
      docname: widget.docname,
      status: "completed",
      techuid: widget.techuid,
      techname: widget.techname,
      priority: widget.priority,
      assigneddate: widget.assigneddate,
      assignedtime: widget.assignedtime,
      camount: cost.text,
      remarks: remarks.text,
      cdate: completeddate,
      ctime: completedtime,
      ccollname: ccollname,
      cdocname: cdocname,
      custdocname: widget.custdocname,
      rpdocname: cdocname,
    );

    // Daily report status
    Reportstatus dayrpdata = Reportstatus(
      name: widget.name,
      pgm: widget.pgm,
      techname: widget.techname,
      docname: "${widget.techname} $daydoc",
      phn: widget.phn,
      status: "completed",
      upDate: completeddate,
      upTime: completedtime,
      day: day,
      month: month,
      techuid: widget.techuid,
      more: cdocname,
    );

    // Monthly reports status
    Reportstatus monthrpdata = Reportstatus(
      name: widget.name,
      pgm: widget.pgm,
      techname: widget.techname,
      docname: "${widget.techname} $daydoc",
      phn: widget.phn,
      status: "completed",
      upDate: completeddate,
      upTime: completedtime,
      day: day,
      month: month,
      techuid: widget.techuid,
      more: cdocname,
    );

    //customer program history
    CustomerPgmHistory custhistory = CustomerPgmHistory(
        upDate: completeddate,
        upTime: completedtime,
        msg: "${widget.techname} completed the Program",
        remarks: remarks.text,
        techname: widget.techname,
        status: "completed",
        camount: cost.text,
        docname: cdocname,
        custdocname: widget.custdocname);

    if (_formKey.currentState!.validate()) {
      if (_value == true) {
        setState(() {
          _err = false;
          _upload = true;
        });

        // Report session

        // Update the reportdata
        await fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Reports")
            .doc(year)
            .collection("Month")
            .doc(month)
            .collection(day)
            .doc("Tech")
            .collection("Reports")
            .doc("${widget.techuid}")
            .collection("Activity")
            .doc(cdocname)
            .set(rpdata.toMap());

        // Update the dayily report data
        await fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Reports")
            .doc(year)
            .collection("Month")
            .doc(month)
            .collection(day)
            .doc("summary")
            .collection("all")
            .doc("${widget.techname} $daydoc")
            .set(dayrpdata.toMap());

        // Daily counter update
        await fb
            .collection("organizations")
            .doc("${widget.orgId}")
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
              fb
                  .collection("organizations")
                  .doc("${widget.orgId}")
                  .collection("Reports")
                  .doc(year)
                  .collection("Month")
                  .doc(month)
                  .collection(day)
                  .doc("Counter")
                  .set({'completed': 1}, SetOptions(merge: true));
            } else {
              fb
                  .collection("organizations")
                  .doc("${widget.orgId}")
                  .collection("Reports")
                  .doc(year)
                  .collection("Month")
                  .doc(month)
                  .collection(day)
                  .doc("Counter")
                  .update({'completed': FieldValue.increment(1)});
            }
          },
          onError: (e) {
      MotionToast.error(
        title: const Text("Error"),
        description: const Text("Something went wrong :( try again"),
      ).show(context);
    }
        );

        // Update the Monthly report data
        await fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Reports")
            .doc(year)
            .collection("Month")
            .doc(month)
            .collection("summary")
            .doc("${widget.techname} $cdocname")
            .set(monthrpdata.toMap());

        // Update the monthly counter Report
        await fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Reports")
            .doc(year)
            .collection("Month")
            .doc(month)
            .get()
            .then((DocumentSnapshot doc) {
          if (!doc.exists) {
            fb
                .collection("organizations")
                .doc("${widget.orgId}")
                .collection("Reports")
                .doc(year)
                .collection("Month")
                .doc(month)
                .set({'completed': 1}, SetOptions(merge: true));
          } else {
            fb
                .collection("organizations")
                .doc("${widget.orgId}")
                .collection("Reports")
                .doc(year)
                .collection("Month")
                .doc(month)
                .update({'completed': FieldValue.increment(1)});
          }
        }, onError: (e) {
          MotionToast.error(
            title: const Text("Error"),
            description: const Text("Something went wrong :( try again"),
          ).show(context);
        });

        // Report session end

        fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("technician")
            .doc(widget.techuid)
            .collection("Completedpgm")
            .doc("Day")
            .collection(ccollname)
            .doc(cdocname)
            .set(cpgm.toMap()).catchError((error) {
          MotionToast.error(
            title: const Text("Error"),
            description: const Text("Something went wrong :( try again"),
          ).show(context);
        });

        // Updating the Customer program status
        fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Customer")
            .doc(widget.custdocname)
            .collection("Programs")
            .doc(widget.docname)
            .set({'status': 'completed', 'camount': cost.text},
                SetOptions(merge: true));

        fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("technician")
            .doc(widget.techuid)
            .collection("Completedpgm")
            .doc("Month")
            .collection(mcollname)
            .doc(cdocname)
            .set(cpgm.toMap())
            .catchError((error) {
          MotionToast.error(
            title: const Text("Error"),
            description: const Text("Something went wrong :( try again"),
          ).show(context);
        });

        // Tech perfromance Counter

        fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("technician")
            .doc(widget.techuid)
            .collection("Performance")
            .doc("Completed")
            .collection("Month")
            .doc(mcollname)
            .get()
            .then((DocumentSnapshot doc) {
          if (!doc.exists) {
            fb
                .collection("organizations")
                .doc("${widget.orgId}")
                .collection("technician")
                .doc(widget.techuid)
                .collection("Performance")
                .doc("Completed")
                .collection("Month")
                .doc(mcollname)
                .set({'count': 1});
          } else {
            fb
                .collection("organizations")
                .doc("${widget.orgId}")
                .collection("technician")
                .doc(widget.techuid)
                .collection("Performance")
                .doc("Completed")
                .collection("Month")
                .doc(mcollname)
                .update({'count': FieldValue.increment(1)});
          }
        }, onError: (e) {
          MotionToast.error(
            title: const Text("Error"),
            description: const Text("Something went wrong :( try again"),
          ).show(context);
        });

        fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Completedpgm")
            .doc("Day")
            .collection(ccollname)
            .doc(cdocname)
            .set(cpgm.toMap())
            .catchError((error) {
          MotionToast.error(
            title: const Text("Error"),
            description: const Text("Something went wrong :( try again"),
          ).show(context);
        });

        // customer program history updated
        fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Customer")
            .doc(widget.custdocname)
            .collection("Programs")
            .doc(widget.docname)
            .collection("History")
            .doc(cdocname)
            .set(custhistory.toMap());

        fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Completedpgm")
            .doc("Month")
            .collection(mcollname)
            .doc(cdocname)
            .set(cpgm.toMap())
            .catchError((error) {
          MotionToast.error(
            title: const Text("Error"),
            description: const Text("Something went wrong :( try again"),
          ).show(context);
        });

        await fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("Programs")
            .doc(widget.docname)
            .delete();

        await fb
            .collection("organizations")
            .doc("${widget.orgId}")
            .collection("technician")
            .doc(widget.techuid)
            .collection("Assignedpgm")
            .doc(widget.docname)
            .delete()
            .then((value) {
          setState(() {
            _upload = false;
          });

          MotionToast.success(
            title: const Text(
              "Sucessfull",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            description: const Text(
              "Program Completed",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ).show(context);

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeTech()),
          );
        }).catchError((error) {
          MotionToast.error(
            title: const Text(
              "Error",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            description: const Text(
              "Something went Wrong, Try again!",
              style: TextStyle(
                fontFamily: "Montserrat",
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ).show(context);
        });
      } else {
        setState(() {
          _err = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    int num = random.nextInt(100);
    int loc = num % 3;

    Size s = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: newbg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 50,
                            alignment: Alignment.centerRight,
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              size: 30,
                              color: bluebg,
                            ),
                          ),
                        ),
                        const Text(
                          "Program Completion",
                          style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: bluebg,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                          width: 50,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.all(s.width * 0.02),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: const Color(0xFFc0d5ff),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 3,
                                  color: Colors.black.withOpacity(0.13),
                                  offset: const Offset(0, 3))
                            ]),
                        padding: EdgeInsets.symmetric(
                            horizontal: s.width * 0.01, vertical: 30),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: s.width * 0.03),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Circular avatar with name and address
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: s.width * 0.2,
                                    width: s.width * 0.2,
                                    child: CircleAvatar(
                                        backgroundColor:
                                            const Color(0Xffffe6a7),
                                        backgroundImage:
                                            AssetImage(custimg[loc])),
                                  ),
                                  SizedBox(
                                    width: s.width * 0.02,
                                  ),
                                  SizedBox(
                                    width: s.width * 0.66,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: s.width * 0.08,
                                        ),
                                        Text(
                                          "${widget.name}",
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          "${widget.address}",
                                          style: const TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Location :",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      "  ${widget.loc}",
                                      style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Program :",
                                    style: TextStyle(
                                      fontFamily: "Montserrat",
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: Text(
                                      "${widget.pgm}",
                                      style: const TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Collection Amount :",
                                    style: TextStyle(
                                      fontFamily: "Nunito",
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: greenbg,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4, horizontal: 8),
                                    child: Text(
                                      "${widget.chrg}",
                                      style: const TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Collected Amount :",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              SizedBox(
                                width: 160,
                                height: 50,
                                child: TextFormField(
                                  autofocus: false,
                                  controller: cost,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return ("Collection Amount!!");
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    cost.text = value!;
                                  },
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    fillColor: white,
                                    prefixIcon: const Icon(
                                      Icons.attach_money_outlined,
                                      color: Colors.green,
                                    ),
                                    contentPadding: const EdgeInsets.fromLTRB(
                                        20, 15, 20, 15),
                                    hintText: "Collection",
                                    focusColor: Colors.green,
                                    hoverColor: bluebg,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 130,
                                  alignment: Alignment.topCenter,
                                  child: const Text(
                                    "Remarks :",
                                    style: TextStyle(
                                        fontFamily: "Nunito",
                                        fontSize: 19,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.74,
                                  height: 130,
                                  child: TextFormField(
                                    autofocus: false,
                                    controller: remarks,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 6,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Enter the Remarks!!");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      remarks.text = value!;
                                    },
                                    textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      hintText: "Remarks",
                                      focusColor: Colors.green,
                                      hoverColor: bluebg,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _value = !_value;
                        });
                      },
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 40,
                          ),
                          Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.grey)),
                            child: Center(
                                child: _value
                                    ? const Icon(
                                        Icons.check,
                                        size: 20.0,
                                        color: Colors.greenAccent,
                                      )
                                    : null),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Verify the Details",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    Container(
                        child: _err
                            ? const Text(
                                "please verify the details then check the box",
                                style: TextStyle(
                                    fontFamily: "Nunito",
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              )
                            : null),
                    const SizedBox(
                      height: 35,
                    ),
                    InkWell(
                      onTap: () => detailsup(),
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.greenAccent),
                        child: const Center(
                          child: Text(
                            "Completed",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 250,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.redAccent),
                        child: const Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontFamily: "Nunito",
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: _upload
                      ? const CircularProgressIndicator(
                          color: bluebg,
                        )
                      : null,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
