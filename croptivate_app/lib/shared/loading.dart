import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: cWhite,
      child: Center(
        child: SpinKitThreeBounce(color: cGreen, size: 50.0,)
      )
    );
  }
}