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

class EditProfile extends StatefulWidget {
  final firstname;
  final lastname;
  final location;
  final contactnumber;
  final profilepic;
  final shopname;
  const EditProfile(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.location,
      required this.contactnumber,
      required this.shopname,
      required this.profilepic})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final sellerPic = FirebaseStorage.instance.ref();
  bool profilepicChanged = false;
  final buyerInfo = FirebaseFirestore.instance.collection('userSeller');
  bool loading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String profilepic = '';
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController numberController = new TextEditingController();
  TextEditingController locationController = new TextEditingController();
  TextEditingController shopnameController = new TextEditingController();
  String sellerId = Uuid().v4();

  void initState() {
    super.initState();
    firstnameController.text = widget.firstname.toString();
    lastnameController.text = widget.lastname.toString();
    numberController.text = '0' + widget.contactnumber.toString();
    locationController.text = widget.location.toString();
    profilepic = widget.profilepic;
    shopnameController.text = widget.shopname;
  }

  File? image;
  set _imageFile(XFile? value) {
    image = (value == null ? null : [value]) as File?;
  }

  Future updatePostInFirestore({
    String? profilepic,
    String? firstname,
    String? lastname,
    int? contactnumber,
    String? location,
    String? shopname,
  }) async {
    return await FirebaseFirestore.instance
        .collection('userSeller')
        .doc(_auth.currentUser!.uid)
        .update({
      "Profile Picture": profilepic,
      "contact number": contactnumber,
      "first name": firstname,
      "last name": lastname,
      "location": location,
      "shop name": shopname,
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  handleUpdate() async {
    String accimage;
    if (profilepicChanged == true) {
      accimage = await uploadaccImage(image);
    } else {
      accimage = widget.profilepic;
    }

    updatePostInFirestore(
        profilepic: accimage,
        location: locationController.text,
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        contactnumber: int.parse(numberController.text),
        shopname: shopnameController.text);
    firstnameController.clear();
    lastnameController.clear();
    numberController.clear();
    locationController.clear();
    shopnameController.clear();
    setState(() {
      Navigator.pushNamed(context, '/homeseller');
    });
  }

  uploadaccImage(accImage) async {
    UploadTask uploadImage =
        sellerPic.child("sellerImage_$sellerId.jpg").putFile(accImage);
    TaskSnapshot storageImage = await uploadImage;
    String downloadImage = await storageImage.ref.getDownloadURL();
    return downloadImage;
  }

  Future chooseImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (error) {
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
                      fontSize: 20)),
              children: <Widget>[
                SimpleDialogOption(
                    child: TextButton(
                  child: Text(
                    "Take Picture with Camera",
                    style: TextStyle(color: cGreen, fontFamily: 'Poppins'),
                  ),
                  onPressed: () => chooseImage(ImageSource.camera),
                )),
                SimpleDialogOption(
                    child: TextButton(
                  child: Text(
                    "Choose Image from Gallery",
                    style: TextStyle(color: cGreen, fontFamily: 'Poppins'),
                  ),
                  onPressed: () => chooseImage(ImageSource.gallery),
                )),
                SimpleDialogOption(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                )
              ]);
        });
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
              SizedBox(height: 20),
              Stack(children: [
                InkWell(
                    onTap: () {
                      setState(() {
                        profilepicChanged = true;
                      });
                      selectImage(context);
                    },
                    child: image == null
                        ? CircleAvatar(
                            radius: 80.0,
                            child: ClipOval(
                                child: Image.network(
                              widget.profilepic,
                              fit: BoxFit.cover,
                              width: 160.0,
                              height: 160.0,
                            )),
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
                            )))),
                Positioned(
                    bottom: 0,
                    right: 4,
                    child: InkWell(
                        onTap: () {
                          selectImage(context);
                        },
                        child: buildEditIcon()))
              ]),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    Icon(Icons.person_outline_rounded, color: cGreen),
                    SizedBox(
                      width: 40,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: firstnameController,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: cBlack),
                      ),
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: lastnameController,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: cBlack),
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
                    Icon(Icons.phone_android_rounded, color: cGreen),
                    SizedBox(
                      width: 40,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: numberController,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: cBlack),
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
                    Icon(Icons.location_on_outlined, color: cGreen),
                    SizedBox(
                      width: 40,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: locationController,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: cBlack),
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
                    Icon(Icons.store_outlined, color: cGreen),
                    SizedBox(
                      width: 40,
                    ),
                    Flexible(
                      child: TextFormField(
                        controller: shopnameController,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: cBlack),
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

  Widget updateButton() {
    return TextButton(
        onPressed: () async {
          setState(() {
            loading = true;
          });
          handleUpdate();
        },
        child: Container(
          decoration: BoxDecoration(
              color: cGreen, borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(20),
          child: Center(
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
