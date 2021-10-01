import 'package:croptivate_app/models/user.dart';
import 'package:croptivate_app/screens/authentication/authenticate.dart';
import 'package:croptivate_app/screens/home/home_buyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final MyUser? user = Provider.of<MyUser?>(context);
    print(user);
    
    //return either Home or Authenticate Widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
    

  }
}