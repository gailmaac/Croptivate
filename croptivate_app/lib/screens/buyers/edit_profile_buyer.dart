import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/user.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/authentication/sign_in.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class EditProfileBuyer extends StatefulWidget {

  @override
  _EditProfileBuyerState createState() => _EditProfileBuyerState();
  
}

class _EditProfileBuyerState extends State<EditProfileBuyer> {
  final _formKey = GlobalKey<FormState>();
  bool loading = true;
  String name = '';
  String location = '';
  String contactnumber = '';
  String profilepic = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  TextEditingController nameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();

  getuser() async {
    try {
      await FirebaseFirestore.instance
          .collection('userBuyer')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (_auth.currentUser!.uid == doc.id) {
            setState(() {
              name = doc['first name'] + ' ' + doc['last name'];
              contactnumber = doc['contact number'].toString();
              location = doc['location'];
              profilepic = doc['Profile Picture'].toString();
            });
          }
        });
      }).whenComplete(() {
        setState(() {
          loading = false;
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void initState() {
    super.initState();
    nameController.text = name.toString();
    numberController.text = contactnumber.toString();
    locationController.text = location.toString();
  }

  File ? image;
  set _imageFile(XFile? value) {
    image = (value == null ? null : [value]) as File?;
  }

  Future chooseImage(ImageSource source) async {

    try {
      final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() => this.image = imageTemporary);
    } on PlatformException catch(error) {
      print("Failed to pick image: $error");
    }
  }

  selectImage(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Update Profile Picture",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          )),
          children: <Widget>[
            SimpleDialogOption(
              child: TextButton(
                child: Text("Take Picture with Camera",
                style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
              onPressed: () => chooseImage(ImageSource.camera),
              )
            ),
            SimpleDialogOption(
              child: TextButton(
                child: Text("Choose Image from Gallery",
                  style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
                onPressed: () => chooseImage(ImageSource.gallery),
              )
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ]
        );
      }
    );
  }

  Widget buildEditIcon() => buildCircle(
    all: 3, 
    color: cWhite,
    child: buildCircle(
      color: cGreen,
      all: 8,
      child: Icon(
        Icons.edit_outlined,
        size: 20,
        color: cWhite,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) => 
    ClipOval(
      child: Container(
        child: child,
        padding: EdgeInsets.all(all),
        color: color,
      ),
    );

  @override
  Widget build(BuildContext context) {
    getuser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Edit My Profile",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: cGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: cBlack,
            size: 15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  // getusers()
                ],
              ),
              SizedBox(height: 20),
              Stack(
                children: [ 
                  InkWell(
                  onTap: () {
                    selectImage(context);
                  },
                  child: image == null 
                      ? CircleAvatar(
                          radius: 80.0,
                          child: ClipOval(
                            child: Image.network(
                              profilepic,
                              fit: BoxFit.cover,
                              width: 160.0,
                              height: 160.0,
                            )
                          ),
                        )
                      : Container(
                          height: 160,
                          width: 160,
                          child: ClipOval(
                            child: Image.file(
                              File(image!.path),
                              fit: BoxFit.cover,
                              width: 160.0,
                              height: 160.0,
                            )
                          )
                        )  
                  ),
                  Positioned(
                  bottom: 0,
                  right: 4,
                  child: InkWell(
                    onTap: () {
                      selectImage(context);            
                    },
                    child: buildEditIcon()))
                ]
              ),
              SizedBox(height: 20),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Icon(
                      Icons.person_outline_rounded,
                      color: cGreen
                    ),
                    SizedBox(width: 40,),
                    Flexible(
                      child: TextFormField(
                        controller: nameController,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: cBlack
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Divider(),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.phone_android_rounded,
                      color: cGreen
                    ),
                    SizedBox(width: 40,),
                    Text(
                      contactnumber,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: cBlack
                      ),
                    ),
                  ],
                ),
              ),
              
              Divider(),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: cGreen
                    ),
                    SizedBox(width: 40,),
                    Flexible(
                      child: TextFormField(
                        controller: locationController,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                          color: cBlack
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Divider(),

              SizedBox(height: 20),
              
              updateButton()
            ],
          ),
        ),
      ),
    );
  }

  //Edit Profile Button
  Widget editProfilebutton() {
    return TextButton(
        onPressed: () {
          Navigator.push(context,
          MaterialPageRoute(builder: (context) => EditProfileBuyer()));
        },
        child: 
          Text("Edit My Profile",
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 20,
              color: cGreen,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
            )
          ),
        );
  }

  Widget updateButton() {
    return TextButton(
        onPressed: () async {
          //update firebase
        },
        child: Container(
          decoration: BoxDecoration(
              color: cGreen, borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(20),
          child: 
              Center(
                child: Text("Update Profile",
                    style: TextStyle(
                      fontSize: 20,
                      color: cWhite,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                    )),
              ),
          width: 350,
          height: 65,
        ));
  }

  //Sign Out Button
  Widget signOutButton() {
    return TextButton(
        onPressed: () async {
          await _auth.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignIn()));
        },
        child: Container(
          decoration: BoxDecoration(
              color: cGreen, borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.logout_rounded, color: cWhite),
              SizedBox(width: 30),
              Text("Sign Out",
                  style: TextStyle(
                    fontSize: 20,
                    color: cWhite,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          width: 350,
          height: 65,
        ));
  }
}