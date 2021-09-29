import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/inputpassword.dart';
import 'package:croptivate_app/widgets/roundedtext_button.dart';
import 'package:croptivate_app/widgets/textinputfield.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({ Key? key }) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService(); 

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextInputField(
                    icon: Icons.mail_outline,
                    hint: "Email Address",
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                  ),
                  InputPassword(
                  icon: Icons.lock_outline_rounded,
                  hint: "Password",
                  inputType: TextInputType.visiblePassword,
                  inputAction: TextInputAction.done,
                  ),
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
                  RoundedTextButton(buttonName: 'Sign In',),
                  SizedBox(
                    height: 10,
                  ),
                ],
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