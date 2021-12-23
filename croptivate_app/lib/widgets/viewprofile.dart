import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/product_screen.dart';
import 'package:croptivate_app/screens/sellers/shopprofile.dart';
import 'package:flutter/material.dart';

class ViewProfile extends StatelessWidget {
  final type;
  final firstname;
  final lastname;
  final location;
  final contactnumber;
  final profilepic;
  final shopname;
  final sellerType;
  final uid;

  const ViewProfile({
    Key? key,
    required this.type,
    required this.firstname,
    required this.lastname,
    required this.location,
    required this.contactnumber,
    required this.profilepic,
    required this.uid,
    this.shopname,
    this.sellerType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(uid);
    return type == 'Seller'
        ? Expanded(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Text(
                  firstname.toString() + ' ' + lastname.toString(),
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
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        // getusers()
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: CircleAvatar(
                        radius: 80.0,
                        child: ClipOval(
                            child: Image.network(
                          profilepic,
                          fit: BoxFit.cover,
                          width: 160.0,
                          height: 160.0,
                        )),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.person_outline_rounded, color: cGreen),
                          SizedBox(
                            width: 40,
                          ),
                          Flexible(
                            child: Text(
                              firstname.toString() + ' ' + lastname.toString(),
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: cBlack),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.phone_android_rounded, color: cGreen),
                          SizedBox(
                            width: 40,
                          ),
                          Text(
                            "+63" + contactnumber,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: cBlack),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.location_on_outlined, color: cGreen),
                          SizedBox(
                            width: 40,
                          ),
                          Flexible(
                            child: Text(
                              location,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: cBlack),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        children: [
                          Icon(Icons.store_outlined, color: cGreen),
                          SizedBox(
                            width: 40,
                          ),
                          Flexible(
                            child: Text(
                              shopname,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                  color: cBlack),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(start: 125),
                      child: Container(
                        height: 33,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: cGrey,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SellerShop(
                                          type: 'Seller',
                                          firstname: firstname,
                                          lastname: lastname,
                                          location: location,
                                          contactnumber:
                                              contactnumber.toString(),
                                          profilepic: profilepic,
                                          shopname: shopname,
                                          uid: uid,
                                        )));
                          },
                          child: Text("View Shop",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 12,
                                  color: cGreen)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(
                firstname.toString() + ' ' + lastname.toString(),
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
            ),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                  Column(
                    children: [
                      // getusers()
                    ],
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: CircleAvatar(
                      radius: 80.0,
                      child: ClipOval(
                          child: Image.network(
                        profilepic,
                        fit: BoxFit.cover,
                        width: 160.0,
                        height: 160.0,
                      )),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline_rounded, color: cGreen),
                        SizedBox(
                          width: 40,
                        ),
                        Flexible(
                          child: Text(
                            firstname.toString() + ' ' + lastname.toString(),
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: cBlack),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Icon(Icons.phone_android_rounded, color: cGreen),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          "+63" + contactnumber,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: cBlack),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: cGreen),
                        SizedBox(
                          width: 40,
                        ),
                        Flexible(
                          child: Text(
                            location,
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: cBlack),
                          ),
                        ),
                      ],
                    ),
                  )
                ])));
  }
}
