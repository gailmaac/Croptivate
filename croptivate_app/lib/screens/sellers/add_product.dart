import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/screens/sellers/home_seller.dart';
import 'package:croptivate_app/widgets/imagewidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddProduct extends StatefulWidget {

  @override
  _AddProductState createState() => _AddProductState();
    static const String routeName = '/addproduct';
    static Route route() {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => AddProduct());
  }
}

class _AddProductState extends State<AddProduct> {

  TextEditingController locationController = new TextEditingController();
  TextEditingController prodnameController = new TextEditingController();
  TextEditingController proddescController = new TextEditingController();
  TextEditingController stockController = new TextEditingController();
  TextEditingController retailController = new TextEditingController();
  TextEditingController countController = new TextEditingController();
  TextEditingController wholesaleController = new TextEditingController();

  final storageRef = FirebaseStorage.instance.ref();
  final postRef = FirebaseFirestore.instance.collection('sellerPosts');
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final picUrl = '';
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;
  
  File ? imageOne;
  set _imageOneFile(XFile? value) {
    imageOne = (value == null ? null : [value]) as File?;
  }

  File ? imageTwo;
  set _imageTwoFile(XFile? value) {
    imageTwo = (value == null ? null : [value]) as File?;
  }
  File ? imageThree;
set _imageThreeFile(XFile? value) {
    imageThree = (value == null ? null : [value]) as File?;
  }

  
  String postIdOne = Uuid().v4();
  String postIdTwo = Uuid().v4();
  String postIdThree = Uuid().v4();
  String postId = Uuid().v4();

  bool isUploading = false;

  // String? get uid => null;



  uploadImageOne(imageOne) async {
    UploadTask uploadTaskOne = storageRef.child("sellerposts_$postId/post_$postIdOne.jpg").putFile(imageOne);
    TaskSnapshot storageSnapOne = await uploadTaskOne;
    String downloadUrlOne = await storageSnapOne.ref.getDownloadURL();
    return downloadUrlOne;
  }

  uploadImageTwo(imageTwo) async {
    UploadTask uploadTaskTwo = storageRef.child("sellerposts_$postId/post_$postIdTwo.jpg").putFile(imageTwo);
    TaskSnapshot storageSnapTwo = await uploadTaskTwo;
    String downloadUrlTwo = await storageSnapTwo.ref.getDownloadURL();
    return downloadUrlTwo;
  }

  uploadImageThree(imageThree) async {
    UploadTask uploadTaskThree = storageRef.child("sellerposts_$postId/post_$postIdThree.jpg").putFile(imageThree);
    TaskSnapshot storageSnapThree = await uploadTaskThree;
    String downloadUrlThree = await storageSnapThree.ref.getDownloadURL();
    return downloadUrlThree;
  }

  createPostInFirestore({String? mediaUrlOne, 
                    String? mediaUrlTwo, 
                    String? mediaUrlThree, 
                    String? myInitialCat,
                    bool? isDeals,
                    bool? isRecommended,
                    String? prodname, 
                    String? proddesc, 
                    String? stock, String? retail, String? count, String? wholesale, String? location}) {
    postRef
    .doc(_auth.currentUser!.uid)
    .collection('sellerPosts')
    .doc(postId)
    .set({
      "postId": postId,
      "ownerId": _auth.currentUser!.uid,
      "mediaUrlOne": mediaUrlOne,
      "mediaUrlTwo": mediaUrlTwo,
      "mediaUrlThree": mediaUrlThree,
      "myInitialCat": myInitialCat,
      "isDeals": isDeals,
      "isRecommended": isRecommended,
      "prodname": prodname,
      "proddesc": proddesc,
      "stock": stock,
      "retail": retail,
      "count": count,
      "wholesale": wholesale,
      "location": location,
      "time": DateTime.now(),
      "status": 'active',
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    String mediaUrlOne = await uploadImageOne(imageOne);
    String mediaUrlTwo = await uploadImageTwo(imageTwo);
    String mediaUrlThree = await uploadImageThree(imageThree);

    createPostInFirestore(
      mediaUrlOne: mediaUrlOne,
      mediaUrlTwo: mediaUrlTwo,
      mediaUrlThree: mediaUrlThree,
      myInitialCat: myInitialCat,
      isDeals: isDeals,
      isRecommended: isRecommended,
      prodname: prodnameController.text,
      proddesc: proddescController.text,
      stock: stockController.text,
      retail: retailController.text,
      count: countController.text,
      wholesale: wholesaleController.text,
      location: locationController.text
    );
    prodnameController.clear();
    proddescController.clear();
    stockController.clear();
    retailController.clear();
    countController.clear();
    wholesaleController.clear();
    locationController.clear();
    setState(() {
      Navigator.pushNamed(context, '/');
    });
  }


  Future chooseImageOne(ImageSource source) async {

    try {
      final imageOne = await ImagePicker().pickImage(source: source);
    if (imageOne == null) return;

    final imageTemporary = File(imageOne.path);
    setState(() => this.imageOne = imageTemporary);
    } on PlatformException catch(error) {
      print("Failed to pick image: $error");
    }
  }

  Future chooseImageTwo(ImageSource source) async {
    
    try {
      final imageTwo = await ImagePicker().pickImage(source: source);
    if (imageTwo == null) return;

    final imageTemporary = File(imageTwo.path);
    setState(() => this.imageTwo = imageTemporary);
    } on PlatformException catch(error) {
      print("Failed to pick image: $error");
    }
  }

  Future chooseImageThree(ImageSource source) async {
  
    try {
      final imageThree = await ImagePicker().pickImage(source: source);
    if (imageThree == null) return;

    final imageTemporary = File(imageThree.path);
    setState(() => this.imageThree = imageTemporary);
    } on PlatformException catch(error) {
      print("Failed to pick image: $error");
    }
  }

  selectImageOne(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Upload Product Image",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          )),
          children: <Widget>[
            SimpleDialogOption(
              child: TextButton(
                child: Text("Take Picture with Camera",
                style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
              onPressed: () => chooseImageOne(ImageSource.camera),
              )
            ),
            SimpleDialogOption(
              child: TextButton(
                child: Text("Choose Image from Gallery",
                  style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
                onPressed: () => chooseImageOne(ImageSource.gallery),
              )
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ]
        );
      }
    );
  }

  selectImageTwo(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Upload Product Image",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          )),
          children: <Widget>[
            SimpleDialogOption(
              child: TextButton(
                child: Text("Take Picture with Camera",
                style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
              onPressed: () => chooseImageTwo(ImageSource.camera),
              )
            ),
            SimpleDialogOption(
              child: TextButton(
                child: Text("Choose Image from Gallery",
                  style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
                onPressed: () => chooseImageTwo(ImageSource.gallery),
              )
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ]
        );
      }
    );
  }

  selectImageThree(parentContext) {
    return showDialog(
      context: parentContext,
      builder: (context) {
        return SimpleDialog(
          title: Text("Upload Product Image",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 20
          )),
          children: <Widget>[
            SimpleDialogOption(
              child: TextButton(
                child: Text("Take Picture with Camera",
                style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
              onPressed: () => chooseImageThree(ImageSource.camera),
              )
            ),
            SimpleDialogOption(
              child: TextButton(
                child: Text("Choose Image from Gallery",
                  style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins'
                  ),
                ),
                onPressed: () => chooseImageThree(ImageSource.gallery),
              )
            ),
            SimpleDialogOption(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            )
          ]
        );
      }
    );
  }
  

  var myInitialCat;

  //textfieldform state
  List<String> myCategory = [
    "Plant Vegetables",
    "Climbers and Creepers",
    "Leafy Vegetables",
    "Root Vegetables",
  ];

  bool isDeals = false;
  bool isRecommended = false;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        toolbarHeight: 60,
        iconTheme: IconThemeData(color: cGreen),
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
        backgroundColor: cWhite,
        elevation: 0.0,
        title: Text("Add Product",
        style: TextStyle(
          color: cGreen,
          fontFamily: 'Poppins',
          fontSize: 22,
          fontWeight: FontWeight.w500
          ),
        ),
        centerTitle: true,
        actions: <Widget> [
          TextButton(
            onPressed: isUploading ? null : () => handleSubmit(),
            child: Text("Post",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: cDGreen,
              ),
            ),
          )
        ],
      ),
      
    body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          isUploading ? LinearProgressIndicator(valueColor: AlwaysStoppedAnimation(cGreen)) : Text(""),
          SizedBox(height: 5),
          Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(color: cWhite),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                  child: Text(
                    "Product Image",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: cBlack
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional(-0.05, 0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(42, 15, 30, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //first add image button
                        imageOne != null 
                        ? ImageWidget(image: imageOne!, 
                        onClicked: (source) => selectImageOne(context)) 
                        : Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: FileImage(imageOne!),
                              // ),
                              color: Colors.transparent, 
                              borderRadius: BorderRadius.circular(12), 
                              border: Border.all(
                                width: 1, 
                                color: cGrey),
                              ),
                            child: TextButton(
                              onPressed: () => selectImageOne(context),
                              child: Icon(Icons.add_circle_outline, size: 15, color: cGrey),
                              
                            ),
                          ), 
                          SizedBox(width: 20),
                        
                        // second add image button
                          imageTwo != null 
                          ? ImageWidget(image: imageTwo!, 
                          onClicked: (source) => selectImageTwo(context)) 
                          : Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: FileImage(imageTwo!),
                              // ),
                              color: Colors.transparent, 
                              borderRadius: BorderRadius.circular(12), 
                              border: Border.all(
                                width: 1, 
                                color: cGrey),
                              ),
                            child: TextButton(
                              onPressed: () => selectImageTwo(context),
                              child: Icon(Icons.add_circle_outline, size: 15, color: cGrey),
                              
                            ),
                          ),
                          SizedBox(width: 20),

                        
                        //third add image button
                          imageThree != null 
                          ? ImageWidget(image: imageThree!, 
                          onClicked: (source) => selectImageThree(context)) 
                          : Container(
                            height: 90,
                            width: 90,
                            decoration: BoxDecoration(
                              // image: DecorationImage(
                              //   image: FileImage(imageThree!),
                              // ),
                              color: Colors.transparent, 
                              borderRadius: BorderRadius.circular(12), 
                              border: Border.all(
                                width: 1, 
                                color: cGrey),
                              ),
                            child: TextButton(
                              onPressed: () => selectImageThree(context),
                              child: Icon(Icons.add_circle_outline, size: 15, color: cGrey),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ), 
          ),
          
          //Dropdown for category
          Container(
            child: Center(
              child: DropdownButtonHideUnderline(
                child: Container(
                  height: size.height * 0.06,
                  width: size.width * 0.92,
                  padding: EdgeInsets.only(left: 16, right: 16),
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: cGrey, width: 1.0)
                    ),
                  child: DropdownButton(
                    hint: Text("Choose Product Category", style: inputBodyText.copyWith(color: Colors.black87)),
                    dropdownColor: cWhite,
                    icon: Icon(Icons.arrow_drop_down_circle_outlined, color: cGrey, size: 23),
                    style: inputBodyText.copyWith(color: Colors.black87),
                    onChanged: (value) {
                      setState(() {
                        myInitialCat = value;
                      });
                    },
                    value: myInitialCat,
                    items: myCategory.map((items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList()),
                ),
              ) 
            ),
          ),
          SizedBox(height: 5),

        //Radio button for field posting
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
              child: Container(
                child: Text("Post this product on:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: cBlack,
                      ),
                    ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: isDeals,
                        activeColor: cGreen,
                        onChanged: (bool? value) {
                          setState(() {
                            isDeals = value!;
                            print("Deals");
                          });
                        }),
                      Text("Deals of the Day", 
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: cBlack,
                          fontSize: 16
                        )
                      )
                    ],
                  ),
                    Row(
                      children: [
                        Checkbox(
                        value: isRecommended,
                        activeColor: cGreen,
                        onChanged: (bool? value) {
                          setState(() {
                            isRecommended = value!;
                            print("Recommended");
                          });
                        }),
                        Text("Recommended", 
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: cBlack,
                          fontSize: 16
                        )
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),

          //Product Name
          Container(
            width: double.infinity,
            height: 90,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                  child: Text("Product Name",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: cBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(
                    controller: prodnameController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: cGrey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: cGrey, width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: "Enter Product Name",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: cGrey,
                        fontSize: 14
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        fontSize: 14
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                  ),
                ), 
              ],
            )
          ),
          
          //Product Description
          Container(
            width: double.infinity,
            height: 150,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                  child: Text("Product Description",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: cBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(
                    controller: proddescController,
                    maxLines: 7,
                    minLines: 5,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: cGrey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: cGrey, width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: "Enter Product Description",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: cGrey,
                        fontSize: 14
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        fontSize: 14
                    ),
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.newline,
                  ),
                ), 
              ],
            )
          ),
    
         //Stock Count 
          Container(
            width: double.infinity,
            height: 90,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                  child: Text("Stocks",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: cBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(
                    controller: stockController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: cGrey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: cGrey, width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: "Input Stock Number",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: cGrey,
                        fontSize: 14
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        fontSize: 14
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ), 
              ],
            )
          ),
          
          //Retail Price
          Container(
            width: double.infinity,
            height: 90,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                  child: Text("Retail Price",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: cBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(
                    controller: retailController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: cGrey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: cGrey, width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: "Input Retail Price in Pesos",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: cGrey,
                        fontSize: 14
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        fontSize: 14
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ), 
              ],
            )
          ),

          //Minimum Count for Wholesale
          Container(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                    child: Text(
                      "Enter minimum count for wholesale:",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: cBlack,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(250, 0, 0, 0),
                    child: TextFormField(
                      controller: countController,
                      decoration: InputDecoration(
                        contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                        borderSide: BorderSide(color: cGrey, width: 1.0)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: cGrey, width: 1.0),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        hintText: "Count",
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          color: cGrey,
                          fontSize: 14
                        ),
                      ),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.black87,
                          fontSize: 14
                      ),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                    ),
                  )
                ],
              ),
            ),
          ),

          //Wholesale Price
          Container(
            width: double.infinity,
            height: 90,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                  child: Text("Wholesale Price",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: cBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(
                    controller: wholesaleController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: cGrey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: cGrey, width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: "Input Wholesale Price in Pesos",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: cGrey,
                        fontSize: 14
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        fontSize: 14
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ), 
              ],
            )
          ),

          //Location
          Container(
            width: double.infinity,
            height: 90,
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                  child: Text("Location",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: cBlack,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(15, 30, 15, 0),
                  child: TextFormField(
                    controller: locationController,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                      contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                      borderSide: BorderSide(color: cGrey, width: 1.0)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: cGrey, width: 1.0),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      hintText: "Input Location",
                      hintStyle: TextStyle(
                        fontFamily: 'Poppins',
                        color: cGrey,
                        fontSize: 14
                      ),
                    ),
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.black87,
                        fontSize: 14
                    ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                  ),
                ), 
              ],
            )
          ),

          //Location Button
          Container(
            width: 250,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: cGreen
            ),
            child: TextButton.icon(
              onPressed: getLocation,
              icon: Icon(
                Icons.location_pin,
                color: cWhite,
                size: 20), 
              label: Text("Use your curent location",
                style: TextStyle(
                  color: cWhite,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ), 
          ),
          SizedBox(height: 10)
        ],
      ),
    ),
    
    bottomNavigationBar: Container(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            bottom: 20,
            top: 10,
          ),
          height: 60,
          decoration: BoxDecoration(
            color: cWhite,
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 10),
                blurRadius: 35,
                color: cGrey.withOpacity(0.40),
              )
            ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  print("Messaging is pressed");
                }, 
                icon: Icon(Icons.chat_bubble_outline_rounded, ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AddProduct()));
                }, 
                icon: Icon(Icons.add_circle_outline_rounded, ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, UserProfile.route);
                }, 
                icon: Icon(Icons.person_outline_rounded, )
              ),
          ],)
        ),
    );
  }

  getLocation() async {

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  
    List<Placemark>? placemarks;
  
    placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    Placemark placemark = placemarks[0];

    String completeAddress =
    '${placemark.subThoroughfare}${placemark.thoroughfare},'
    '${placemark.subThoroughfare}${placemark.locality},'
    '${placemark.subAdministrativeArea},'
    '${placemark.administrativeArea},'
    '${placemark.postalCode},'
    '${placemark.country}';

    print(completeAddress);
    String formattedAddress = '${placemark.locality}, ${placemark.country}';
    locationController.text = formattedAddress;
  }

}




