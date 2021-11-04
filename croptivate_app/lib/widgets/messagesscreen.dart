import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/createmessage.dart';
import 'package:croptivate_app/widgets/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'messages.dart' as messages;

/*getmessagescount() async {
  // You can now access token from token_manager from any class like this.
  final int MessagesCount = messages.messagescount;
}*/

class Messagescreen extends StatefulWidget {
  const Messagescreen({Key? key}) : super(key: key);

  @override
  _MessagescreenState createState() => _MessagescreenState();
  static const String routeName = '/message';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => Messagescreen());
  }
}

class _MessagescreenState extends State<Messagescreen> {
  final StoreMessages = FirebaseFirestore.instance;
  final Buyers = FirebaseFirestore.instance.collection('userBuyer');

  Future getcontactname() async {
    try {
      Buyers.snapshots().forEach((element) {
        element.docs.forEach((doc) {
          print(doc['fname'] + ' ' + doc['lname'] + ' ' + doc.id);
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    getcontactname();
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
          "Messages",
          style: TextStyle(
            fontFamily: 'Poppins',
            color: cGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ShowContacts(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => createmessage()));
        },
        label: const Text(
          'Create Message',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.w600),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: cGreen,
      ),
    );
  }
}

class ShowContacts extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final User? user = auth.currentUser;
    String chats = user!.uid;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Chats/' + chats + '/Contacts')
            .orderBy('lastTime')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: ScrollPhysics(),
              reverse: true,
              primary: true,
              itemBuilder: (context, i) {
                QueryDocumentSnapshot x = snapshot.data!.docs[i];
                String contactname = x['contactname'];
                Timestamp ltime = x['lastTime'];
                int lhour = x['lastHour'];
                int lminute = x['lastMinute'];
                int lday = x['lastDay'];

                return SizedBox(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: x['messagescount'].toString() != '0'
                            ? cWhite
                            : Colors.green[300]!.withOpacity(0.3)),
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: cGreen),
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('Chats')
                            .doc(chats)
                            .collection('Contacts')
                            .doc(x.id)
                            .set({
                          'contactname': contactname,
                          'lastTime': ltime,
                          'lastHour': lhour,
                          'lastMinute': lminute,
                          'lastDay': lday,
                          'messagescount': 0,
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Messages(
                                    sender: chats,
                                    receiver: x.id,
                                    name: x['contactname'])));
                      },
                      title: Text(
                        x['contactname'],
                        style: cBodyText.copyWith(color: cBlack),
                      ),
                      tileColor: cWhite,
                      trailing: Container(
                        width: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              x['lastHour'].toString() +
                                  ' : ' +
                                  x['lastMinute'].toString(),
                              style: cBodyText.copyWith(
                                  color: cBlack, fontSize: 10),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              x['messagescount'].toString() != '0'
                                  ? x['messagescount'].toString()
                                  : '',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              });
        });
  }
}
