import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/authentication/sign_in.dart';
import 'package:croptivate_app/screens/sellers/edit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileSeller extends StatefulWidget {
  const UserProfileSeller({Key? key}) : super(key: key);

  @override
  _UserProfileSellerState createState() => _UserProfileSellerState();
  static const String routeName = '/userprofileseller';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => UserProfileSeller());
  }
}

class _UserProfileSellerState extends State<UserProfileSeller> {
  bool loading = true;
  String firstname = '';
  String lastname = '';
  String location = '';
  String contactnumber = '';
  String profilepic = '';
  String shopname = '';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getuser() async {
    // print(_auth.currentUser!.uid);
    try {
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (_auth.currentUser!.uid == doc.id) {
            setState(() {
              firstname = doc['first name'];
              lastname = doc['last name'];
              contactnumber = doc['contact number'].toString();
              location = doc['location'];
              profilepic = doc['Profile Picture'].toString();
              shopname = doc['shop name'];
            });
          }
        });
      }).whenComplete(() {
        loading = false;
      });
    } catch (e) {
      // print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    getuser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          firstname.toString() + ' ' + lastname.toString(),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                // getusers()
              ],
            ),
            SizedBox(height: 20),
            loading == false
                ? Center(
                    child: CircleAvatar(
                      radius: 80.0,
                      child: ClipOval(
                          child: Image.network(
                        profilepic,
                        fit: BoxFit.cover,
                        width: 160.0,
                        height: 160.0,
                      )),
                    ),
                  )
                : Image.asset(
                    "assets/addpic.png",
                    height: 160,
                    width: 160,
                  ),
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
                    child: Text(
                      firstname.toString() + ' ' + lastname.toString(),
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
                  Text(
                    "0" + contactnumber,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: cBlack),
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
                    child: Text(
                      location,
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
                    child: Text(
                      shopname,
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
            editProfilebutton(),
            SizedBox(
              height: 10,
            ),
            signOutButton()
          ],
        ),
      ),
    );
  }

  //Edit Profile Button
  Widget editProfilebutton() {
    return TextButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditProfile(
                      firstname: firstname,
                      lastname: lastname,
                      shopname: shopname,
                      location: location,
                      profilepic: profilepic,
                      contactnumber: contactnumber,
                    )));
      },
      child: Text("Edit My Profile",
          style: TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 20,
            color: cGreen,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
          )),
    );
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
