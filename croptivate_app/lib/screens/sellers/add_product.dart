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
  TextEditingController nameController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController weightCountController = new TextEditingController();
  TextEditingController stockCountController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();
  // TextEditingController countController = new TextEditingController();
  // TextEditingController wholesaleController = new TextEditingController();

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

  String? get uid => null;

  final _formKey = GlobalKey<FormState>();

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

  createPostInFirestore({String? imageUrlOne, 
                    String? imageUrlTwo, 
                    String? imageUrlThree, 
                    String? category,
                    bool? isDeals,
                    bool? isRecommended,
                    String? name, 
                    String? description, 
                    String? weight,
                    int? weightCount,
                    int? stockCount, 
                    double? price, }) {
                     //String? wholesale, //String? count String? location
    postRef
    .doc(postId)
    .set({
      // "postId": postId,
      "ownerId": _auth.currentUser!.uid,
      "imageUrlOne": imageUrlOne,
      "imageUrlTwo": imageUrlTwo,
      "imageUrlThree": imageUrlThree,
      "category": category,
      "isDeals": isDeals,
      "isRecommended": isRecommended,
      "name": name,
      "description": description,
      "weightCount": weightCount,
      "weight": weight,
      "stockCount": stockCount,
      "price": price,
      // "count": count,
      // "wholesale": wholesale,
      // "location": location,
    });
  }

  handleSubmit() async {
    setState(() {
      isUploading = true;
    });
    String imageUrlOne = await uploadImageOne(imageOne);
    String imageUrlTwo = await uploadImageTwo(imageTwo);
    String imageUrlThree = await uploadImageThree(imageThree);

    createPostInFirestore(
      imageUrlOne: imageUrlOne,
      imageUrlTwo: imageUrlTwo,
      imageUrlThree: imageUrlThree,
      category: category,
      isDeals: isDeals,
      isRecommended: isRecommended,
      name: nameController.text,
      description: descriptionController.text,
      weight: weight,
      weightCount: int.parse(weightCountController.text),
      stockCount: int.parse(stockCountController.text),
      price: double.parse(priceController.text),
      // count: countController.text,
      // wholesale: wholesaleController.text,
      // location: locationController.text
    );
    nameController.clear();
    descriptionController.clear();
    weightCountController.clear();
    stockCountController.clear();
    priceController.clear();
    // countController.clear();
    // wholesaleController.clear();
    // locationController.clear();
    setState(() {
      Navigator.pushNamed(context, '/homeseller');
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
  

  var category;
  var weight;

  //textfieldform state
  List<String> myCategory = [
    "Plant Vegetables",
    "Climbers and Creepers",
    "Leafy Vegetables",
    "Root Vegetables",
  ];

  List<String> weightVar = [
    "kg",
    "grams",
    "pieces",
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
        title: Text(
              "Add Product",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: cGreen,
                fontWeight: FontWeight.bold,
              ),
            ),
        centerTitle: true,
        actions: <Widget> [
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()){
                setState(() {
                  isUploading = true;
                });
                handleSubmit(); 
              }
              // isUploading ? null : () => 
            },
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
      child: Form(
        key: _formKey,
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
                          InkWell(
                            onTap: () {
                              selectImageOne(context);
                            },
                            child: imageOne == null ? Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/addimage.png")
                                ),
                                color: Colors.transparent, 
                                borderRadius: BorderRadius.circular(12), 
                                border: Border.all(
                                  width: 1, 
                                  color: cGrey),
                                ),
                            ) :  Container(
                              height: 90,
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(imageOne!.path),
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                )
                              )
                            )
                          ),
                            SizedBox(width: 20),
                          
                          // second add image button
                            InkWell(
                            onTap: () {
                              selectImageTwo(context);
                            },
                            child: imageTwo == null ? Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/addimage.png")
                                ),
                                color: Colors.transparent, 
                                borderRadius: BorderRadius.circular(12), 
                                border: Border.all(
                                  width: 1, 
                                  color: cGrey),
                                ),
                            ) :  Container(
                              height: 90,
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(imageTwo!.path),
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                )
                              )
                            )
                          ),
                            SizedBox(width: 20),
      
                          
                          //third add image button
                            InkWell(
                            onTap: () {
                              selectImageThree(context);
                            },
                            child: imageThree == null ? Container(
                              height: 90,
                              width: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/addimage.png")
                                ),
                                color: Colors.transparent, 
                                borderRadius: BorderRadius.circular(12), 
                                border: Border.all(
                                  width: 1, 
                                  color: cGrey),
                                ),
                            ) :  Container(
                              height: 90,
                              width: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.file(
                                  File(imageThree!.path),
                                  fit: BoxFit.cover,
                                  width: 90,
                                  height: 90,
                                )
                              )
                            )
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
                          category = value;
                        });
                      },
                      value: category,
                      items: myCategory.map((items) {
                        return DropdownMenuItem(value: items, child: Text(items));
                      }).toList()),
                  ),
                ) 
              ),
            ),
            SizedBox(height: 5),
      
          //Checkboxes for field posting
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
                      validator: (val) => val!.isEmpty ? 'Please Input Product Name' : null, 
                      controller: nameController,
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
                      validator: (val) => val!.isEmpty ? 'Please Input Product Description' : null, 
                      controller: descriptionController,
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
          
          //Item weight dropdown and dropdown for variation
          Column(
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                child: Container(
                  width: double.infinity,
                  child: Text("Item Weight",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: cBlack,
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                    child: Container(
                      width: 230,
                      child: TextFormField(
                        validator: (val) => val!.isEmpty ? 'Please Input Item Weight' : null, 
                        controller: weightCountController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6),
                          borderSide: BorderSide(color: cGrey, width: 1.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cGrey, width: 1.0),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          hintText: "Input Item Weight",
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
                  ),
                  //dropdown for weight variation
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(12, 5, 0, 0),
                    child: Container(
                      child: DropdownButtonHideUnderline(
                        child: Container(
                          height: 49,
                          width: 120,
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                            color: cWhite,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: cGrey, width: 1.0)
                            ),
                          child: DropdownButton(
                            hint: Text("weight", style: inputBodyText.copyWith(color: Colors.black87)),
                            dropdownColor: cWhite,
                            icon: Icon(Icons.arrow_drop_down_circle_outlined, color: cGrey, size: 23),
                            style: inputBodyText.copyWith(color: Colors.black87),
                            onChanged: (value) {
                              setState(() {
                                weight = value;
                              });
                            },
                            value: weight,
                            items: weightVar.map((items) {
                              return DropdownMenuItem(value: items, child: Text(items));
                            }).toList()),
                        ),
                      ),
                    ),
                  ) 
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
      
           //stockCount Count 
            Container(
              width: double.infinity,
              height: 90,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(15, 5, 0, 0),
                    child: Text("Stock",
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
                      validator: (val) => val!.isEmpty ? 'Please Input Stock Number' : null, 
                      controller: stockCountController,
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
            
            //price Price
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
                      validator: (val) => val!.isEmpty ? 'Please Input Price' : null, 
                      controller: priceController,
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
            SizedBox(height: 10)
          ],
        ),
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
                  Navigator.pushNamed(context, '/userprofileseller');
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
    String formattedAddress = '${placemark.thoroughfare}, ${placemark.locality}, ${placemark.country}';
    locationController.text = formattedAddress;
  }

}




