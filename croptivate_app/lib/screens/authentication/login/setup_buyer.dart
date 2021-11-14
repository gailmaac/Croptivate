import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:croptivate_app/shared/loading.dart';
import 'package:croptivate_app/widgets/backgroundimage.dart';
import 'package:croptivate_app/widgets/heading_account.dart';
import 'package:croptivate_app/widgets/subtext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class SetUpBuyer extends StatefulWidget {
  const SetUpBuyer({ Key? key }) : super(key: key);

  @override
  _SetUpBuyerState createState() => _SetUpBuyerState();

  static const String routeName = '/setupbuyer';
  static Route route() {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => SetUpBuyer());
  }
}

class _SetUpBuyerState extends State<SetUpBuyer> {

  TextEditingController fname = new TextEditingController();
  TextEditingController lname = new TextEditingController();
  TextEditingController loc = new TextEditingController();
  TextEditingController cnum = new TextEditingController();

  final buyerPic = FirebaseStorage.instance.ref();
  final buyerInfo = FirebaseFirestore.instance.collection('userBuyer');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

    late PickedFile _accImage;
  final ImagePicker _picker = ImagePicker();
  dynamic _pickImageError;

  String buyerId = Uuid().v4();

  File ? accImage;
  set _accImageFile(XFile? value) {
    accImage = (value == null ? null : [value]) as File?;
  }

  uploadaccImage(accImage) async {
    UploadTask uploadImage = buyerPic.child("buyerImage_$buyerId.jpg").putFile(accImage);
    TaskSnapshot storageImage = await uploadImage;
    String downloadImage = await storageImage.ref.getDownloadURL();
    return downloadImage;
  }

  createBuyerProfile({
    String? accImageUrl,
    String? fname,
    String? lname,
    String? loc,
    int? cnum
  }) {
    buyerInfo
    .doc(_auth.currentUser!.uid)
    .set({
      "Profile Picture": accImageUrl,
      "first name": fname,
      "last name": lname,
      "location": loc,
      "contact number": cnum
    });
  }

  submitbuyerData() async {
    setState(() {
      loading = true;
    });
    String accImageUrl = await uploadaccImage(accImage);
    createBuyerProfile(
      accImageUrl: accImageUrl,
      fname: fname.text,
      lname: lname.text,
      loc: loc.text,
      cnum: int.parse(cnum.text),
    );
    fname.clear();
    lname.clear();
    loc.clear();
    cnum.clear();
    setState(() {
      loading = true;
      Navigator.pushNamed(context, '/homebuyer');
    });  
  }

  Future chooseImage(ImageSource source) async {

    try {
      final accImage = await ImagePicker().pickImage(source: source);
    if (accImage == null) return;

    final imageTemporary = File(accImage.path);
    setState(() => this.accImage = imageTemporary);
    } on PlatformException catch(error) {
      print("Failed to pick image: $error");
    }
  }

  selectImage(parentContext) {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20),
      child: Column(
        children: [
          Text("Choose Profile Picture",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 20,
              color: cBlack
            )
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  chooseImage(ImageSource.camera);
                  }, 
                icon: Icon(Icons.camera_alt_rounded, color: cGreen), 
                label: Text("Camera",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: cBlack
                  ),
                )
              ),
              SizedBox(width: 35,),
              TextButton.icon(
                onPressed: () {
                  chooseImage(ImageSource.gallery);
                  }, 
                icon: Icon(Icons.camera_alt_rounded, color: cGreen), 
                label: Text("Gallery",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    color: cBlack
                  ),
                )
              ),
            ],
          )
        ],
      )
    );
  }

  imageProfile() {
    return Stack(
      children: <Widget>[
        InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context, 
              builder: (builder) => selectImage(context));
          },
          child: accImage == null ? CircleAvatar(
            radius: 80.0,
            backgroundImage: AssetImage("assets/addpic.png"),
            backgroundColor: cWhite,
          ) : 
          CircleAvatar(
            radius: 80.0,
            child: ClipOval(
              child: Image.file(
                File(accImage!.path),
                fit: BoxFit.cover,
                width: 160.0,
                height: 160.0,
              )
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context, 
                builder: (builder) => selectImage(context));            
            },
            child: buildEditIcon()))
      ],
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

  String email = '';
  String password = '';
  String _fname = '';
  String _lname = '';
  String _loc = '';
  String _cnum = '';

  String error = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading ? Loading() : Stack(
      children: [
        BackgroundImage(image: "assets/vegetable4.jpg"),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    AppBar(backgroundColor: Colors.transparent,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                    ),
                    HeadingCreateAccount(acctype: "Welcome, Buyer!"),
                    SubText(),
                    SizedBox(height: 20),
                    imageProfile(),
                    SizedBox(height: 15),
                    
                    //First Name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: fname,
                            onChanged: (val) {
                                setState(() => _fname = val);
                              },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "First Name",
                              hintStyle: inputBodyText,
                            ),
                            style: cBodyText,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ),
                    ), 
                    
                    
                    //Last Name
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: lname,
                            onChanged: (val) {
                                setState(() => _lname = val);
                              },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Last Name",
                              hintStyle: inputBodyText,
                            ),
                            style: cBodyText,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ),
                    ), 
                    
                    //Location
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Container(
                              height: size.height * 0.06,
                              width: size.width * 0.75,
                              padding: EdgeInsets.only(left: 16, right: 16),
                              decoration: BoxDecoration(
                                color: Colors.grey[500]!.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: TextFormField(
                                  controller: loc,
                                  validator: (val) => val!.isEmpty ? 'Please enter your address' : null, 
                                  onChanged: (val) {
                                    setState(() => _loc = val);
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Complete Address",
                                    hintStyle: inputBodyText,
                                  ),
                                  style: cBodyText,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:10), 
                          //Location Button
                          Container(
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: cGreen
                            ),
                            child: IconButton(
                              onPressed: getLocation, 
                              icon: Icon(
                                Icons.location_pin,
                                color: cWhite
                              )
                            ) 
                          ),
                        ],
                      ),
                    
                    //Contact number
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Container(
                        height: size.height * 0.06,
                        width: size.width * 0.9,
                        padding: EdgeInsets.only(left: 16, right: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[500]!.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: cnum,
                            onChanged: (val) {
                                setState(() => _cnum = val);
                              },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contact Number",
                              hintStyle: inputBodyText,
                            ),
                            style: cBodyText,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                          ),
                        )
                      ),
                    ), 
                    
                    SizedBox(height:10),
                    Container(
                      height: size.height * 0.07,
                      width: size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: cGreen),
                      child: TextButton(
                        onPressed: loading ? null : () => submitbuyerData(),
                        child: Text(
                          "Sign Up",
                          style: cBodyText.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(height:20),

                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14)
                    ),
                  ],   
                ),
              ),
            ),
          ),
        ),
      ], 
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
    loc.text = formattedAddress;
  }
}