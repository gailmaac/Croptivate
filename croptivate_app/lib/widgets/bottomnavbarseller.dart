import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/sellers/add_product.dart';
import 'package:flutter/material.dart';

class BottomNavBarSeller extends StatelessWidget {
  const BottomNavBarSeller({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
          left: 30,
          right: 30,
          bottom: 20,
          top: 10,
        ),
        height: 60,
        decoration: BoxDecoration(color: cWhite, boxShadow: [
          BoxShadow(
            offset: Offset(1, 10),
            blurRadius: 35,
            color: cGrey.withOpacity(0.40),
          )
        ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {
                print("Messaging is pressed");
              },
              icon: Icon(
                Icons.chat_bubble_outline_rounded,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addproduct');
              },
              icon: Icon(
                Icons.add_circle_outline_rounded,
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/userprofileseller');
                },
                icon: Icon(
                  Icons.person_outline_rounded,
                )),
          ],
        ));
  }
}
