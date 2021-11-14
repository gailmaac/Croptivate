import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/heading_account.dart';
import 'package:croptivate_app/widgets/subtext.dart';
import 'package:croptivate_app/widgets/subtextemailpass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterBuyer extends StatefulWidget {
  const RegisterBuyer({ Key? key }) : super(key: key);

  @override
  _RegisterBuyerState createState() => _RegisterBuyerState();

  static const String routeName = '/regbuyer';
  static Route route() {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => RegisterBuyer());
  }
}

class _RegisterBuyerState extends State<RegisterBuyer> {

  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  TextEditingController cnum = new TextEditingController();

  
  TextEditingController confirmpassword = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  final AuthService _auth = AuthService(); 
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String _fname = '';
  String _lname = '';
  String _loc = '';
  String _cnum = '';

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
                    SubTextEmPass(),
                    SizedBox(height: 50),
                      
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
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your email address.";
                              }
                              if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val)){
                                return "Please enter a valid email address.";
                              }                            }, 
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
                            controller: _password,
                            validator: (val) {
                              if(val!.length < 8){
                                return 'Password must contain 8 or more characters.';
                              }
                              if(val.isEmpty) {
                                return "Please enter password.";
                              }
                              
                            },
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
                    //Re-enter Password
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
                            controller: confirmpassword,
                            validator: (val) {
                              if(val!.isEmpty) {
                                return "Please enter password.";
                              }
                              if(val != _password.value.text) {
                                return "Password do not match.";
                              }
                              return null;
                            }, 
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Confirm Password",
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
                    //Set Up Button
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
                            else {
                              Navigator.pushNamed(context, '/setupbuyer');
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