// ignore_for_file: file_names
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/services.dart';
import 'package:insighteye_app/Screens/Auth/firebase_auth/storage_methods.dart';

import 'package:insighteye_app/screens/Technician/hometech.dart';

import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class CreateProfile extends StatefulWidget {
  String? orgId;
  CreateProfile({Key? key, required this.orgId}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Uint8List? _image;
  //image upload
  late String imageUrl = "Empty";

  // form
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController phn1Controller = TextEditingController();
  final TextEditingController phn2Controller = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void selectImage() async {
    print("Working");
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }
  }

  showSnackBar(String content, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final addressfield = TextFormField(
      autofocus: false,
      controller: addressController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Feild Cannot be empty");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "address",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
    //name field
    final namefield = TextFormField(
      autofocus: false,
      controller: nameController,
      keyboardType: TextInputType.name,
      onSaved: (value) {
        nameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Feild Cannot be empty");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Full Name",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    //designation field
    final designationfield = TextFormField(
      autofocus: false,
      controller: designationController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        designationController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your designation");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Designation",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    //phn2 field
    final phn2field = TextFormField(
      autofocus: false,
      controller: phn2Controller,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        phn2Controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Personal Phone Number");
        } else if (value.length != 10) {
          return ("invalid Phone Number");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Phone Number 2",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    //phn1 field
    final phn1field = TextFormField(
      autofocus: false,
      controller: phn1Controller,
      keyboardType: TextInputType.phone,
      onSaved: (value) {
        phn1Controller.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter your Phone Number");
        } else if (value.length != 10) {
          return ("invalid Phone Number");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Phone Number 1",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    //location field
    final locationfield = TextFormField(
      autofocus: false,
      controller: locationController,
      keyboardType: TextInputType.text,
      onSaved: (value) {
        locationController.text = value!;
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Home Location");
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: "Home Location",
        labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    "Create Profile",
                    style: TextStyle(
                        fontFamily: "Nunito",
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => selectImage(),
                  child: Stack(
                    children: [
                      // Image picker
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 5, color: Colors.white),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 20,
                              offset: Offset(5, 5),
                            ),
                          ],
                        ),
                        child: _image != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(_image!),
                              )
                            : Icon(
                                Icons.person,
                                color: Colors.grey.shade300,
                                size: 80.0,
                              ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(80, 80, 0, 0),
                        child: _image != null
                            ? const Icon(
                                Icons.add_circle,
                                color: Colors.transparent,
                              )
                            : Icon(
                                Icons.add_circle,
                                color: Colors.grey.shade700,
                                size: 25.0,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      namefield,
                      const SizedBox(
                        height: 35,
                      ),
                      addressfield,
                      const SizedBox(
                        height: 35,
                      ),
                      designationfield,
                      const SizedBox(
                        height: 35,
                      ),
                      phn1field,
                      const SizedBox(
                        height: 35,
                      ),
                      phn2field,
                      const SizedBox(
                        height: 35,
                      ),
                      locationfield,
                      const SizedBox(
                        height: 35,
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    // padding: const EdgeInsets.symmetric(horizontal: 50),
                    // shape: RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("CANCEL",
                        style: TextStyle(
                            fontFamily: "Nunito",
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      uploadData();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    child: const Text(
                      "SAVE",
                      style: TextStyle(
                          fontFamily: "Nunito",
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 35,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String labelText) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        validator: (value) {
          if (value!.isEmpty) {
            return ("Feild Cannot be empty");
          }
          return null;
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          labelText: labelText,
          labelStyle: const TextStyle(fontFamily: "Nunito", fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  void uploadData() async {
    final user = FirebaseAuth.instance.currentUser;

    if (_formKey.currentState!.validate()) {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', _image!, false);

      if (user != null) {
        // Updated address
        await user.updatePhotoURL(photoUrl);
      }

      await firebaseFirestore
          .collection("organizations")
          .doc("${widget.orgId}")
          .collection("technician")
          .doc("${user?.uid}")
          .update({
        "name": nameController.text,
        "address": addressController.text,
        "designation": designationController.text,
        "phn1": phn1Controller.text,
        "phn2": phn2Controller.text,
        "location": locationController.text,
        "imgUrl": photoUrl,
      }).then((value) {
        Fluttertoast.showToast(msg: "Profile Created Successfully");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomeTech()));
      }, onError: (error) {
        Fluttertoast.showToast(msg: "Failed to create profile :( $error");
        return Future.value(null); // Return a Future that resolves to null
      });
    }
  }
}
