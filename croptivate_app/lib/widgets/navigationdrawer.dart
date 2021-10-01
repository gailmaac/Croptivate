import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/sellers/dashboard_page.dart';
import 'package:croptivate_app/sellers/notifications.dart';
import 'package:croptivate_app/sellers/product_listings.dart';
import 'package:croptivate_app/sellers/orders.dart';
import 'package:croptivate_app/sellers/settings.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class NavigationDrawerWidget extends StatelessWidget {

  final AuthService _auth = AuthService();
  final padding = EdgeInsets.symmetric(horizontal: 25);
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Drawer( 
      child: Material(
        color: cWhite,
        child: ListView(
          padding: padding,
          children: <Widget>[
            const SizedBox(height: 48,),
            buildMenuItem(
              text: "Dashboard",
              icon: Icons.space_dashboard_outlined,
              onClicked: () => selectedItem(context, 0),
            ),
            const SizedBox(height: 16,),
            buildMenuItem(
              text: "Notifications",
              icon: Icons.notifications_none_rounded,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 16,),
            buildMenuItem(
              text: "Product Listings",
              icon: Icons.note_alt_outlined,
              onClicked: () => selectedItem(context, 2),
            ),
             const SizedBox(height: 16,),
            buildMenuItem(
              text: "Orders",
              icon: Icons.shopping_basket_outlined,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 16,),
            Divider(color: Colors.black38,),

            const SizedBox(height: 16,),
            buildMenuItem(
              text: "Settings",
              icon: Icons.settings_outlined,
              onClicked: () => selectedItem(context, 4),
            ),

            const SizedBox(height: 16,),
            buildMenuItem(
              text: "Sign Out",
              icon: Icons.logout_rounded,
              onClicked: () async{
                loading = true;
                await _auth.signOut();
              }
            ),
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
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => DashboardPage()));
       break;
     case 1:
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationsPage()));
       break;
     case 2:
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProductPage()));
       break;
     case 3:
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => OrdersPage()));
       break;
     case 4:
       Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
       break;  
     default: break;
   }
 }
