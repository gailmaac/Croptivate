import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
    final String imagePath;
    final VoidCallback onClicked;


    const ProfileWidget ({
      Key? key,
      required this.imagePath,
      required this.onClicked,
    });

    @override
    Widget build(BuildContext context) {
      return Center(
        child: Stack(
          children: [
            buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon()),
          ],
        ),
      );
    }

  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked,),
        ),
      ),
    );
  }

  Widget buildEditIcon() => buildCircle(
    all: 3, 
    color: cWhite,
    child: buildCircle(
      color: cGreen,
      all: 8,
      child: Icon(
        Icons.edit_outlined,
        size: 20,
        color: cWhite,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) => 
    ClipOval(
      child: Container(
        child: child,
        padding: EdgeInsets.all(all),
        color: color,
      ),
    );
}

