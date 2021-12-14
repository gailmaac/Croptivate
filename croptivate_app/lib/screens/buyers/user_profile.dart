import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/user_model_buyer.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/authentication/sign_in.dart';
import 'package:croptivate_app/screens/sellers/edit_profile.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/widgets/profile_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/services/database.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
  static const String routeName = '/userprofilebuyer';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => UserProfile());
  }
}

bool loading = true;
String resultuser = '';

class _UserProfileState extends State<UserProfile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String name = '';
  String location = '';
  String contactnumber = '';
  String profilepic = '';

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

  @override
  Widget build(BuildContext context) {
    getuser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Profile Buyer",
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
            color: cBlack,
            icon: Icon(Icons.settings_outlined),
          )
        ],
      ),
      body: ListView(
        // physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              // getusers()
            ],
          ),
          SizedBox(height: 200),
          loading == false
              ? Image.network(profilepic, height: 40, width: 40)
              : Image.asset(
                  "assets/addpic.png",
                  height: 40,
                  width: 40,
                ),
          Text(name),
          Text(contactnumber),
          Text(location),
          Ordersbutton(),
          const SizedBox(height: 50),
          signOutButton()
        ],
      ),
    );
  }

  // Widget buildName(User user) => Column(
  //   children: [
  //     Text(
  //       user.fname + ' ' +  user.lname,
  //       style: TextStyle(
  //         fontWeight: FontWeight.bold,
  //         fontFamily: 'Poppins',
  //         color: cBlack,
  //         fontSize: 24
  //       ),
  //     ),
  //     const SizedBox(height: 4),
  //   ],
  // );

  //Track Order Button
  Widget trackOrderbutton() {
    return TextButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.location_on_outlined, color: cGreen),
              SizedBox(width: 30),
              Text("Track my Order",
                  style: TextStyle(
                    fontSize: 20,
                    color: cBlack,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          color: Colors.transparent,
          width: double.infinity,
          height: 65,
        ));
  }

  //Favorites Button
  Widget myFavsbutton() {
    return TextButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.favorite_border_rounded, color: cGreen),
              SizedBox(width: 30),
              Text("My Favorites",
                  style: TextStyle(
                    fontSize: 20,
                    color: cBlack,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          color: Colors.transparent,
          width: double.infinity,
          height: 65,
        ));
  }

//Start Selling Button
  Widget Ordersbutton() {
    return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/myorders');
        },
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.storefront_outlined, color: cGreen),
              SizedBox(width: 30),
              Text("My Orders",
                  style: TextStyle(
                    fontSize: 20,
                    color: cBlack,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          color: Colors.transparent,
          width: double.infinity,
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
