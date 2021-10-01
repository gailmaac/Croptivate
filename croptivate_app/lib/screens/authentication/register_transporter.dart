import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/heading_account.dart';
import 'package:croptivate_app/widgets/subtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RegisterTransporter extends StatefulWidget {

  @override
  _RegisterTransporterState createState() => _RegisterTransporterState();
}

class _RegisterTransporterState extends State<RegisterTransporter> {

  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  TextEditingController cnum = new TextEditingController();

  final AuthService _auth = AuthService(); 
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  var myInitialItem;

  String email = '';
  String password = '';
  String _fname = '';
  String _lname = '';
  String _loc = '';
  String _cnum = '';

  String error = '';

  List<String> myItems = [
    "Truck",
    "Motorcycle",
  ];


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
                    HeadingCreateAccount(acctype: "Welcome, Transporter!"),
                    SubText(),
                    SizedBox(height: 10),
                      
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
                                hint: Text("Choose Vehicle Type", style: inputBodyText),
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
                        ),),
                    //dropdown for seller type
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
                    
                    //password
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
                            onChanged: (val) {
                              setState(() => _loc = val);
                              },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Complete Address",
                              hintStyle: inputBodyText,
                            ),
                            style: cBodyText,
                            keyboardType: TextInputType.text,
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
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ),
                    ), 
                    
                    SizedBox(height:10),
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
                            Map <String, dynamic> transporterCollection = {
                              'myInitialItem' : myInitialItem,
                              'fname' : fname.text,
                              'lname' : lname.text,
                              'loc' : loc.text,
                              'cnum' : cnum.text};
                              dynamic result = await _auth.registerTransporter(email, password, transporterCollection);
                              if (result == null) {
                                setState(() {
                                  error = "Please supply valid Email";
                                  loading = false;
                                });
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

