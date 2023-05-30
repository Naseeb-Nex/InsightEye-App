import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:insighteye_app/components/assignvehiclereportcard.dart';
import 'package:insighteye_app/components/loadingDialog.dart';
import 'package:insighteye_app/components/vreportsubcard.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:insighteye_app/screens/Technician/hometech.dart';
import 'package:insighteye_app/screens/Technician/todaysreportsrc.dart';

import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// loading_indicator
import 'package:loading_indicator/loading_indicator.dart';

import 'package:iconsax/iconsax.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

// ignore: must_be_immutable
class ReportSubmissionSrc extends StatefulWidget {
  String? techuid;
  String? techname;
  String? orgId;
  ReportSubmissionSrc({Key? key, this.techuid, this.techname, this.orgId})
      : super(key: key);

  @override
  _ReportSubmissionSrcState createState() => _ReportSubmissionSrcState();
}

class _ReportSubmissionSrcState extends State<ReportSubmissionSrc> {
  FirebaseFirestore fb = FirebaseFirestore.instance;

  late CollectionReference streamreport;
  bool expnse_sub = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController expenseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    buildStream();
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    DateTime now = DateTime.now();
    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);
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
          appBar: AppBar(
            centerTitle: true,
            leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Padding(
                padding: EdgeInsets.all(s.width * 0.03),
                child: const Icon(Iconsax.arrow_left),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.done_rounded),
                onPressed: () {
                  if (expnse_sub) {
                    showDialog(
                        context: context,
                        builder: (context) => Dialog(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: s.height * 0.01, vertical: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Iconsax.chart_success,
                                          color: limegreen,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Are you sure?",
                                          style: TextStyle(
                                            fontFamily: "Montserrat",
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "Do you really want to sumbit Today's Expense Details?",
                                      style: TextStyle(
                                        fontFamily: "Montserrat",
                                        fontSize: 16,
                                        color: black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "* Please ensure that you added vehicle usage details before continues",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          color: Color(0XFF949494),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Flexible(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () =>
                                                  Navigator.pop(context),
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          s.height * 0.01),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0XFFeef1f7)),
                                                  child: const Center(
                                                      child: Text(
                                                    "Cancel",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      color: Color(0XFFa4a6aa),
                                                      fontSize: 15,
                                                    ),
                                                  ))),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: InkWell(
                                              onTap: () {
                                                // loading_indicator
                                                showDialog(
                                                    context: context,
                                                    builder: (context) =>
                                                        const LoadingDialog());

                                                fb
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
                                                    .update({
                                                  'submit': true
                                                }).then((value) {
                                                  Navigator.pop(context);

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Todaysreportsrc(
                                                                techuid: widget
                                                                    .techuid,
                                                              )));
                                                }).onError((error,
                                                            stackTrace) =>
                                                        PanaraInfoDialog.show(
                                                          context,
                                                          title: "Oops",
                                                          message:
                                                              "Something gone Wrong :(, Try again later",
                                                          buttonText: "Okay",
                                                          onTapDismiss: () =>
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              HomeTech())),
                                                          panaraDialogType:
                                                              PanaraDialogType
                                                                  .error,
                                                          barrierDismissible:
                                                              false,
                                                          textColor:
                                                              const Color(
                                                                  0XFF727272),
                                                        ));
                                              },
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical:
                                                          s.height * 0.01),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: bluebg),
                                                  child: const Center(
                                                      child: Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                      fontFamily: "Montserrat",
                                                      color: white,
                                                      fontSize: 15,
                                                    ),
                                                  ))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ));
                  } else {
                    MotionToast.error(
                      title: const Text(
                        "Update the Expense Details",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      description: const Text(
                        "Expense field is empty",
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ).show(context);
                  }
                },
              )
            ],
            elevation: 0,
            title: const Text(
              "Report Submission Screen",
              style: TextStyle(
                fontFamily: "Nunito",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.transparent,
          ),
          backgroundColor: Colors.transparent,
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
                      color: white,
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: s.height * 0.03),
                            const Center(
                              child: Text(
                                "Summary Report",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 17,
                                  color: bluebg,
                                ),
                              ),
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: s.width * 0.03, vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      color: black.withOpacity(.1),
                                      offset: const Offset(1, 2),
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: s.width * 0.1,
                                        height: s.width * 0.1,
                                      ),
                                      const Text(
                                        "Vehicle Details",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                          color: bluebg,
                                        ),
                                      ),
                                      Container(
                                        width: s.width * 0.1,
                                        height: s.width * 0.1,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: white,
                                            boxShadow: [
                                              BoxShadow(
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                color: black.withOpacity(.1),
                                                offset: const Offset(-1, 2),
                                              ),
                                            ]),
                                        child: IconButton(
                                          icon: const Icon(
                                            Iconsax.add,
                                            color: bluebg,
                                          ),
                                          onPressed: () => {
                                            showDialog(
                                                context: context,
                                                builder: (context) => Dialog(
                                                      insetAnimationCurve:
                                                          Curves.easeInCubic,
                                                      insetAnimationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  500),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                          s.width * 0.03,
                                                        ),
                                                        child: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                  color:
                                                                      bluebg),
                                                              child: Padding(
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            s.height *
                                                                                0.02),
                                                                child:
                                                                    const Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Text(
                                                                      "Assign Vehicle",
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "Nunito",
                                                                        fontSize:
                                                                            20,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                        color:
                                                                            white,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: s.height *
                                                                  0.02,
                                                            ),
                                                            StreamBuilder<
                                                                    QuerySnapshot>(
                                                                stream: fb
                                                                    .collection(
                                                                        "organizations")
                                                                    .doc(
                                                                        "${widget.orgId}")
                                                                    .collection(
                                                                        "Garage")
                                                                    .snapshots(),
                                                                builder: (BuildContext
                                                                        context,
                                                                    AsyncSnapshot<
                                                                            QuerySnapshot>
                                                                        snapshot) {
                                                                  if (snapshot
                                                                      .hasError) {}
                                                                  if (snapshot
                                                                          .connectionState ==
                                                                      ConnectionState
                                                                          .waiting) {
                                                                    return Center(
                                                                      child:
                                                                          SizedBox(
                                                                        width: s.width *
                                                                            0.25,
                                                                        height: s.width *
                                                                            0.25,
                                                                        child:
                                                                            const LoadingIndicator(
                                                                          indicatorType:
                                                                              Indicator.ballClipRotateMultiple,
                                                                          colors: [
                                                                            bluebg
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }

                                                                  final List
                                                                      vehicle =
                                                                      [];
                                                                  snapshot.data!
                                                                      .docs
                                                                      .map((DocumentSnapshot
                                                                          document) {
                                                                    Map a = document
                                                                            .data()
                                                                        as Map<
                                                                            String,
                                                                            dynamic>;
                                                                    vehicle
                                                                        .add(a);
                                                                  }).toList();

                                                                  return Column(
                                                                    children: [
                                                                      Container(
                                                                          child: vehicle.isEmpty
                                                                              ? Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: s.width * 0.01),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Image.asset("assets/Icons/not_asigned.jpg"),
                                                                                      const Text(
                                                                                        "No Vehicle Available",
                                                                                        style: TextStyle(fontFamily: "Montserrat", fontSize: 15, color: Colors.blueGrey),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                              : null),
                                                                      for (var i =
                                                                              0;
                                                                          i < vehicle.length;
                                                                          i++) ...[
                                                                        Padding(
                                                                          padding:
                                                                              const EdgeInsets.symmetric(vertical: 5.0),
                                                                          child:
                                                                              AssignVehiclereportcard(
                                                                            orgId:
                                                                                widget.orgId,
                                                                            name:
                                                                                vehicle[i]['name'],
                                                                            desc:
                                                                                vehicle[i]['description'],
                                                                            type:
                                                                                vehicle[i]['type'],
                                                                            status:
                                                                                vehicle[i]['status'],
                                                                            docname:
                                                                                vehicle[i]['docname'],
                                                                            techname:
                                                                                widget.techname,
                                                                            techuid:
                                                                                widget.techuid,
                                                                            statusdesc:
                                                                                vehicle[i]['statusdesc'],
                                                                            update:
                                                                                vehicle[i]['update'],
                                                                            uptime:
                                                                                vehicle[i]['uptime'],
                                                                          ),
                                                                        ),
                                                                      ]
                                                                    ],
                                                                  );
                                                                }),
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: streamreport.snapshots(),
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
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    s.width *
                                                                        0.01),
                                                        child: Column(
                                                          children: [
                                                            Image.asset(
                                                              "assets/Icons/warning.png",
                                                              height: s.height *
                                                                  0.12,
                                                            ),
                                                            const Text(
                                                              "No Vehicle Used !",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 17,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    : null),
                                            for (var i = 0;
                                                i < vehicle.length;
                                                i++) ...[
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5.0),
                                                child: Vreportsubcard(
                                                  name: vehicle[i]['name'],
                                                  vdocname: vehicle[i]
                                                      ['vdocname'],
                                                  docname: vehicle[i]
                                                      ['docname'],
                                                  techuid: vehicle[i]
                                                      ['techuid'],
                                                  update: vehicle[i]['upDate'],
                                                  start: vehicle[i]['start'],
                                                  end: vehicle[i]['end'],
                                                  desc: vehicle[i]['desc'],
                                                  uptime: vehicle[i]['upTime'],
                                                  techname: vehicle[i]
                                                      ['techname'],
                                                  type: vehicle[i]['type'],
                                                ),
                                              )
                                            ]
                                          ],
                                        );
                                      }),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: s.height * 0.03,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: s.width * 0.03, vertical: 15),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: white,
                                  boxShadow: [
                                    BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      color: black.withOpacity(.1),
                                      offset: const Offset(1, 2),
                                    ),
                                  ]),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Expense",
                                            style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              color: bluebg,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Divider(),
                                      const Text(
                                        "Today's Expense Details",
                                        style: TextStyle(
                                          fontFamily: "Montserrat",
                                          fontSize: 15,
                                        ),
                                      ),
                                      // when the data is already updated then show the data
                                      FutureBuilder<DocumentSnapshot>(
                                        future: fb
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
                                            .get(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<DocumentSnapshot>
                                                snapshot) {
                                          if (snapshot.hasError) {
                                            return const Text(
                                                "Something went wrong");
                                          }

                                          if (snapshot.hasData &&
                                              !snapshot.data!.exists) {
                                            return Column(
                                              children: [
                                                SizedBox(
                                                    height: s.height * 0.02),
                                                TextFormField(
                                                  autofocus: false,
                                                  minLines: 6,
                                                  maxLines: 8,
                                                  controller: expenseController,
                                                  keyboardType:
                                                      TextInputType.multiline,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return ("Please fill Expense Details");
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    expenseController.text =
                                                        value!;
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets
                                                                .fromLTRB(
                                                            20, 15, 20, 15),
                                                    hintText: "Expense Details",
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  ),
                                                  style: const TextStyle(
                                                    fontFamily: "Montserrat",
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: s.height * 0.02,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        FocusManager.instance
                                                            .primaryFocus
                                                            ?.unfocus();
                                                        PanaraConfirmDialog
                                                            .show(
                                                          context,
                                                          title:
                                                              "Are you sure?",
                                                          message:
                                                              "Do you really want to submit Expense details?",
                                                          confirmButtonText:
                                                              "Confirm",
                                                          cancelButtonText:
                                                              "Cancel",
                                                          onTapCancel: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          onTapConfirm: () =>
                                                              up_expense(
                                                                  context),
                                                          panaraDialogType:
                                                              PanaraDialogType
                                                                  .success,
                                                          barrierDismissible:
                                                              false,
                                                          textColor:
                                                              const Color(
                                                                  0XFF727272),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: s.width * 0.3,
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 10),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color: bluebg,
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Submit",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  "Montserrat",
                                                              fontSize: 17,
                                                              color: white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          }

                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            Map<String, dynamic> data =
                                                snapshot.data!.data()
                                                    as Map<String, dynamic>;

                                            // Data expense data checker
                                            if (data['expense'] != null) {
                                              expnse_sub = true;
                                            }
                                            return Column(
                                              children: [
                                                SizedBox(
                                                    height: s.height * 0.02),
                                                Stack(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  s.width *
                                                                      0.03,
                                                              vertical: 25),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: white),
                                                          boxShadow: [
                                                            const BoxShadow(
                                                              color: white,
                                                            ),
                                                            const BoxShadow(
                                                              color: bluebg,
                                                              spreadRadius:
                                                                  -1.0,
                                                              blurRadius: 5.0,
                                                            ),
                                                            BoxShadow(
                                                              spreadRadius: 2,
                                                              blurRadius: 4,
                                                              color: white
                                                                  .withOpacity(
                                                                      .1),
                                                              offset:
                                                                  const Offset(
                                                                      -1, -2),
                                                            ),
                                                          ]),
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "${data['expense']}",
                                                              style:
                                                                  const TextStyle(
                                                                fontFamily:
                                                                    "Montserrat",
                                                                fontSize: 15,
                                                                color: white,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 5,
                                                                  right: 5),
                                                          child: InkWell(
                                                            onTap: () =>
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            EditexpenseDetailsDialog(
                                                                              techuid: widget.techuid,
                                                                              expense: data['expense'],
                                                                              orgId: widget.orgId,
                                                                            )),
                                                            child: const Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text("EDIT",
                                                                    style: TextStyle(
                                                                        fontFamily:
                                                                            "Montserrat",
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            white)),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Icon(
                                                                  Icons
                                                                      .edit_outlined,
                                                                  color: white,
                                                                  size: 18,
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            );
                                          }

                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: white,
                                              boxShadow: [
                                                BoxShadow(
                                                  offset: const Offset(0, 10),
                                                  blurRadius: 20,
                                                  color: secondbg
                                                      .withOpacity(0.23),
                                                ),
                                              ],
                                            ),
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: s.width * 0.1),
                                              child: Center(
                                                child: SizedBox(
                                                  width: s.width * 0.15,
                                                  height: s.width * 0.15,
                                                  child: const LoadingIndicator(
                                                    indicatorType: Indicator
                                                        .ballClipRotateMultiple,
                                                    colors: [bluebg],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(height: s.height * 0.25),
                          ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void buildStream() {
    FirebaseFirestore fb = FirebaseFirestore.instance;

    DateTime now = DateTime.now();
    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    setState(() {
      streamreport = fb
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
          .collection("vehicle");
    });
  }

  Future<void> up_expense(BuildContext context) async {
    FirebaseFirestore fb = FirebaseFirestore.instance;

    DateTime now = DateTime.now();
    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    if (_formKey.currentState!.validate()) {
      Navigator.of(context).pop();
      showDialog(context: context, builder: (context) => const LoadingDialog());

      fb
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
          .set({'expense': expenseController.text, 'submit': false}).then(
              (value) {
        Fluttertoast.showToast(
          msg: 'Expense Details Updated Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: bluebg,
          textColor: white,
        );
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg: 'Something went wrong :(',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: cheryred,
          textColor: white,
        );
      });

      Navigator.of(context).pop();
    }
  }
}

// ignore: must_be_immutable
class EditexpenseDetailsDialog extends StatefulWidget {
  String? techuid;
  String? expense;
  String? orgId;

  EditexpenseDetailsDialog({
    super.key,
    this.techuid,
    this.expense,
    this.orgId,
  });

  @override
  State<EditexpenseDetailsDialog> createState() =>
      _EditexpenseDetailsDialogState();
}

class _EditexpenseDetailsDialogState extends State<EditexpenseDetailsDialog> {
  // Form Key
  final form_key = GlobalKey<FormState>();

  // Text editor controller
  final TextEditingController expenseController = TextEditingController();

  @override
  void initState() {
    super.initState();

    expenseController.text = "${widget.expense}";
  }

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return Dialog(
      insetAnimationCurve: Curves.easeInCubic,
      insetAnimationDuration: const Duration(milliseconds: 300),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: s.width * 0.03,
          vertical: s.height * 0.03,
        ),
        child: Form(
          key: form_key,
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Expense Details",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                const Text(
                  "Expense Details",
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 17,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: s.height * 0.01,
                ),
                TextFormField(
                  autofocus: false,
                  minLines: 3,
                  maxLines: 4,
                  controller: expenseController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please enter the Expense Details");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    expenseController.text = value!;
                  },
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Expense Details",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  style: const TextStyle(
                    fontFamily: "Montserrat",
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: s.height * 0.02,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: s.height * 0.01),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0XFFeef1f7)),
                              child: const Center(
                                  child: Text(
                                "Cancel",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: Color(0XFFa4a6aa),
                                  fontSize: 15,
                                ),
                              ))),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        flex: 1,
                        child: InkWell(
                          onTap: () => up_editedexpense(context),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: s.height * 0.01),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: bluebg),
                              child: const Center(
                                  child: Text(
                                "Update",
                                style: TextStyle(
                                  fontFamily: "Montserrat",
                                  color: white,
                                  fontSize: 15,
                                ),
                              ))),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }

  void up_editedexpense(BuildContext context) {
    FirebaseFirestore fb = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);

    if (form_key.currentState!.validate()) {
      Navigator.of(context).pop();

      showDialog(context: context, builder: (context) => const LoadingDialog());
      fb
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
          .update({'expense': expenseController.text}).then((value) {
        Fluttertoast.showToast(
          msg: 'Expense Details Updated Successfully',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: bluebg,
          textColor: white,
        );
      }).onError((error, stackTrace) {
        Fluttertoast.showToast(
          msg: 'Something went wrong :(',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: cheryred,
          textColor: white,
        );
      });

      Navigator.of(context).pop();
    }
  }
}
