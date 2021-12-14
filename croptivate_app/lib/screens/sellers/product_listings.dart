import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:croptivate_app/blocs/product/product_bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/productcard.dart';
import 'package:croptivate_app/widgets/productlistcard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();

  static const String routeName = '/prodlistings';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => ProductPage());
  }
}

class _ProductPageState extends State<ProductPage> {
  int productcount = 0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cWhite,
        appBar: AppBar(
          backgroundColor: cWhite,
          elevation: 0,
          title: Text(
            "Your Listings",
            style: TextStyle(
                color: cGreen,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
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
        bottomNavigationBar: Container(
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
                    Navigator.pushNamed(context, '/message');
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
            )),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: cGreen,
                ),
              );
            }
            if (state is ProductLoaded) {
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                    horizontal: 0.95, vertical: 16.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1, childAspectRatio: 2.4),
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, int index) {
                  if (state.products[index].ownerId == _auth.currentUser!.uid) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: ProductListCard(
                          product: state.products[index],
                          widthFactor: 1.1,
                          leftPosition: 150,
                          topPosition: 70,
                          heightofBox: 70,
                          widthValue: 205,
                          isRemoved: true,
                        ),
                      ),
                    );
                  } else {
                    return Text('blank');
                  }
                },
              );
            } else {
              return Text("Something went wrong.");
            }
          },
        ));
  }
}
