import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/heading_account.dart';
import 'package:croptivate_app/widgets/subtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class RegisterSeller extends StatefulWidget {

  @override
  _RegisterSellerState createState() => _RegisterSellerState();
}

class _RegisterSellerState extends State<RegisterSeller> {


var myInitialItem;


List<String> myItems = [
  "Farmer",
  "Distributor",
  "Retailer",
];


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: "assets/vegetable4.jpg"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
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
                        child: TextField(
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
                        child: TextField(
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
                        child: TextField(
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
                        child: TextField(
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
                        child: TextField(
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
                        child: TextField(
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
                        child: TextField(
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
                        child: TextField(
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
                  //Sign Up Button
                  Container(
                    height: size.height * 0.07,
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: cGreen),
                    child: TextButton(
                      onPressed: () async {
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
      ], 
    );
  }
}

