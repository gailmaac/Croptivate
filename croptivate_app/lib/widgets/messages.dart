import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatefulWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController msg = TextEditingController();
  final StoreMessages = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text('Messages'), backgroundColor: Colors.green[400]),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              height: 599,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                reverse: true,
                child: Showmessages(),
              )),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.green, width: 0.2))),
                  child: TextField(
                    controller: msg,
                    decoration: InputDecoration(hintText: 'Enter Message...'),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  String contact = '5KEUrHxzWqWC9vPsosyykbGqj4c2';
                  String sender = 'WAfFmobOMHgwsOy5x0X4djkAFha2';
                  if (msg.text.isNotEmpty) {
                    StoreMessages.collection('Chats/' +
                            sender +
                            '/Contacts/' +
                            contact +
                            '/Messages')
                        .doc()
                        .set({
                      "message": msg.text.trim(),
                      "sender": "enzo",
                      "time": DateTime.now()
                    });
                  }
                  msg.clear();
                },
                icon: Icon(Icons.send),
                color: Colors.teal,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Showmessages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String contact = '5KEUrHxzWqWC9vPsosyykbGqj4c2';
    String sender = 'WAfFmobOMHgwsOy5x0X4djkAFha2';
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Chats/' + sender + '/Contacts/' + contact + '/Messages')
          .orderBy('time')
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
            primary: true,
            itemBuilder: (context, i) {
              QueryDocumentSnapshot x = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  crossAxisAlignment: 'enzo' == x['sender']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        color: 'enzo' == x['sender']
                            ? Colors.green[300]!.withOpacity(0.2)
                            : Colors.blue[300]!.withOpacity(0.2),
                        child: Text(x['message'])),
                  ],
                ),
              );
            });
      },
    );
  }
}
