import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/heading_account.dart';
import 'package:croptivate_app/widgets/subtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterBuyer extends StatefulWidget {
  const RegisterBuyer({ Key? key }) : super(key: key);

  @override
  _RegisterBuyerState createState() => _RegisterBuyerState();
}

class _RegisterBuyerState extends State<RegisterBuyer> {

  final AuthService _auth = AuthService(); 
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String fname = '';
  String lname = '';
  String loc = '';
  String cnum = '';

  String error = '';

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
                    HeadingCreateAccount(acctype: "Welcome, Buyer!"),
                    SubText(),
                    SizedBox(height: 10),
                      
                    //Email Address
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
                            onChanged: (val) {
                                setState(() => fname = val);
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
                                setState(() => lname = val);
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
                                setState(() => loc = val);
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
                            onChanged: (val) {
                                setState(() => cnum = val);
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
                             dynamic result = await _auth.registerBuyer(email, password);
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