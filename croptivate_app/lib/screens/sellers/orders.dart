import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  final fr;
  final buyer;
  final dateordered;
  const OrdersPage({Key? key, this.buyer, this.dateordered, this.fr})
      : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  String name = '';
  String location = '';
  String dO = '';
  String pM = '';
  String to_ship = '';
  String shipping = '';
  String completed = '';

  @override
  void initState() {
    super.initState();
    getorder();
  }

  getorder() async {
    try {
      await FirebaseFirestore.instance
          .collection('userBuyer')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (widget.buyer == doc.id) {
            setState(() {
              name = doc['first name'] + ' ' + doc['last name'];
            });
          }
        });
      });
      await FirebaseFirestore.instance
          .collection('Orders')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (widget.buyer == doc['Buyer'] &&
              widget.dateordered == doc['Date ordered']) {
            setState(() {
              location = doc['location'];
              dO = doc['Delivery Option'];
              pM = doc['Payment Method'];
              to_ship = doc['To Ship'];
              shipping = doc['Shipping'];
              completed = doc['Completed'];
            });
          }
        });
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
          backgroundColor: cGreen,
        ),
        body: widget.fr == 'Seller'
            ? Column(
                children: [
                  Text(name),
                  Text(location),
                  Text(dO),
                  Text(pM),
                  Text(widget.dateordered),
                  SizedBox(
                      child: to_ship == 'true'
                          ? Text('To Ship')
                          : Text(
                              'Shipping')) /*shipping == 'true'
                              ? Text('Shipping')
                              : completed == 'true'
                                  ? Text('Completed')
                                  : Text('Cancelled'))*/
                ],
              )
            : Column(
                children: [
                  Text(name),
                  Text(location),
                  Text(dO),
                  Text(pM),
                ],
              ));
  }
}
