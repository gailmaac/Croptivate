import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();

  static const String routeName = '/signin';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => SignIn());
  }
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final FirebaseAuth auth = FirebaseAuth.instance;
  String uid = '';
  int seller = 0;
  //textformfield state
  String email = '';
  String password = '';

  String error = '';

  Future<void> inputData() async {
    final User user = await auth.currentUser!;
    uid = user.uid;
    print(uid);
    // here you write the codes to input the data into firestore
  }

  getuserSeller() async {
    try {
      await FirebaseFirestore.instance
          .collection('userSeller')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          if (uid == doc.id) {
            seller = 1;
          }
        });
      });
      route();
    } catch (e) {
      print(e.toString());
    }
  }

  route() {
    if (seller == 1) {
      Navigator.pushNamed(context, '/homeseller');
    } else {
      Navigator.pushNamed(context, '/homebuyer');
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    //print(uid);

    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading()
        : Stack(
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
                      )),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          //EMAIL ADDRESS
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
                                  validator: (val) => val!.isEmpty
                                      ? 'Enter a valid Email Address'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: cWhite, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(Icons.mail_outline_rounded,
                                          size: 20, color: cWhite),
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
                          ),

                          //PASSWORD
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
                                  validator: (val) => val!.length < 8
                                      ? 'Password must contain 8 or more characters.'
                                      : null,
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: cWhite, width: 2.0),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    border: InputBorder.none,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Icon(Icons.lock_outline_rounded,
                                          size: 20, color: cWhite),
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
                          ),

                          GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, '/forgotpass'),
                            child: Text(
                              "Forgot Password?",
                              style: smallBodyText,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          Text(error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 14)),
                          Container(
                            height: size.height * 0.07,
                            width: size.width * 0.8,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: cGreen),
                            child: TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.signIn(email, password);

                                  if (result == null) {
                                    setState(() {
                                      error =
                                          "Could not sign in with those credentials";
                                      loading = false;
                                    });
                                  } else {
                                    inputData();
                                    getuserSeller();
                                  }
                                }
                              },
                              child: Text(
                                "Sign In",
                                style: cBodyText.copyWith(
                                    fontWeight: FontWeight.bold),
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
                      onTap: () {
                        Navigator.pushNamed(context, '/accountcategories');
                      },
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.8,
                        child: Center(
                          child: Text(
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
                    // Container(
                    //   child: TextButton(
                    //     onPressed: () async {
                    //       setState(() {
                    //         loading = true;
                    //       });
                    //     dynamic result = await _auth.signInAnon();
                    //     if(result == null){
                    //       print("There is an error signing in.");
                    //       print(result);
                    //     } else {
                    //         print("You have signed in.");
                    //         print(result.uid);
                    //       }
                    //     },

                    //     child: Text(
                    //       "Continue as Guest.",
                    //       style: smallBodyText,
                    //     ),
                    //   ),
                    //   decoration: BoxDecoration(
                    //     border: Border(bottom: BorderSide(
                    //       width: 0.5,
                    //       color: cWhite)
                    //     )
                    //   )
                    // ),
                    SizedBox(height: 50)
                  ],
                ),
              )
            ],
          );
  }
}
