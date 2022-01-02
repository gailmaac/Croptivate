import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;

/*int _messagescount = 0;
int get messagescount => _messagescount;
bool _tapped = false; // To ensure readonly
bool get tapped => _tapped;

Future<Null> setmessagescount() async {
  // set your _token here
  _messagescount++;
}

Future<Null> settapped() async {
  // set your _token here
  _tapped = true;
}*/

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
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  late File _img;
  bool imageEmpty = true;
  final picker = ImagePicker();

  TextEditingController _msg = TextEditingController();
  final StoreMessages = FirebaseFirestore.instance;
  final storecontact = FirebaseFirestore.instance;
  final Buyers = FirebaseFirestore.instance.collection('userBuyer');
  final auth = FirebaseAuth.instance;
  String LastTime = '';
  String contactname = '';
  String sendername = '';
  bool TextEmpty = true;
  String profilePicRec = '';
  String profilePicSen = '';

  @override
  void initState() {
    super.initState();
    _msg.addListener(_ontypeChanged);
    imgRef = FirebaseFirestore.instance.collection('ImageURLs');
  }

  @override
  void dispose() {
    _msg.removeListener(_ontypeChanged);
    _msg.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //usersloaded = getusers();
  }

  _ontypeChanged() {
    if (_msg.text.isEmpty) {
      setState(() {
        TextEmpty = true;
      });
    } else {
      setState(() {
        TextEmpty = false;
      });
    }
  }

  Future getcontactname() async {
    try {
      await Buyers.snapshots().forEach((element) {
        element.docs.forEach((doc) {
          print(doc.data());
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageEmpty = false;
        _img = File(pickedFile.path);
      });
    }
  }

  Future uploadImage() async {
    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('images/${Path.basename(_img.path)}');
    await ref.putFile(_img).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        StoreMessages.collection('Chats/' +
                widget.sender +
                '/Contacts/' +
                widget.receiver +
                '/Messages')
            .doc()
            .set({
          "message": '',
          "sender": widget.sender,
          "time": DateTime.now(),
          "image": value,
        });

        StoreMessages.collection('Chats/' +
                widget.receiver +
                '/Contacts/' +
                widget.sender +
                '/Messages')
            .doc()
            .set({
          "message": '',
          "sender": widget.sender,
          "time": DateTime.now(),
          "image": value,
        });
      });
    });
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
                imageEmpty == false
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(_img.path),
                                    fit: BoxFit.cover,
                                    width: 90,
                                    height: 90,
                                  )),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  imageEmpty = true;
                                });
                              },
                              child: Icon(Icons.remove_circle,
                                  size: 20, color: cGrey),
                            ),
                          ),
                        ],
                      )
                    : Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: cWhite,
                                border: Border(
                                  top: BorderSide(color: cGreen, width: 0.2),
                                  bottom: BorderSide(color: cGreen, width: 0.2),
                                )),
                            child: TextField(
                              controller: _msg,
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
                TextEmpty == true && imageEmpty == true
                    ? SizedBox(
                        child: Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: TextButton(
                                onPressed: () {
                                  pickImage(ImageSource.camera);
                                },
                                child:
                                    Icon(Icons.camera, size: 20, color: cGrey),
                              ),
                            ),
                            SizedBox(
                              width: 40,
                              child: TextButton(
                                onPressed: () {
                                  pickImage(ImageSource.gallery);
                                },
                                child: Icon(Icons.picture_in_picture,
                                    size: 20, color: cGrey),
                              ),
                            )
                          ],
                        ),
                      )
                    : IconButton(
                        onPressed: () async {
                          String contact = widget.receiver;
                          String sender = widget.sender;
                          int messagescount = 0;
                          if (imageEmpty == false) {
                            uploadImage();
                            setState(() {
                              imageEmpty = true;
                            });
                          }
                          if (_msg.text.isNotEmpty) {
                            StoreMessages.collection('Chats/' +
                                    sender +
                                    '/Contacts/' +
                                    contact +
                                    '/Messages')
                                .doc()
                                .set({
                              "message": _msg.text.trim(),
                              "sender": widget.sender,
                              "time": DateTime.now(),
                              "image": '',
                            });

                            StoreMessages.collection('Chats/' +
                                    contact +
                                    '/Contacts/' +
                                    sender +
                                    '/Messages')
                                .doc()
                                .set({
                              "message": _msg.text.trim(),
                              "sender": widget.sender,
                              "time": DateTime.now(),
                              "image": '',
                            });
                            _msg.clear();

                            await FirebaseFirestore.instance
                                .collection('userSeller')
                                .get()
                                .then((querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                if (doc.id == widget.receiver) {
                                  contactname = doc['first name'] +
                                      ' ' +
                                      doc['last name'];
                                  profilePicRec = doc['Profile Picture'];
                                }
                                if (doc.id == widget.sender) {
                                  sendername = doc['first name'] +
                                      ' ' +
                                      doc['last name'];
                                  profilePicSen = doc['Profile Picture'];
                                }
                              });
                            });

                            await FirebaseFirestore.instance
                                .collection('userBuyer')
                                .get()
                                .then((querySnapshot) {
                              querySnapshot.docs.forEach((doc) {
                                if (doc.id == widget.receiver) {
                                  contactname = doc['first name'] +
                                      ' ' +
                                      doc['last name'];
                                  profilePicRec = doc['Profile Picture'];
                                }
                                if (doc.id == widget.sender) {
                                  sendername = doc['first name'] +
                                      ' ' +
                                      doc['last name'];
                                  profilePicSen = doc['Profile Picture'];
                                }
                              });
                            });
                            await storecontact
                                .collection('Chats')
                                .doc(widget.sender)
                                .collection('Contacts')
                                .doc(widget.receiver)
                                .set({
                              'contactname': contactname,
                              'lastTime': DateTime.now(),
                              'lastHour': DateTime.now().hour,
                              'lastMinute': DateTime.now().minute,
                              'lastDay': DateTime.now().day,
                              'messagescount': messagescount,
                              'Profile Picture': profilePicRec,
                            });

                            await FirebaseFirestore.instance
                                .collection('Chats')
                                .doc(widget.receiver)
                                .collection('Contacts')
                                .doc(widget.sender)
                                .get()
                                .then((doc) {
                              if (doc.id == widget.sender) {
                                messagescount = doc['messagescount'];
                                print(messagescount);
                              }
                            });

                            await storecontact
                                .collection('Chats')
                                .doc(widget.receiver)
                                .collection('Contacts')
                                .doc(widget.sender)
                                .set({
                              'contactname': sendername,
                              'lastTime': DateTime.now(),
                              'lastHour': DateTime.now().hour,
                              'lastMinute': DateTime.now().minute,
                              'lastDay': DateTime.now().day,
                              'messagescount': messagescount + 1,
                              'Profile Picture': profilePicSen,
                            });
                          }
                        },
                        icon: Icon(Icons.send),
                        color: cGreen,
                      )
              ])
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
                  horizontalTitleGap: 0,
                  leading: sender != x['sender']
                      ? CircleAvatar(
                          backgroundColor: cGreen,
                          radius: 15,
                        )
                      : CircleAvatar(
                          backgroundColor: cWhite,
                          radius: 15,
                        ),
                  title: Column(
                    crossAxisAlignment: sender == x['sender']
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: sender == x['sender']
                              ? Colors.green[300]!.withOpacity(0.2)
                              : Colors.blue[300]!.withOpacity(0.2),
                        ),
                        child: x['image'] == ''
                            ? Text(
                                x['message'],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                              )
                            : Container(
                                height: 200,
                                width: 150,
                                child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        x['image'],
                                        fit: BoxFit.cover,
                                        width: 90,
                                        height: 90,
                                      ),
                                    )),
                              ),
                      ),
                    ],
                  ));
            });
      },
    );
  }
}
