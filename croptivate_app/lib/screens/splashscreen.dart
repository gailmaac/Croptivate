// import 'dart:async';
// import 'package:croptivate_app/screens/wrapper.dart';
// import 'package:croptivate_app/widgets/backgroundimage.dart';
// import 'package:croptivate_app/screens/home/home_buyer.dart';
// import 'package:flutter/material.dart';


// class SplashScreen extends StatefulWidget {
//   const SplashScreen({ Key? key }) : super(key: key);

//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   startTimer() {
//     Timer(Duration(seconds:4), () async {
//       Route newRoute = MaterialPageRoute(builder: (context) => Wrapper());
//       Navigator.pushReplacement(context, newRoute);
//     });
//   }


//   @override
//   void initState() {
//     super.initState();
//     startTimer();
//   }
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Image.asset("assets\splashscreen.png"),
//       ]
//     );
//   }
// }

