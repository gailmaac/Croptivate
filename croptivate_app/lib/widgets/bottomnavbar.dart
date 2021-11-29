import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:croptivate_app/widgets/messagesscreen.dart';
import 'package:flutter/material.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// getusers() async {
//   var name = '';
//   await FirebaseFirestore.instance.collection('userBuyer').get().then((querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         if (_auth.currentUser?.uid == doc.id) {
//           name = doc['fname'] + ' ' + doc['lname'];
//           print(name);

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  bool loading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid = '';
  List allcontacts = [];
  int Notifs = 0;

  @override
  void initState() {
    super.initState();
    getContacts();
    countnotifs();
  }

  countnotifs() {
    int y = 0;
    for (var x in allcontacts) {
      y += int.parse(x['messagescount']);
    }
    setState(() {
      Notifs = y;
    });
  }

  getContacts() async {
    await FirebaseFirestore.instance
        .collection('Chats')
        .doc(uid)
        .collection('Contacts')
        .doc()
        .get()
        .then((doc) {
      allcontacts.add(doc.data());
    });
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 20,
          top: 10,
        ),
        height: 60,
        decoration: BoxDecoration(color: cWhite, boxShadow: [
          BoxShadow(
            offset: Offset(1, 10),
            blurRadius: 35,
            color: cGrey.withOpacity(0.40),
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/homebuyer');
              },
              icon: Icon(
                Icons.home_outlined,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Messagescreen()));
              },
              icon: Icon(
                Icons.chat_bubble_outline_rounded,
                //color: Notifs > 0 ? Colors.red : cBlack,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/basket');
              },
              icon: Icon(
                Icons.shopping_basket_outlined,
              ),
            ),
            IconButton(
                onPressed: () async {
                  var name = '';
                  var address = '';
                  await FirebaseFirestore.instance
                      .collection('userBuyer')
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      if (_auth.currentUser?.uid == doc.id) {
                        name = doc['first name'] + ' ' + doc['last name'];
                        print(name);
                      } else {
                        print("something went wrong");
                      }
                    });
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UserProfile()));
                },
                icon: Icon(
                  Icons.person_outline_rounded,
                )),
          ],
        ));
  }
}
