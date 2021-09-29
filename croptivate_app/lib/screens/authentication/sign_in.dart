import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService(); 

  //textformfield state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        BackgroundImage(image: "assets/vegetable2.jpg"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Text(
                    "Croptivate",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ),
              Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                                child: Icon(
                                  Icons.mail_outline_rounded, 
                                  size: 20, 
                                  color: cWhite),
                              ),
                              hintText: "Email Address",
                              hintStyle: cBodyText,
                            ),
                            style: cBodyText,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                      ),
                    ), //EMAIL ADDRESS

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      height: size.height * 0.07,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        color: Colors.grey[500]!.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: TextFormField(
                          onChanged: (val) {
                            setState(() => password = val);
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Icon(
                                Icons.lock_outline_rounded, 
                                size: 20, 
                                color: cWhite),
                            ),
                            hintText: "Password",
                            hintStyle: cBodyText,
                          ),
                          obscureText: true,
                          style: cBodyText,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                    ),
                  ), //PASSWORD
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, 'ForgotPassword'),
                      child: Text(
                        "Forgot Password?",
                        style: smallBodyText,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: cGreen),
                      child: TextButton(
                        onPressed: () async{
                          print(email);
                          print(password);
                        },
                        child: Text(
                          "Sign In",
                          style: cBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, 'AccountCategories'),
                child: Container(
                  height: size.height * 0.07,
                  width: size.width * 0.8,
                  child: Center(
                    child:Text(
                      "Create New Account",
                      style: cBodyText,
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: cGreen),
                ),
              ),
                SizedBox(height: 5),
              Container(
                child: TextButton(
                  onPressed: () async {
                   dynamic result = await _auth.signInAnon();
                   if(result == null){
                     print("There is an error signing in.");
                     print(result);
                   } else {
                     print("You have signed in.");
                     print(result.uid);
                   }
                  },
                  child: Text(
                    "Continue as Guest.",
                    style: smallBodyText,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(
                    width: 0.5, 
                    color: cWhite)
                  )
                )
              ),
              SizedBox(height: 20)
            ],
          ),
        )
      ],
    );
  }
}