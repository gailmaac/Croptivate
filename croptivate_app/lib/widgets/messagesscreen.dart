import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/widgets/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green[400],
        title: Center(
          child: Text('Messages'),
        ),
      ),
      body: Container(
        child: ShowContacts(),
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
            .collection('Chats/' + chats + '/Contacts/')
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
                //print(snapshot.data.toString());
                return SizedBox(
                  child: Container(
                    color: Colors.amber,
                    child: ListTile(
                      leading: CircleAvatar(),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Messages()));
                      },
                      title: Text(x['contactname']),
                      tileColor: Colors.white,
                    ),
                  ),
                );
              });
        });
  }
}
