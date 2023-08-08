import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:insighteye_app/Screens/Auth/org_reg_src.dart';
import 'package:insighteye_app/constants/constants.dart';

class OrgDetailsScreen extends StatefulWidget {
  const OrgDetailsScreen({super.key});

  @override
  State<OrgDetailsScreen> createState() => _OrgDetailsScreenState();
}

class _OrgDetailsScreenState extends State<OrgDetailsScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _orgnameController = TextEditingController();
  final TextEditingController _orgtypeController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Responsive Size
    Size s = MediaQuery.of(context).size;

    return Container(
      width: s.width,
      height: s.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/Images/bg.png',
          ),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: s.width * 0.9,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(41),
                    color: const Color(0xFFFEFEFF)),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: s.width * 0.0864),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: s.height * 0.0529,
                      ),
                      const Text(
                        'Create an Account',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                      const Text(
                        'You can be a guardian',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Montserrat"),
                      ),
                      SizedBox(
                        height: s.height * 0.03,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              autofocus: false,
                              controller: _orgnameController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Organisation Name can't be Empty");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _orgnameController.text = value!;
                              },
                              cursorColor: const Color(0XFF57308D),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Organisation Name",
                                labelStyle: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                  color: nonactivetxt,
                                ),
                                fillColor: Colors.white,
                                filled: true,
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: s.height * 0.0269),
                            TextFormField(
                              autofocus: false,
                              controller: _orgtypeController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Organisation Type can't be Empty");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _orgtypeController.text = value!;
                              },
                              cursorColor: const Color(0XFF57308D),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Organisation Type",
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                  color: nonactivetxt,
                                ),
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: s.height * 0.0269),
                            TextFormField(
                              autofocus: false,
                              controller: _addressController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return ("Organisation Address can't be Empty");
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _addressController.text = value!;
                              },
                              cursorColor: const Color(0XFF57308D),
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                labelText: "Organisation Address",
                                fillColor: Colors.white,
                                filled: true,
                                labelStyle: const TextStyle(
                                  fontFamily: "Montserrat",
                                  fontSize: 15,
                                  color: nonactivetxt,
                                ),
                                errorStyle:
                                    const TextStyle(fontFamily: "Montserrat"),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade400)),
                                errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Color(0XFFff0a54), width: 2.0)),
                                focusedErrorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                    borderSide: const BorderSide(
                                        color: Colors.red, width: 2.0)),
                              ),
                              style: const TextStyle(
                                fontFamily: "Montserrat",
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(
                              height: s.height * 0.0326,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.deepPurple.shade300,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.0, 1.0],
                                  colors: [
                                    Color(0XFF7A43AB),
                                    Color(0XFF57308D),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black26,
                                      offset: Offset(0, 4),
                                      blurRadius: 5.0)
                                ],
                              ),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                  ),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(50, 50)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                  shadowColor: MaterialStateProperty.all(
                                      Colors.transparent),
                                ),
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Next'.toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: "Montserrat"),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                    ],
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                OrgRegistrationSrc(
                                                  orgname:
                                                      _orgnameController.text,
                                                  orgtype:
                                                      _orgtypeController.text,
                                                  orgAddress:
                                                      _addressController.text,
                                                )));
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: s.height * 0.0529,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
