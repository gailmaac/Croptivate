import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageWidget extends StatelessWidget {
  final File image;
  final ValueChanged<ImageSource> onClicked;

  const ImageWidget({ 
    Key? key,
    required this.image,
    required this.onClicked, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Center(
        child: Stack(
          children: [
            buildImage(context),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.transparent, 
                borderRadius: BorderRadius.circular(12), 
                border: Border.all(
                  width: 1, 
                  color: cGrey
                ),
              ),
            ),
          ]
        )
    );  
  }

  Widget buildImage(BuildContext context) {
    final imagePath = this.image.path;
    final image = imagePath. contains('https://')
      ? NetworkImage(imagePath)
      : FileImage(File(imagePath));

      return Container(
        height: 90,
        width: 90,
        decoration: BoxDecoration(
        color: Colors.transparent, 
        borderRadius: BorderRadius.circular(12), 
        border: Border.all(
          width: 1, 
          color: cGrey),
        ),
        child: Material(
          child: Ink.image(
            image: image as ImageProvider,
            fit: BoxFit.cover,
            width: 90,
            height: 90,
            child: InkWell(
              onTap: () async {
                final source = await showImageSource(context);
                if (source == null) return;

                onClicked(source);
              },
            )
          ),
        )
      );
  }
}

showImageSource(BuildContext context) {
}