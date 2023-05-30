import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:insighteye_app/components/loadingDialog.dart';
import 'package:insighteye_app/constants/constants.dart';
import 'package:insighteye_app/Screens/models/techvehicle.dart';
import 'package:insighteye_app/Screens/models/vehicleusagehistory.dart';
// date
import 'package:intl/intl.dart';
import 'package:iconsax/iconsax.dart';
import 'package:motion_toast/motion_toast.dart';

// ignore: must_be_immutable
class AssignVehiclereportcard extends StatefulWidget {
  String? name;
  String? desc;
  String? type;
  String? status;
  String? statusdesc;
  String? techname;
  String? docname;
  String? techuid;
  String? update;
  String? uptime;
  String? orgId;

  AssignVehiclereportcard({
    Key? key,
    this.name,
    this.desc,
    this.type,
    this.status,
    this.statusdesc,
    this.techname,
    this.docname,
    this.techuid,
    this.update,
    this.uptime,
    this.orgId,
  }) : super(key: key);

  @override
  State<AssignVehiclereportcard> createState() =>
      _AssignVehiclereportcardState();
}

class _AssignVehiclereportcardState extends State<AssignVehiclereportcard> {
  FirebaseFirestore fb = FirebaseFirestore.instance;
  bool isviz = false;

  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.pop(context);
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Iconsax.danger,
                              color: Colors.yellow,
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
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "* Please ensure that you ${widget.name} is not already existed in the Vehicle list",
                            style: const TextStyle(
                              fontFamily: "Montserrat",
                              color: Color(0XFF949494),
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: 'Do you really Drive ',
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                                color: black,
                                // fontWeight: FontWeight.bold,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: '${widget.name}',
                                  style: const TextStyle(
                                    fontFamily: "Montserrat",
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const TextSpan(
                                  text: ' Today?',
                                  style: TextStyle(
                                    fontFamily: "Montserrat",
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(
                          height: 20,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                  onTap: () => assignvehicle(context),
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: s.height * 0.01),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: bluebg),
                                      child: const Center(
                                          child: Text(
                                        "Add",
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
      },
      child: Container(
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: s.width * 0.16,
                height: s.width * 0.16,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: vybg),
                clipBehavior: Clip.hardEdge,
                child: Vehicleimagewrapper(widget.type),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.width * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.name}",
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${widget.desc}",
                        style: const TextStyle(
                          fontFamily: "Montserrat",
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // upload asssigned details
  Future<void> assignvehicle(BuildContext context) async {
    DateTime now = DateTime.now();
    String update = DateFormat('d MM y').format(now);
    String uptime = DateFormat('h:mma').format(now);
    String docName = DateFormat('kk:mm:ss').format(now);

    // Report
    String day = DateFormat('d').format(now);
    String month = DateFormat('MM').format(now);
    String year = DateFormat('y').format(now);
    // history
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
      status: "Assigned (Self)"
    );

    Techvehicle techv = Techvehicle(
      name: widget.name,
      upDate: update,
      upTime: uptime,
      techuid: widget.techuid,
      vdocname: widget.docname,
      docname: docName,
      techname: widget.techname,
      type: widget.type,
    );

    showDialog(context: context, builder: (context) => const LoadingDialog());

    // report added
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
        .collection("vehicle")
        .doc(docName)
        .set(techv.toMap());

    // history added
    await fb
    .collection("organizations")
          .doc("${widget.orgId}")
        .collection("GarageUsage")
        .doc(usagedocname)
        .set(vusage.toMap())
        .then((v) => print("Vehicle assigned history added"));

    Navigator.of(context).pop();
    Navigator.pop(context);
    MotionToast.success(
      title: Text(
        "Vehicle assigned to ${widget.techname}",
        style: const TextStyle(
          fontFamily: "Montserrat",
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      description: const Text(
        "Successfully vehicle assigned",
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
