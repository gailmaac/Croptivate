import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class Messages extends StatefulWidget {
  final sender;
  final receiver;
  final name;
  const Messages(
      {Key? key, required this.sender, required this.receiver, this.name})
      : super(key: key);

  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  TextEditingController msg = TextEditingController();
  final StoreMessages = FirebaseFirestore.instance;
  final Buyers = FirebaseFirestore.instance.collection('userBuyer');
  final auth = FirebaseAuth.instance;

  Future getcontactname() async {
    try {
      Buyers.snapshots().forEach((element) {
        element.docs.forEach((doc) {
          print(doc.data());
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
              widget.name,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: cGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: cWhite,
              height: double.infinity,
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                reverse: true,
                child: Showmessages(
                  sender: widget.sender,
                  receiver: widget.receiver,
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: cWhite,
                        border: Border(
                            top: BorderSide(color: cGreen, width: 0.2),
                            bottom: BorderSide(color: cGreen, width: 0.2),
                        )
                      ),
                    child: TextField(
                      controller: msg,
                      decoration: InputDecoration(
                        hintText: 'Enter Message...', 
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14, 
                          color: Colors.black45, 
                          fontWeight: FontWeight.w500,
                        )),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  String contact = widget.receiver;
                  String sender = widget.sender;
                  if (msg.text.isNotEmpty) {
                    StoreMessages.collection('Chats/' +
                            sender +
                            '/Contacts/' +
                            contact +
                            '/Messages')
                        .doc()
                        .set({
                      "message": msg.text.trim(),
                      "sender": widget.sender,
                      "time": DateTime.now()
                    });

                    StoreMessages.collection('Chats/' +
                            contact +
                            '/Contacts/' +
                            sender +
                            '/Messages')
                        .doc()
                        .set({
                      "message": msg.text.trim(),
                      "sender": widget.sender,
                      "time": DateTime.now()
                    });
                  }
                  msg.clear();
                },
                icon: Icon(Icons.send),
                color: cGreen,
              )
            ],
          )
        ],
      ),
    );
  }
}

class Showmessages extends StatelessWidget {
  final sender;
  final receiver;
  const Showmessages({Key? key, required this.sender, required this.receiver})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Chats/' + sender + '/Contacts/' + receiver + '/Messages')
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
                  crossAxisAlignment: sender == x['sender']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                          
                        color: sender == x['sender']
                            ? Colors.green[300]!.withOpacity(0.2)
                            : Colors.blue[300]!.withOpacity(0.2),),
                        child: Text(x['message'], 
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: Colors.black
                              ),)),
                  ],
                ),
              );
            });
      },
    );
  }
}
