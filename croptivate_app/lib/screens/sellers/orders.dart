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
  String referenceID = '';
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
              referenceID = doc.id;
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
        backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 1,
        title: Text(
          "Order Details",
          style: TextStyle(
              color: cGreen,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        centerTitle: true,
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
      ),
        body: widget.fr == 'Seller'
            ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: cWhite,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
            
                            Row(
                              children: [
                                
                                Icon(Icons.location_on_outlined,
                                color: cGreen,
                                size: 20,),
                                SizedBox(width: 20),
                                Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: cGreen,
                                    fontWeight: FontWeight.w800
                                  ),
                                )
                              ],
                            ),
                            //delivery info -- BUYER'S NUMBER
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: cBlack
                                    ),
                                  ),
                                  Text(
                                    "+63 number",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: cBlack
                                    ),
                                  ),
                                  Text(
                                    location,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: cBlack
                                    ),
                                  ),
                                ],
                              ),
                            ),
            
                            Divider(height: 16),
            
                            Row(
                              children: [
                                Icon(Icons.motorcycle,
                                color: cGreen,
                                size: 20,),
                                SizedBox(width: 20),
                                Text(
                                  "Delivery Method",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: cGreen,
                                    fontWeight: FontWeight.w800
                                  ),
                                )
                              ],
                            ),
            
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chosen Third-Party Courier",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: cBlack
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    dO,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: cBlack,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
            
                    //payment info -- TOTAL AMOUNT
                    Container(
                      color: cWhite,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                
                                Icon(Icons.payments_outlined,
                                color: cGreen,
                                size: 20,),
                                SizedBox(width: 20),
                                Text(
                                  "Payment Information",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: cGreen,
                                    fontWeight: FontWeight.w800
                                  ),
                                )
                              ],
                            ),
            
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Payment Method",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: cBlack
                                    ),
                                  ),
                                  SizedBox(height: 5,),
                                  Text(
                                    pM,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: cBlack,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Order Total",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: cBlack
                                        ),
                                      ),
            
                                      Text(
                                        "P AMOUNT",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: cGreen,
                                          fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ],
                                  ),
                                  
                                ],
                              ),
                            ),
                          ]
                        )
                      )
                    ),
                    SizedBox(height: 20),
            
                    Container(
                      color: cWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: cGreen,
                                  radius: 15,
                                ),
                                SizedBox(width: 20,),
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: cBlack
                                  ),
                                )
                              ],
                            ),
                          ),
            
                          Divider(),
                          //List of Items Ordered
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Text(
                                  "Items Ordered",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                    color: cGreen,
                                    fontWeight: FontWeight.w800
                                  ),
                                ),
                              ),
                            
                            ],
                          ),
            
                          Divider(),
            
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        color: cBlack
                                      ),
                                    ),
                                    Text(
                                      referenceID,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                        color: cBlack,
                                        fontWeight: FontWeight.w800
                                      ),
                                    )
                                  ],
                                ),
                              ),
            
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Time",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack
                                      ),
                                    ),
                                    Text(
                                      widget.dateordered,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        child: to_ship == 'true'
                            ? Container(
                              color: cWhite,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Status",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: cBlack,
                                          fontWeight: FontWeight.w800
                                      ),
                                    ),
                                    Text(
                                      'To Ship',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                          fontSize: 20,
                                          color: cGreen,
                                          fontWeight: FontWeight.w800
                                      )
                                    ),
                                  ],
                                ),
                              ),
                            )
                            : Text(
                                'Shipping')) /*shipping == 'true'
                                ? Text('Shipping')
                                : completed == 'true'
                                    ? Text('Completed')
                                    : Text('Cancelled'))*/
                  ],
                ),
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
