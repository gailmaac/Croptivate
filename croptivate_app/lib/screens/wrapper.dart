import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/models/user.dart';
import 'package:croptivate_app/screens/authentication/authenticate.dart';
import 'package:croptivate_app/screens/buyers/home_buyer.dart';
import 'package:croptivate_app/screens/sellers/home_seller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);
  static const String routeName = '/wrapper';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => Wrapper());
  }

  @override
  Widget build(BuildContext context) {
    final MyUser? user = Provider.of<MyUser?>(context);
    print(user);
    int seller = 0;
    getuserSeller() async {
      try {
        await FirebaseFirestore.instance
            .collection('userSeller')
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            if (user!.uid == doc.id) {
              seller = 1;
            }
          });
        });
      } catch (e) {
        print(e.toString());
      }
    }

    //return either Home or Authenticate Widget
    if (user == null) {
      return Authenticate();
    } else {
      getuserSeller();
      if (seller == 1) {
        return HomeSeller();
      } else {
        return HomeBuyer();
      }
    }
  }
}
