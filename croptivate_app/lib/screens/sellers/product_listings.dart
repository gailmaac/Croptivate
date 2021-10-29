import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
  static const String routeName = '/prodlistings';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => ProductPage());
  }
}

class _ProductPageState extends State<ProductPage> {
  // FirebaseAuth _auth = FirebaseAuth.instance;

  // late QuerySnapshot products;

  // getData() {
  //   var userId = FirebaseAuth.instance.currentUser!.uid;
  //   FirebaseFirestore.instance.collection('userSeller').doc(userId).get().then((results){
  //     setState(() {
  //       getName = results.data()!["fname"];
  //     });
  //   });
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   userId = FirebaseAuth.instance.currentUser!.uid;
  //   userEmail = FirebaseAuth.instance.currentUser!.uid;

  //   FirebaseFirestore.instance.collection('sellerPosts').where('status', isEqualTo: "active")
  //   .orderBy("time", descending: true).get().then((results){

  //     setState(() {
  //       products = results;
  //     });
  //   });

  //   getData();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Your Listings")),
          backgroundColor: cGreen,
        ),
        body: Stack(children: [
          Container(
            //color: Colors.red,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 60),
                  child: Text('Product Name', style: TextStyle(fontSize: 10)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 60),
                  child: Text('Price', style: TextStyle(fontSize: 10)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Text('Stock', style: TextStyle(fontSize: 10)),
                ),
                Container(
                  padding: EdgeInsets.only(left: 35),
                  child: Text('Options', style: TextStyle(fontSize: 10)),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: 40),
              child: ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.yellow,
                      ),
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      horizontalTitleGap: 8,
                      tileColor: Colors.blue,
                      title: Text('Camille ', style: TextStyle(fontSize: 10)),
                      subtitle: Text('Javier', style: TextStyle(fontSize: 10)),
                      leading: Container(
                        height: 40,
                        width: 40,
                        color: Colors.pink,
                        child: FittedBox(
                          clipBehavior: Clip.hardEdge,
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                          child: Image.asset(
                            'assets/vegetable6.jpg',
                          ),
                        ),
                      ),
                      trailing: SizedBox(
                        child: Container(
                            padding: EdgeInsets.only(top: 15),
                            width: 160,
                            //color: Colors.red,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  //color: Colors.amber,
                                  width: 55,
                                  child: Text('100.00',
                                      style: TextStyle(fontSize: 10)),
                                ),
                                Container(
                                  //color: Colors.blueGrey,
                                  width: 55,
                                  child: Text('12',
                                      style: TextStyle(fontSize: 10)),
                                ),
                                SizedBox(
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          child: Container(
                                            height: 20,
                                            //color: Colors.blue,
                                            child: TextButton(
                                              child: Text(
                                                'Edit',
                                              ),
                                              style: TextButton.styleFrom(
                                                  primary: Colors.white,
                                                  backgroundColor: Colors.green,
                                                  minimumSize: Size(0, 0),
                                                  padding: EdgeInsets.only(
                                                      top: 3,
                                                      bottom: 3,
                                                      left: 15,
                                                      right: 15),
                                                  textStyle: TextStyle(
                                                      fontSize: 10,
                                                      fontStyle:
                                                          FontStyle.italic)),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          child: Container(
                                            //color: Colors.yellow,
                                            child: Text('more',
                                                style: TextStyle(
                                                    color: Colors.green,
                                                    fontSize: 10)),
                                          ),
                                        )
                                      ]),
                                ),
                              ],
                            )),
                      ),
                      //)
                    );
                  })),
        ]));
  }
}
