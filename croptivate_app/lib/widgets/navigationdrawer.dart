import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/authentication/sign_in.dart';
import 'package:croptivate_app/screens/sellers/home_seller.dart';
import 'package:croptivate_app/screens/sellers/notifications.dart';
import 'package:croptivate_app/screens/sellers/orders.dart';
import 'package:croptivate_app/screens/sellers/product_listings.dart';
import 'package:croptivate_app/screens/sellers/settings.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NavigationDrawerWidget extends StatelessWidget {

  final AuthService _auth = AuthService();
  final padding = EdgeInsets.symmetric(horizontal: 25);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Drawer( 
      child: Material(
        color: cWhite,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 300,),
            buildMenuItem(
              text: "Notifications",
              icon: Icons.notifications_none_rounded,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16,),
            buildMenuItem(
              text: "Product Listings",
              icon: Icons.note_alt_outlined,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16,),
            buildMenuItem(
              text: "Orders",
              icon: Icons.shopping_basket_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
            const SizedBox(height: 300,),
            // Divider(color: Colors.black38,),
            // const SizedBox(height: 10,),
            // buildMenuItem(
            //   text: "Sign Out",
            //   icon: Icons.logout_rounded,
            //   onClicked: () async {
            //     await _auth.signOut();
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
            //   }
            // ),
          ],
        ),
        ),
    );
  }


}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,

}) {
  final color = cGreen;
  final hoverColor = cWhite;

  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(
      text, 
      style: TextStyle(
        color: color,
        fontFamily: 'Poppins',
        fontSize: 20,
        fontWeight: FontWeight.w500)
    ),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

void selectedItem(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushNamed(context, '/notifications');
      break;
    case 1:
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => ProductPage()));
      break;
    case 2:
      Navigator.pushNamed(context, '/homeseller');
      break;
    default: break;
  }
}
