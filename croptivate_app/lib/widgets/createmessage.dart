import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/user.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class createmessage extends StatefulWidget {
  const createmessage({Key? key}) : super(key: key);

  @override
  _createmessageState createState() => _createmessageState();
}

class _createmessageState extends State<createmessage> {
  TextEditingController _searchto = TextEditingController();
  List users = [];
  String receiver = '';
  late Future usersloaded;
  List resultusers = [];
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid = '';
  final storecontact = FirebaseFirestore.instance;

  Future<void> inputData() async {
    final User user = await auth.currentUser!;
    uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  @override
  void initState() {
    super.initState();
    _searchto.addListener(_onsearchChanged);
  }

  @override
  void dispose() {
    _searchto.removeListener(_onsearchChanged);
    _searchto.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    usersloaded = getusers();
  }

  _onsearchChanged() {
    searchuserlist();
    print(_searchto.text);
  }

  getusers() async {
    List user = [];
    try {
      await FirebaseFirestore.instance
          .collection('userBuyer')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          user.add(doc.data());
        });
      });
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          user.add(doc.data());
        });
      });

      setState(() {
        users = user;
      });
      searchuserlist();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  searchuserlist() {
    var showresults = [];
    if (_searchto.text != '') {
      users.forEach((doc) {
        var name = doc['first name'].toString().toLowerCase() +
            ' ' +
            doc['last name'].toString().toLowerCase() +
            ' ' +
            doc['contact number'].toString();
        if (name.contains(_searchto.text)) {
          showresults.add(doc);
        }
      });
    }
    setState(() {
      resultusers = showresults;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: IconThemeData(color: cGreen),
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
        backgroundColor: cWhite,
        elevation: 0.0,
        title: Text(
          "Create Message",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: cGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        //color: Colors.green[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: cGrey.withOpacity(0.23),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _searchto,
                      decoration: InputDecoration(
                        fillColor: cWhite,
                        border: InputBorder.none,
                        hintText: "To:",
                        hintStyle: inputBodyText.copyWith(color: cBlack),
                      ),
                      style: cBodyText.copyWith(color: cBlack),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                  )),
            ),
            Expanded(
                child: ListView.builder(
                    itemCount: resultusers.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: CircleAvatar(backgroundColor: cGreen),
                        title: Text(
                            resultusers[i]['first name'].toString() +
                                ' ' +
                                resultusers[i]['last name'].toString(),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500)),
                        tileColor: cWhite,
                        subtitle: Text(
                            resultusers[i]['contact number'].toString() +
                                resultusers[i]['location'].toString(),
                            style:
                                smallBodyText.copyWith(color: Colors.black45)),
                        onTap: () async {
                          inputData();
                          var name = '';
                          await FirebaseFirestore.instance
                              .collection('userBuyer')
                              .get()
                              .then((querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              var x = doc['first name'] +
                                  doc['last name'] +
                                  doc['contact number'].toString();
                              var y = resultusers[i]['first name'] +
                                  resultusers[i]['last name'] +
                                  resultusers[i]['contact number'].toString();
                              if (x == y) {
                                receiver = doc.id;
                                name =
                                    doc['first name'] + ' ' + doc['last name'];
                              }
                            });
                          });
                          await FirebaseFirestore.instance
                              .collection('userSeller')
                              .get()
                              .then((querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              var a = doc['first name'] +
                                  doc['last name'] +
                                  doc['contact number'].toString();
                              var b = resultusers[i]['first name'] +
                                  resultusers[i]['last name'] +
                                  resultusers[i]['contact number'].toString();
                              if (a == b) {
                                receiver = doc.id;
                                name =
                                    doc['first name'] + ' ' + doc['last name'];
                              }
                            });
                          });
                          storecontact
                              .collection('Chats')
                              .doc(uid)
                              .collection('Contacts')
                              .doc(receiver)
                              .set({
                            'contactname': resultusers[i]['first name'] +
                                ' ' +
                                resultusers[i]['last name'],
                            'messagescount': 0,
                            'Profile Picture': '',
                          });
                          storecontact
                              .collection('Chats')
                              .doc(receiver)
                              .collection('Contacts')
                              .doc(uid)
                              .set({
                            'contactname': name,
                            'messagescount': 0,
                            'Profile Picture': '',
                          });
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Messages(
                                        sender: uid,
                                        receiver: receiver,
                                        name: resultusers[i]['first name'] +
                                            ' ' +
                                            resultusers[i]['last name'],
                                      )));
                        },
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
