import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  final fr;
  final buyer;
  final seller;
  final dateordered;
  final orderid;
  const OrdersPage(
      {Key? key,
      this.buyer,
      this.dateordered,
      this.seller,
      this.fr,
      required this.orderid})
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
  String cancelled = '';
  String contactnumber = '';
  String profilepic = '';
  bool loading = true;
  String total = '';
  List Itemprice = [];
  List Itemvalues = [];
  List Itemsordered = [];

  @override
  void initState() {
    super.initState();
    getorder();
  }

  getorder() async {
    if (widget.fr == 'Seller') {
      try {
        await FirebaseFirestore.instance
            .collection('userBuyer')
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (widget.buyer == doc.id) {
              setState(() {
                profilepic = doc['Profile Picture'];
                name = doc['first name'] + ' ' + doc['last name'];
                contactnumber = doc['contact number'].toString();
              });
            }
          });
        }).whenComplete(() {
          setState(() {
            loading = false;
          });
        });
        await FirebaseFirestore.instance
            .collection('Orders')
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (doc.id == widget.orderid) {
              setState(() {
                referenceID = doc.id;
                location = doc['location'];
                dO = doc['Delivery Option'];
                pM = doc['Payment Method'];
                to_ship = doc['To Ship'];
                shipping = doc['Shipping'];
                completed = doc['Completed'];
                cancelled = doc['Refunded'];
                Itemprice = doc['Item price'];
                Itemvalues = doc['Item values'];
                Itemsordered = doc['Items Ordered'];
                total = doc['total'].toString();
              });
            }
          });
        });
      } catch (e) {
        print(e.toString());
      }
    } else {
      try {
        await FirebaseFirestore.instance
            .collection('userSeller')
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (widget.seller == doc.id) {
              setState(() {
                profilepic = doc['Profile Picture'];
                name = doc['first name'] + ' ' + doc['last name'];
                contactnumber = doc['contact number'].toString();
                location = doc['location'];
              });
            }
          });
        }).whenComplete(() {
          setState(() {
            loading = false;
          });
        });
        await FirebaseFirestore.instance
            .collection('Orders')
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (doc.id == widget.orderid) {
              setState(() {
                referenceID = doc.id;
                dO = doc['Delivery Option'];
                pM = doc['Payment Method'];
                to_ship = doc['To Ship'];
                shipping = doc['Shipping'];
                completed = doc['Completed'];
                cancelled = doc['Refunded'];
                Itemprice = doc['Item price'];
                Itemvalues = doc['Item values'];
                Itemsordered = doc['Items Ordered'];
                total = doc['total'].toString();
              });
            }
          });
        });
      } catch (e) {
        print(e.toString());
      }
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: cGreen,
                                  size: 20,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Delivery Address",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            //delivery info -- BUYER'S NUMBER
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack),
                                  ),
                                  Text(
                                    "+63" + contactnumber,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack),
                                  ),
                                  Text(
                                    location,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack),
                                  ),
                                ],
                              ),
                            ),

                            Divider(height: 16),

                            Row(
                              children: [
                                Icon(
                                  Icons.motorcycle,
                                  color: cGreen,
                                  size: 20,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Delivery Method",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chosen Third-Party Courier",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: cBlack),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    dO,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack,
                                        fontWeight: FontWeight.w800),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.payments_outlined,
                                        color: cGreen,
                                        size: 20,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        "Payment Information",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: cGreen,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payment Method",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: cBlack),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          pM,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: cBlack,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Order Total",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  color: cBlack),
                                            ),
                                            Text(
                                              'P ' + total,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  color: cGreen,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]))),
                    SizedBox(height: 20),

                    Container(
                      color: cWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: cGreen,
                                  radius: 15,
                                  child: loading == true
                                      ? Image.network(profilepic)
                                      : Image.asset(
                                          "assets/addpic.png",
                                        ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: cBlack),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  "Items Ordered",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: Itemsordered.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading:
                                            Text(Itemvalues[index].toString()),
                                        title: Text(Itemsordered[index]),
                                        trailing:
                                            Text(Itemprice[index].toString()),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),

                          Divider(),

                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: cBlack),
                                    ),
                                    Text(
                                      referenceID,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: cBlack,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Time",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: cBlack),
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
                        child: Container(
                      color: cWhite,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Status",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: cBlack,
                                  fontWeight: FontWeight.w800),
                            ),
                            if (to_ship == 'true') ...[
                              Text('To Ship',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ] else if (shipping == 'true') ...[
                              Text('Shipping',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ] else if (completed == 'true') ...[
                              Text('Completed',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ] else if (cancelled == 'true') ...[
                              Text('Cancelled',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ]
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: cWhite,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  color: cGreen,
                                  size: 20,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Seller's Address",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),
                            //delivery info -- BUYER'S NUMBER
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack),
                                  ),
                                  Text(
                                    "+63" + contactnumber,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack),
                                  ),
                                  Text(
                                    location,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack),
                                  ),
                                ],
                              ),
                            ),

                            Divider(height: 16),

                            Row(
                              children: [
                                Icon(
                                  Icons.motorcycle,
                                  color: cGreen,
                                  size: 20,
                                ),
                                SizedBox(width: 20),
                                Text(
                                  "Delivery Method",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800),
                                )
                              ],
                            ),

                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Chosen Third-Party Courier",
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        color: cBlack),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    dO,
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        color: cBlack,
                                        fontWeight: FontWeight.w800),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.payments_outlined,
                                        color: cGreen,
                                        size: 20,
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        "Payment Information",
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 18,
                                            color: cGreen,
                                            fontWeight: FontWeight.w800),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Payment Method",
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 14,
                                              color: cBlack),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          pM,
                                          style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 16,
                                              color: cBlack,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Order Total",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 16,
                                                  color: cBlack),
                                            ),
                                            Text(
                                              'P ' + total,
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 18,
                                                  color: cGreen,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ]))),
                    SizedBox(height: 20),

                    Container(
                      color: cWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: cGreen,
                                  radius: 15,
                                  child: loading == true
                                      ? Image.network(profilepic)
                                      : Image.asset(
                                          "assets/addpic.png",
                                        ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      color: cBlack),
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Text(
                                  "Items Ordered",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: Itemsordered.length,
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        leading:
                                            Text(Itemvalues[index].toString()),
                                        title: Text(Itemsordered[index]),
                                        trailing:
                                            Text(Itemprice[index].toString()),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),

                          Divider(),

                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: cBlack),
                                    ),
                                    Text(
                                      referenceID,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 18,
                                          color: cBlack,
                                          fontWeight: FontWeight.w800),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Time",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 16,
                                          color: cBlack),
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
                        child: Container(
                      color: cWhite,
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order Status",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  color: cBlack,
                                  fontWeight: FontWeight.w800),
                            ),
                            if (to_ship == 'true') ...[
                              Text('To Ship',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ] else if (shipping == 'true') ...[
                              Text('Shipping',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ] else if (completed == 'true') ...[
                              Text('Completed',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ] else if (cancelled == 'true') ...[
                              Text('Cancelled',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                      color: cGreen,
                                      fontWeight: FontWeight.w800))
                            ]
                          ],
                        ),
                      ),
                    ))
                  ],
                ),
              ));
  }
}
