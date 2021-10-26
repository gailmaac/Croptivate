import 'dart:async';
import 'package:croptivate_app/screens/wrapper.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();

  static const String routeName = '/splash';
  
  static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => SplashScreen());
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () => Navigator.pushNamed(context, '/'));
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Image.asset(
        "assets/splashscreen.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

