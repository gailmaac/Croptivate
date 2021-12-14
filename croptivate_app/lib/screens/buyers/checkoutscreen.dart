import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/blocs/basketdata/basketdata_bloc.dart';
import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/referencescreen.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/ordersummary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({Key? key}) : super(key: key);

  static const String routeName = '/checkout';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => CheckoutScreen());
  }

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

class _CheckoutScreenState extends State<CheckoutScreen> {
  final StoreOrder = FirebaseFirestore.instance;
  var name = '';
  String loc = '';
  String num = '';
  String email = '';
  int selectedDO = 0;
  int selectedPM = 0;
  String DO = '';
  String PM = '';
  String dateOrdered = '';
  String ownerid = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

  getUser() async {
    await FirebaseFirestore.instance
        .collection('userBuyer')
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (_auth.currentUser?.uid == doc.id) {
          setState(() {
            name = doc['first name'] + ' ' + doc['last name'];
            loc = doc['location'];
            num = doc['contact number'].toString();
          });
        }
      });
      setState(() {
        email = _auth.currentUser!.email!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 0,
        title: Text(
          "Checkout",
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
      bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            left: 0,
            right: 0,
            bottom: 10,
            top: 10,
          ),
          height: 65,
          decoration: BoxDecoration(color: cWhite, boxShadow: [
            BoxShadow(
              offset: Offset(1, 10),
              blurRadius: 35,
              color: cGrey.withOpacity(0.40),
            )
          ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<BasketdataBloc, BasketdataState>(
                builder: (context, state) {
                  if (state is BasketdataLoading) {
                    return Center(
                        child: CircularProgressIndicator(color: cGreen));
                  }
                  if (state is BasketdataLoaded) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: cGreen),
                        onPressed: () {
                          context.read<BasketdataBloc>().add(
                              ConfirmBasketdata(basketData: state.basketData));
                          setState(() {
                            dateOrdered = DateTime.now().toString();
                          });

                          if (PM != '' && DO != '') {
                            StoreOrder.collection('Orders').doc().set({
                              "location": loc,
                              "Payment Method": PM,
                              "Delivery Option": DO,
                              "Date ordered": dateOrdered,
                              "Buyer": _auth.currentUser!.uid,
                              "Seller": ownerid,
                              "To Ship": 'true',
                              "Shipping": 'false',
                              "Refunded": 'false',
                              "Completed": 'false',
                            }).whenComplete(() {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ReferenceScreen(
                                            dateordered: dateOrdered,
                                            uid: _auth.currentUser!.uid,
                                          )));
                            });
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                      title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      children: [
                                        Text("Please fill in necessary fields",
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                color: cBrown)),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        SimpleDialogOption(
                                            child: Text("OK",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            }),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  ));
                                });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text("PLACE ORDER NOW",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                        ));
                  } else {
                    return Text("Sorry");
                  }
                },
              )
            ],
          )),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Container(
              decoration: BoxDecoration(
                color: cWhite,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(1, 1),
                      blurRadius: 10,
                      color: cBlack.withOpacity(0.23)),
                ],
              ),
              height: 190,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Shipping and Billing",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                          color: cBrown,
                          fontSize: 19),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.pin_drop_rounded, color: cGreen),
                        SizedBox(width: 10),
                        Text(
                          name,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              color: cBlack,
                              fontSize: 16),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        loc,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        "+63" + num,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15),
                      ),
                    ),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Text(
                        email,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //payment method/options
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 10,
                          color: cBlack.withOpacity(0.23)),
                    ],
                  ),
                  height: 180,
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Payment Method",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w900,
                                      color: cBrown,
                                      fontSize: 19),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Container(
                                  width: 170,
                                  height: 83,
                                  decoration: BoxDecoration(
                                      color: cGrey.withOpacity(0.23),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedPM = 1;
                                            PM = 'Cash On Delivery';
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.payment_rounded,
                                                  size: 20,
                                                  color: selectedPM == 1
                                                      ? cGreen
                                                      : cBrown,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Cash On Delivery",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: selectedPM == 1
                                                        ? cGreen
                                                        : cBrown,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Pay when you receive",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: cBlack),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                //GCASH
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 170,
                                  height: 83,
                                  decoration: BoxDecoration(
                                      color: cGrey.withOpacity(0.23),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedPM = 2;
                                            PM = 'GCash';
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons
                                                      .account_balance_wallet_rounded,
                                                  size: 20,
                                                  color: selectedPM == 2
                                                      ? cGreen
                                                      : cBrown,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "E-Wallet",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: selectedPM == 2
                                                        ? cGreen
                                                        : cBrown,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Pay using Electronic Wallet",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: cBlack),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                //BANK TRANSFER
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 170,
                                  height: 83,
                                  decoration: BoxDecoration(
                                      color: cGrey.withOpacity(0.23),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedPM = 3;
                                            PM = 'Bank Transfer';
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.real_estate_agent_sharp,
                                                  size: 20,
                                                  color: selectedPM == 3
                                                      ? cGreen
                                                      : cBrown,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Bank Transfer",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: selectedPM == 3
                                                        ? cGreen
                                                        : cBrown,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Pay using Bank",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: cBlack),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )))),

          //Delivery method/options
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 10,
                          color: cBlack.withOpacity(0.23)),
                    ],
                  ),
                  height: 180,
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Delivery Options",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w900,
                                      color: cBrown,
                                      fontSize: 19),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                //Grab
                                Container(
                                  width: 170,
                                  height: 92,
                                  decoration: BoxDecoration(
                                      color: cGrey.withOpacity(0.23),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedDO = 1;
                                            DO = 'Grab Express';
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.motorcycle_rounded,
                                                  size: 20,
                                                  color: selectedDO == 1
                                                      ? cGreen
                                                      : cBrown,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Grab Express",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: selectedDO == 1
                                                          ? cGreen
                                                          : cBrown),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Click to view pinned\naddress",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: cBlack),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //Lalamove
                                Container(
                                  width: 170,
                                  height: 92,
                                  decoration: BoxDecoration(
                                      color: cGrey.withOpacity(0.23),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedDO = 2;
                                            DO = 'Lalamove';
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.motorcycle_rounded,
                                                  size: 20,
                                                  color: selectedDO == 2
                                                      ? cGreen
                                                      : cBrown,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Lalamove",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: selectedDO == 2
                                                          ? cGreen
                                                          : cBrown),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Click to view pinned\naddress",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: cBlack),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                // Mr. Speedy
                                Container(
                                  width: 170,
                                  height: 92,
                                  decoration: BoxDecoration(
                                      color: cGrey.withOpacity(0.23),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedDO = 3;
                                            DO = 'Mr. Speedy';
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.motorcycle_rounded,
                                                  size: 20,
                                                  color: selectedDO == 3
                                                      ? cGreen
                                                      : cBrown,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Mr. Speedy",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: selectedDO == 3
                                                          ? cGreen
                                                          : cBrown),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Click to view pinned\naddress",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: cBlack),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                //TokTok
                                Container(
                                  width: 170,
                                  height: 92,
                                  decoration: BoxDecoration(
                                      color: cGrey.withOpacity(0.23),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 10),
                                    child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            selectedDO = 4;
                                            DO = 'Toktok';
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.motorcycle_rounded,
                                                  size: 20,
                                                  color: selectedDO == 4
                                                      ? cGreen
                                                      : cBrown,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "TokTok",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: selectedDO == 4
                                                          ? cGreen
                                                          : cBrown),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Click to view pinned\naddress",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: cBlack),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          )
                        ],
                      )))),

          //Order Summary
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Container(
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(1, 1),
                          blurRadius: 10,
                          color: cBlack.withOpacity(0.23)),
                    ],
                  ),
                  width: double.infinity,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "Order Summary",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w900,
                                      color: cBrown,
                                      fontSize: 19),
                                ),
                              ),
                              Text("Items Ordered",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w900,
                                      color: cBrown,
                                      fontSize: 16)),
                              BlocBuilder<BasketBloc, BasketState>(
                                builder: (context, state) {
                                  if (state is BasketLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                          color: cGreen),
                                    );
                                  }

                                  if (state is BasketLoaded) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.basket
                                            .productQuantity(
                                                state.basket.products)
                                            .keys
                                            .length,
                                        itemBuilder: (context, index) {
                                          ownerid = state.basket
                                              .productQuantity(
                                                  state.basket.products)
                                              .keys
                                              .elementAt(index)
                                              .ownerId;

                                          print(ownerid);

                                          return Container(
                                            color: cWhite,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20, vertical: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                      '${state.basket.productQuantity(state.basket.products).values.elementAt(index)}x',
                                                      style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          color: cBlack,
                                                          fontSize: 16,
                                                          letterSpacing: 3)),
                                                  Text(
                                                      '${state.basket.productQuantity(state.basket.products).keys.elementAt(index).name}',
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: cBlack,
                                                        fontSize: 16,
                                                      )),
                                                  Text(
                                                      '\₱${state.basket.productQuantity(state.basket.products).keys.elementAt(index).price}',
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: cBlack,
                                                        fontSize: 16,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  } else {
                                    return (Text("Sorry"));
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              OrderSummary(),
                            ],
                          ),
                        ],
                      )))),
        ]),
      ),
    );
  }
}
