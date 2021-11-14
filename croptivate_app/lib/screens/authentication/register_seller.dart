import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/sellers/home_seller.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/services/database.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/heading_account.dart';
import 'package:croptivate_app/widgets/subtextemailpass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class RegisterSeller extends StatefulWidget {

  @override
  _RegisterSellerState createState() => _RegisterSellerState();
  static const String routeName = '/regseller';
  static Route route() {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => RegisterSeller());
  }
}

class _RegisterSellerState extends State<RegisterSeller> {

  
  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  // TextEditingController shopname = new TextEditingController();
  // TextEditingController shopdesc = new TextEditingController();
  TextEditingController cnum = new TextEditingController();

  final AuthService _auth = AuthService(); 
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  
  var myInitialItem;

  //textfieldform state
  List<String> myItems = [
    "Farmer",
    "Reseller",
  ];

//form values
  String email = '';
  String password = '';
  String _fname = '';
  String _lname = '';
  String _loc = '';
  // String _shopname = '';
  // String _shopdesc = '';
  String _cnum = '';

  String error = '';

  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Stack(
        children: [
          BackgroundImage(image: "assets/vegetable4.jpg"),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: [
                      AppBar(backgroundColor: Colors.transparent,
                        elevation: 0,
                        leading: IconButton(
                        onPressed: () {
                        Navigator.pop(context);
                      },
                          icon: Icon(
                          Icons.arrow_back_ios,
                          color: cWhite,
                          ),
                        ),),
                      HeadingCreateAccount(acctype: "Welcome, Seller!"),
                      SubTextEmPass(),
                      SizedBox(height: 50),

                      
                      //email address
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.9,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[500]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: TextFormField(
                              validator: (val) => val!.isEmpty ? 'Enter a valid Email Address' : null, 
                              onChanged: (val) {
                                setState(() => email = val);
                                },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email Address",
                                hintStyle: inputBodyText,
                              ),
                              style: cBodyText,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ),
                      ),
                      
                       //Password 
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          height: size.height * 0.06,
                          width: size.width * 0.9,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: Colors.grey[500]!.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: TextFormField(
                              validator: (val) => val!.length < 8 ? 'Password must contain 8 or more characters.' : null, 
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: inputBodyText,
                              ),
                              obscureText: true,
                              style: cBodyText,
                              keyboardType: TextInputType.visiblePassword,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ),
                      ), 
                      
                      SizedBox(height:10),
                      //Sign Up Button
                      Container(
                        height: size.height * 0.07,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: cGreen),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()){
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth.registerSeller(email, password);
                              
                              if (result == null) {
                                setState(() {
                                  error = "Please supply valid Email";
                                  loading = false;
                                });
                              }
                              else {
                                Navigator.pushNamed(context, '/setupseller');
                              }
                            }
                            
                          },
                          child: Text(
                            "Set Up Profile",
                            style: cBodyText.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height:20),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14)
                      ),
                  ],   
                  ),
                ),
              ),
            ),
          ),
        ], 
    );
  }
}

