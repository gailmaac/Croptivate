import 'package:croptivate_app/models/user_model_buyer.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/authentication/sign_in.dart';
import 'package:croptivate_app/screens/sellers/edit_profile.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/widgets/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/services/database.dart';


class UserProfile extends StatelessWidget {

  static const String routeName = '/userprofilebuyer';
  
  static Route route({required User user}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => UserProfile(user: user));
  }

  final User user;
  const UserProfile({required this.user});

  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("My Profile", 
        style: TextStyle(
            fontFamily: 'Poppins',
            color: cGreen,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
                onPressed: () {
                Navigator.pop(context);
                },
                  icon: Icon(
                  Icons.arrow_back_ios,
                  color: cBlack,
                  size: 15,
                  ),
                ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
            },
            color: cBlack,
            icon: Icon(Icons.settings_outlined),
          )
        ],
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Text(
                user.fname + user.lname,
                style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Poppins',
                color: cBlack,
                fontSize: 24
              ),
              )
            ]
          ),
          const SizedBox(height: 24),
          trackOrderbutton(),
          const SizedBox(height: 10),
          myFavsbutton(),
          const SizedBox(height: 10),
          startSellbutton(),
          const SizedBox(height: 170),
          signOutButton()
        ],
      )
    );
  }

  //Track Order Button
  Widget trackOrderbutton() {
    return TextButton(
      onPressed: () {

      }, 
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.location_on_outlined, color: cGreen),
            SizedBox(width: 30),
            Text(
                "Track my Order",
              style: TextStyle(fontSize: 20,
              color: cBlack,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              )
              ),
          ],
        ),
        color: Colors.transparent,
        width: double.infinity,
        height: 65,
      )
    );
  }

  //Favorites Button
  Widget myFavsbutton() {
    return TextButton(
      onPressed: () {

      }, 
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.favorite_border_rounded, color: cGreen),
            SizedBox(width: 30),
            Text(
                "My Favorites",
              style: TextStyle(fontSize: 20,
              color: cBlack,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              )
              ),
          ],
        ),
        color: Colors.transparent,
        width: double.infinity,
        height: 65,
      )
    );
  }

//Start Selling Button
  Widget startSellbutton() {
    return TextButton(
      onPressed: () {

      }, 
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.storefront_outlined, color: cGreen),
            SizedBox(width: 30),
            Text(
                "Start Selling",
              style: TextStyle(fontSize: 20,
              color: cBlack,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              )
              ),
          ],
        ),
        color: Colors.transparent,
        width: double.infinity,
        height: 65,
      )
    );
  }

  //Sign Out Button
  Widget signOutButton() {
    return TextButton(
      onPressed: () async {
        // await _auth.signOut();
      }, 
      child: Container(
        decoration: BoxDecoration(color: cGreen,
        borderRadius: BorderRadius.circular(12)),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            Icon(Icons.logout_rounded, color: cWhite),
            SizedBox(width: 30),
            Text(
                "Sign Out",
              style: TextStyle(fontSize: 20,
              color: cWhite,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              )
              ),
          ],
        ),
        width: 350,
        height: 65,
      )
    );
  }
}

// class UserProfile extends StatefulWidget {
//   static String route = "userprofile";



//   @override
//   _UserProfileState createState() => _UserProfileState();
// }

//   bool loading = false;

//   final User user;
//   const UserProfile({required this.user});
  
// class _UserProfileState extends State<UserProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text("My Profile", 
//         style: TextStyle(
//             fontFamily: 'Poppins',
//             color: cGreen,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//         leading: IconButton(
//                 onPressed: () {
//                 Navigator.pop(context);
//                 },
//                   icon: Icon(
//                   Icons.arrow_back_ios,
//                   color: cBlack,
//                   size: 15,
//                   ),
//                 ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()));
//             },
//             color: cBlack,
//             icon: Icon(Icons.settings_outlined),
//           )
//         ],
//       ),
//       body: ListView(
//         // physics: BouncingScrollPhysics(),
//         children: [
//           // ProfileWidget(
//           //   imagePath: userOne.imagePath,
//           //   onClicked: () async {
              
//           //   }
//           // ),
//           // const SizedBox(height: 24),
//           Column(
//             children: [
//               Text(
//                 user.fname +
//               ))
//             ],
//           ),
//           const SizedBox(height: 24),
//           trackOrderbutton(),
//           const SizedBox(height: 10),
//           myFavsbutton(),
//           const SizedBox(height: 10),
//           startSellbutton(),
//           const SizedBox(height: 170),
//           signOutButton()
//         ],
//       ),
//     );
//   }

//   Widget buildName(User user) => Column(
//     children: [
//       Text(
//         user.fname + ' ' +  user.lname,
//         style: TextStyle(
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Poppins',
//           color: cBlack,
//           fontSize: 24
//         ),
//       ),
//       const SizedBox(height: 4),
//     ],
//   );
  

//   //Track Order Button
//   Widget trackOrderbutton() {
//     return TextButton(
//       onPressed: () {

//       }, 
//       child: Container(
//         padding: EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Icon(Icons.location_on_outlined, color: cGreen),
//             SizedBox(width: 30),
//             Text(
//                 "Track my Order",
//               style: TextStyle(fontSize: 20,
//               color: cBlack,
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.bold,
//               )
//               ),
//           ],
//         ),
//         color: Colors.transparent,
//         width: double.infinity,
//         height: 65,
//       )
//     );
//   }

//   //Favorites Button
//   Widget myFavsbutton() {
//     return TextButton(
//       onPressed: () {

//       }, 
//       child: Container(
//         padding: EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Icon(Icons.favorite_border_rounded, color: cGreen),
//             SizedBox(width: 30),
//             Text(
//                 "My Favorites",
//               style: TextStyle(fontSize: 20,
//               color: cBlack,
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.bold,
//               )
//               ),
//           ],
//         ),
//         color: Colors.transparent,
//         width: double.infinity,
//         height: 65,
//       )
//     );
//   }

// //Start Selling Button
//   Widget startSellbutton() {
//     return TextButton(
//       onPressed: () {

//       }, 
//       child: Container(
//         padding: EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Icon(Icons.storefront_outlined, color: cGreen),
//             SizedBox(width: 30),
//             Text(
//                 "Start Selling",
//               style: TextStyle(fontSize: 20,
//               color: cBlack,
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.bold,
//               )
//               ),
//           ],
//         ),
//         color: Colors.transparent,
//         width: double.infinity,
//         height: 65,
//       )
//     );
//   }

//   //Sign Out Button
//   Widget signOutButton() {
//     return TextButton(
//       onPressed: () async {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
//       }, 
//       child: Container(
//         decoration: BoxDecoration(color: cGreen,
//         borderRadius: BorderRadius.circular(12)),
//         padding: EdgeInsets.all(20),
//         child: Row(
//           children: [
//             Icon(Icons.logout_rounded, color: cWhite),
//             SizedBox(width: 30),
//             Text(
//                 "Sign Out",
//               style: TextStyle(fontSize: 20,
//               color: cWhite,
//               fontFamily: 'Poppins',
//               fontWeight: FontWeight.bold,
//               )
//               ),
//           ],
//         ),
//         width: 350,
//         height: 65,
//       )
//     );
//   }
// }