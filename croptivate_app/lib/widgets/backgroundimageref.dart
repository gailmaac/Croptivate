import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BackgroundImageRef extends StatelessWidget {
  const BackgroundImageRef({
    Key? key, 
    required this.image,
  }) : super(key: key);

final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            
            )
        )
      );
  }
}
