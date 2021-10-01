import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/services/database.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/heading_account.dart';
import 'package:croptivate_app/widgets/subtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


class RegisterSeller extends StatefulWidget {

  @override
  _RegisterSellerState createState() => _RegisterSellerState();
}

class _RegisterSellerState extends State<RegisterSeller> {

  // TextEditingController myItems = new TextEditingController();
  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  TextEditingController shopname = new TextEditingController();
  TextEditingController shopdesc = new TextEditingController();
  TextEditingController cnum = new TextEditingController();

  final AuthService _auth = AuthService(); 
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  
  var myInitialItem;

  //textfieldform state
  List<String> myItems = [
    "Farmer",
    "Distributor",
    "Retailer",
  ];

//form values
  String email = '';
  String password = '';
  String _fname = '';
  String _lname = '';
  String _loc = '';
  String _shopname = '';
  String _shopdesc = '';
  String _cnum = '';

  String error = '';


  @override
  Widget build(BuildContext context) {

    // final userSeller = Provider.of<QuerySnapshot>(context);
    // for (var doc in userSeller.docs) {
    //   print(doc.data);
    // }
    
// StreamProvider<QuerySnapshot?>.value(
//       value: DatabaseService(uid: '').userSeller,
//       initialData: null,
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
                      SubText(),
                      SizedBox(height: 10),
                        
                      //dropdown for seller type
                      Container(
                        child: Center(
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.9,
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[500]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                                ),
                              child: DropdownButton(
                                hint: Text("Choose Seller Type", style: inputBodyText),
                                dropdownColor: Colors.grey[500]!.withOpacity(0.5),
                                icon: Icon(Icons.arrow_drop_down_circle_outlined, color: cWhite, size: 23),
                                style: inputBodyText,
                                onChanged: (value) {
                                  setState(() {
                                    myInitialItem = value;
                                  });
                                },
                                value: myInitialItem,
                                items: myItems.map((items) {
                                  return DropdownMenuItem(value: items, child: Text(items));
                                }).toList()),
                            ),
                          ) 
                        ),
                      ),
                      
                      SizedBox(height:5),
                      
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
                    
                      //First Name
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
                              controller: fname,
                              validator: (val) => val!.isEmpty ? 'Please enter your first name' : null, 
                              onChanged: (val) {
                                  setState(() => _fname = val);
                                },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "First Name",
                                hintStyle: inputBodyText,
                              ),
                              style: cBodyText,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ),
                      ), 
                      
                      //Last Name
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
                              controller: lname,
                              validator: (val) => val!.isEmpty ? 'Please enter your last name' : null, 
                              onChanged: (val) {
                                setState(() => _lname = val);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Last Name",
                                hintStyle: inputBodyText,
                              ),
                              style: cBodyText,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ),
                      ), 
              
                      //Location
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
                              controller: loc,
                              validator: (val) => val!.isEmpty ? 'Please enter your address' : null, 
                               onChanged: (val) {
                                  setState(() => _loc = val);
                                },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Where are you located?",
                                hintStyle: inputBodyText,
                              ),
                              style: cBodyText,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ),
                      ), 
                      
                      //Shop name
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
                              controller: shopname,
                              validator: (val) => val!.isEmpty ? 'Input your shop name' : null, 
                               onChanged: (val) {
                                  setState(() => _shopname = val);
                                },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Name of your Shop",
                                hintStyle: inputBodyText,
                              ),
                              style: cBodyText,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ),
                      ), 
                      
                      // Shop Description
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
                              controller: shopdesc,
                              onChanged: (val) {
                                  setState(() => _shopdesc = val);
                                },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Shop Description",
                                hintStyle: inputBodyText,
                              ),
                              style: cBodyText,
                              keyboardType: TextInputType.multiline,
                              textInputAction: TextInputAction.next,
                            ),
                          )
                        ),
                      ), 
                    
                      //Contact number
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
                              controller: cnum,
                              validator: (val) => val!.length < 11 ? 'Contact number must have 11 characters.' : null, 
                              onChanged: (val) {
                                setState(() => _cnum = val);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Contact Number",
                                hintStyle: inputBodyText,
                              ),
                              style: cBodyText,
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
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
                              Map <String, dynamic> sellerCollection = {
                              'myInitialItem' : myInitialItem,
                              'fname' : fname.text,
                              'lname' : lname.text,
                              'loc' : loc.text,
                              'shopname' : shopname.text,
                              'shopdesc' : shopdesc.text,
                              'cnum' : cnum.text};
                              FirebaseFirestore.instance.collection('userSeller').add(sellerCollection);
                              
                              if (result == null) {
                                setState(() {
                                  error = "Please supply valid Email";
                                  loading = false;
                                } );
                              }
                            }
                          },
                          child: Text(
                            "Sign Up",
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

