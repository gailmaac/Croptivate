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
        var name = doc['fname'].toString().toLowerCase() +
            ' ' +
            doc['lname'].toString().toLowerCase() +
            ' ' +
            doc['cnum'].toString();
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
    print(' omg ' + users.length.toString());
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(child: Text('Create Message')),
          backgroundColor: Colors.green[400]),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        //color: Colors.green[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                padding: EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[500]!.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: TextField(
                    controller: _searchto,
                    decoration: InputDecoration(
                      fillColor: Colors.green[200],
                      border: InputBorder.none,
                      hintText: "To:",
                      hintStyle: inputBodyText,
                    ),
                    style: cBodyText,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                )),
            Expanded(
                child: ListView.builder(
                    itemCount: resultusers.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Text(resultusers[i]['lname'].toString() +
                            ' ' +
                            resultusers[i]['lname'].toString()),
                        tileColor: Colors.green[200],
                        subtitle: Text(resultusers[i]['cnum'].toString()),
                        onTap: () async {
                          inputData();
                          var name = '';
                          await FirebaseFirestore.instance
                              .collection('userBuyer')
                              .get()
                              .then((querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              var x = doc['fname'] + doc['lname'] + doc['cnum'];
                              var y = resultusers[i]['fname'] +
                                  resultusers[i]['lname'] +
                                  resultusers[i]['cnum'];
                              if (x == y) {
                                receiver = doc.id;
                                name = doc['fname'] + ' ' + doc['lname'];
                              }
                            });
                          });
                          await FirebaseFirestore.instance
                              .collection('userSeller')
                              .get()
                              .then((querySnapshot) {
                            querySnapshot.docs.forEach((doc) {
                              var a = doc['fname'] + doc['lname'] + doc['cnum'];
                              var b = resultusers[i]['fname'] +
                                  resultusers[i]['lname'] +
                                  resultusers[i]['cnum'];
                              if (a == b) {
                                receiver = doc.id;
                                name = doc['fname'] + ' ' + doc['lname'];
                              }
                            });
                          });
                          storecontact
                              .collection('Chats')
                              .doc(uid)
                              .collection('Contacts')
                              .doc(receiver)
                              .set({
                            'contactname': resultusers[i]['fname'] +
                                ' ' +
                                resultusers[i]['lname'],
                          });
                          storecontact
                              .collection('Chats')
                              .doc(receiver)
                              .collection('Contacts')
                              .doc(uid)
                              .set({'contactname': name});
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Messages(
                                        sender: uid,
                                        receiver: receiver,
                                        name: resultusers[i]['fname'] +
                                            ' ' +
                                            resultusers[i]['lname'],
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
