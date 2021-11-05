import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/ordersummary.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({ Key? key }) : super(key: key);

  static const String routeName = '/checkout';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => CheckoutScreen());
  }

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;
class _CheckoutScreenState extends State<CheckoutScreen> {

    var name = '';
    String loc = '';
    String num = '';

getUser() async {
    
    await FirebaseFirestore.instance
    .collection('userBuyer')
    .get()
    .then((querySnapshot){
      querySnapshot.docs.forEach((doc) { 
        if (_auth.currentUser?.uid == doc.id) {
          name = doc['fname'] + ' ' + doc['lname'];
          loc = doc['loc'];
          num = doc['cnum'];
          print(name);
          print(loc);
          print(num);
        } 

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
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
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: cGreen),
                  onPressed: () {
                    Navigator.pushNamed(context, '/reference');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                    ),
                    child: Text("PLACE ORDER NOW",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                      )
                    ),
                  )
                )
              ],
            )),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        color: cBlack.withOpacity(0.23)
                    ),
                  ],
                ),
                height: 230,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Shipping and Billing",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w900,
                          color: cBrown,
                          fontSize: 19
                        ),
                      ),
                      SizedBox(height:10),
                      Row(
                        children: [
                          Icon(Icons.pin_drop_rounded, color: cGreen),
                          SizedBox(width: 10),
                          Text(name,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                              color: cBlack,
                              fontSize: 16
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text("2022 General Malvar St. South Cembo,",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text("Makati City",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text("1214",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text("09457944280",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 35),
                        child: Text("gailmac@gmail.com",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            color: cBlack,
                            fontSize: 15
                          ),
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
                        color: cBlack.withOpacity(0.23)
                    ),
                  ],
                ),
                height: 180,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Payment Method",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w900,
                                color: cBrown,
                                fontSize: 19
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 170,
                              height: 83,
                              decoration: BoxDecoration(
                                color: cGrey.withOpacity(0.23),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (context){
                                        return SimpleDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text("Cash On Delivery Payment Method",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBrown)
                                                ),
                                                SizedBox(height: 10,),
                                                Text("By using Cash On Delivery Method, please send me a message and let us discuss about the delivery courier that offers Cash On Delivery service.\n\nDisclaimer: There will be an additional fee for purchase service.",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)
                                                ),
                                                SizedBox(height: 10,),
                                                SimpleDialogOption(
                                                  child: Text("Got It!",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)
                                                ),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          ) 
                                        );
                                      });
                                  }, 
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.payment_rounded, size: 20, color: cBrown,),
                                          SizedBox(width: 10,),
                                          Text("Cash On Delivery",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: cBrown
                                            ),
                                          ), 
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(children: [
                                          Text("Pay when you receive",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: cBlack
                                            ),
                                          )
                                        ],),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                            //GCASH
                            SizedBox(width: 10,),
                            Container(
                              width: 170,
                              height: 83,
                              decoration: BoxDecoration(
                                color: cGrey.withOpacity(0.23),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (context){
                                        return SimpleDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text("E-Wallet Payment Method",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBrown)
                                                ),
                                                SizedBox(height: 10,),
                                                Text("By using E-Wallet Payment Method, Pay Manually through GCash:\n\nGCash\n091718xxxx\nCamille Abi Enzo",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)
                                                ),
                                                SizedBox(height: 10,),
                                                SimpleDialogOption(
                                                  child: Text("Got It!",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)
                                                ),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          ) 
                                        );
                                      });
                                  }, 
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.account_balance_wallet_rounded, size: 20, color: cBrown,),
                                          SizedBox(width: 10,),
                                          Text("E-Wallet",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: cBrown
                                            ),
                                          ), 
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: Row(children: [
                                          Text("Pay using Electronic Wallet",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: cBlack
                                            ),
                                          )
                                        ],),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                            //BANK TRANSFER
                            SizedBox(width: 10,),
                            Container(
                              width: 170,
                              height: 83,
                              decoration: BoxDecoration(
                                color: cGrey.withOpacity(0.23),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (context){
                                        return SimpleDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text("Bank Transfer",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBrown)
                                                ),
                                                SizedBox(height: 10,),
                                                Text("By using Bank Transfer Payment Method, Pay Manually through UnionBank:\n\nUnionBank\n1096xxxx\nCamille Abi Enzo",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)
                                                ),
                                                SizedBox(height: 10,),
                                                SimpleDialogOption(
                                                  child: Text("Got It!",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)
                                                ),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          ) 
                                        );
                                      });
                                  }, 
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.real_estate_agent_sharp, size: 20, color: cBrown,),
                                          SizedBox(width: 10,),
                                          Text("Bank Transfer",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: cBrown
                                            ),
                                          ), 
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                        child: Row(children: [
                                          Text("Pay using Bank",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: cBlack
                                            ),
                                          )
                                        ],),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                )
              )
            ),
      
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
                        color: cBlack.withOpacity(0.23)
                    ),
                  ],
                ),
                height: 180,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Delivery Options",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w900,
                                color: cBrown,
                                fontSize: 19
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height:10),
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
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (context){
                                        return SimpleDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text("GRAB EXPRESS",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBrown)
                                                ),
                                                SizedBox(height: 10,),
                                                Text("Kindly pin the address below if you wish to arrange your own shipment. After doing so, please message me. \n\nName: Camille Abi Enzo\nLocation: 7124 General Ricarte St. South Cembo, Makati City\nContact Number: 09171234525",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)
                                                ),
                                                SizedBox(height: 10,),
                                                SimpleDialogOption(
                                                  child: Text("Got It!",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)
                                                ),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          ) 
                                        );
                                      });
                                  }, 
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.motorcycle_rounded, size: 20, color: cBrown,),
                                          SizedBox(width: 10,),
                                          Text("Grab Express",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: cBrown
                                            ),
                                          ), 
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Row(children: [
                                          Text("Click to view pinned\naddress",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: cBlack
                                            ),
                                          )
                                        ],),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            //Lalamove
                            Container(
                              width: 170,
                              height: 92,
                              decoration: BoxDecoration(
                                color: cGrey.withOpacity(0.23),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (context){
                                        return SimpleDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text("LALAMOVE",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBrown)
                                                ),
                                                SizedBox(height: 10,),
                                                Text("Kindly pin the address below if you wish to arrange your own shipment. After doing so, please message me. \n\nName: Camille Abi Enzo\nLocation: 601 JP Rizal St. Malanday, Marikina City\nContact Number: 09171234525",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)
                                                ),
                                                SizedBox(height: 10,),
                                                SimpleDialogOption(
                                                  child: Text("Got It!",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)
                                                ),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          ) 
                                        );
                                      });
                                  }, 
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.motorcycle_rounded, size: 20, color: cBrown,),
                                          SizedBox(width: 10,),
                                          Text("Lalamove",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: cBrown
                                            ),
                                          ), 
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Row(children: [
                                          Text("Click to view pinned\naddress",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: cBlack
                                            ),
                                          )
                                        ],),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            // Mr. Speedy
                            Container(
                              width: 170,
                              height: 92,
                              decoration: BoxDecoration(
                                color: cGrey.withOpacity(0.23),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (context){
                                        return SimpleDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text("MR. SPEEDY",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBrown)
                                                ),
                                                SizedBox(height: 10,),
                                                Text("Kindly pin the address below if you wish to arrange your own shipment. After doing so, please message me. \n\nName: Camille Abi Enzo\nLocation: Blk 2 Lot 13 Intramuros St. Metropolis 1 Vill, Sta. Lucia, Pasig City\nContact Number: 09171234525",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)
                                                ),
                                                SizedBox(height: 10,),
                                                SimpleDialogOption(
                                                  child: Text("Got It!",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)
                                                ),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          ) 
                                        );
                                      });
                                  }, 
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.motorcycle_rounded, size: 20, color: cBrown,),
                                          SizedBox(width: 10,),
                                          Text("Mr. Speedy",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: cBrown
                                            ),
                                          ), 
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Row(children: [
                                          Text("Click to view pinned\naddress",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: cBlack
                                            ),
                                          )
                                        ],),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            //TokTok
                            Container(
                              width: 170,
                              height: 92,
                              decoration: BoxDecoration(
                                color: cGrey.withOpacity(0.23),
                                borderRadius: BorderRadius.circular(6)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
                                child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context, builder: (context){
                                        return SimpleDialog(
                                          title: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                            child: Column(
                                              children: [
                                                Text("TOKTOK DELIVERY",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBrown)
                                                ),
                                                SizedBox(height: 10,),
                                                Text("Kindly pin the address below if you wish to arrange your own shipment. After doing so, please message me.\n\nName: Camille Abi Enzo\nLocation: 2022 General Malvar St. South Cemboo, Makati City\nContact Number: 09171234525",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)
                                                ),
                                                SizedBox(height: 10,),
                                                SimpleDialogOption(
                                                  child: Text("Got It!",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)
                                                ),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                SizedBox(height: 10)
                                              ],
                                            ),
                                          ) 
                                        );
                                      });
                                  }, 
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.motorcycle_rounded, size: 20, color: cBrown,),
                                          SizedBox(width: 10,),
                                          Text("TokTok",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w700,
                                              color: cBrown
                                            ),
                                          ), 
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 12),
                                        child: Row(children: [
                                          Text("Click to view pinned\naddress",
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w500,
                                              color: cBlack
                                            ),
                                          )
                                        ],),
                                      )
                                    ],
                                  )
                                ),
                              ),
                            ),
                            SizedBox(width: 10,),
                          ],
                        ),
                      )
                    ],
                  )
                )
              )
            ),

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
                        color: cBlack.withOpacity(0.23)
                    ),
                  ],
                ),
                height: 205,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text("Order Summary",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w900,
                                color: cBrown,
                                fontSize: 19
                              ),
                            ),
                          ),
                          OrderSummary(),
                        ],
                      ),
                      SizedBox(height:10), 
                    ],
                    
                  )
                )
              )
            ),
          ]
        ),
      ),
    );
  }
}