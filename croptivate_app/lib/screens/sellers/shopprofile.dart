import 'package:croptivate_app/blocs/product/product_bloc.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/productcarousel.dart';
import 'package:croptivate_app/widgets/sectiontitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerShop extends StatelessWidget {
  final type;
  final firstname;
  final lastname;
  final location;
  final contactnumber;
  final profilepic;
  final shopname;
  final sellerType;
  final uid;

  const SellerShop({
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

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cGreen,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: cWhite,
            size: 15,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.2,
              child: Stack(children: [
                Container(
                    height: size.height * 0.2 - 27,
                    decoration: BoxDecoration(
                        color: cGreen,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(36),
                          bottomRight: Radius.circular(36),
                        )),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Padding(
                          //   padding: EdgeInsets.symmetric(horizontal: 15),
                          //   child: CircleAvatar(
                          //     backgroundColor: cWhite
                          //   ),
                          // ),
                          Flexible(
                            child: Text(
                              "Welcome to " + shopname + '!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  color: cWhite,
                                  fontWeight: FontWeight.w800),
                            ),
                          )
                        ],
                      ),
                    )),
                Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          height: 50,
                          decoration: BoxDecoration(
                              color: cWhite,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(0, 5),
                                    blurRadius: 50,
                                    color: cGrey.withOpacity(0.23))
                              ]),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: TextField(
                              decoration: InputDecoration(
                                  hintText: "What are you looking for?",
                                  hintStyle:
                                      hintBodyText.copyWith(fontSize: 12),
                                  enabledBorder: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  suffixIcon: Icon(
                                    Icons.search_rounded,
                                    color: cGreen,
                                  ))),
                        ),
                      ],
                    ))
              ]),
            ),

            // Padding(
            //   padding: EdgeInsets.only(top: 20),
            //   child: Container(
            //     child: Text(
            //       "Welcome to \$ShopName!",
            //       style: TextStyle(
            //         fontFamily: 'Poppins',
            //         fontSize: 22,
            //         color: cDGreen,
            //         fontWeight: FontWeight.w800
            //       ),
            //     )
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: cGreen,
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                      child: Text(
                    "Shop Information",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: cBlack,
                        fontWeight: FontWeight.normal),
                  )),
                  SizedBox(width: 160),
                  Container(
                      child: TextButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                      title: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Shop Name",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w700,
                                                color: cBrown)),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_outlined,
                                                color: cGreen),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Shop Address",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.access_time_rounded,
                                                color: cGreen),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Opening Times",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cBlack)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: SimpleDialogOption(
                                            child: Text("Close",
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w700,
                                                    color: cGreen)),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ),
                                        SizedBox(height: 10)
                                      ],
                                    ),
                                  )
                                      // title: Column(
                                      //   crossAxisAlignment: CrossAxisAlignment.start,
                                      //   children: [
                                      //     Padding(
                                      //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                      //       child: Text(
                                      //       "Shop Name",
                                      //         style: TextStyle(
                                      //           fontFamily: 'Poppins',
                                      //           fontSize: 30,
                                      //           fontWeight: FontWeight.w700,
                                      //           color: cDGreen
                                      //         ),
                                      //       ),
                                      //     ),
                                      //     SizedBox(height: 50,),
                                      //     Padding(
                                      //       padding: EdgeInsets.symmetric( horizontal: 15),
                                      //       child: Row(
                                      //         children: [
                                      //           Icon(Icons.location_on_outlined,
                                      //           color: cGreen),
                                      //           SizedBox(width: 10,),
                                      //           Text(
                                      //             "Shop Address",
                                      //             style: TextStyle(
                                      //               fontFamily: 'Poppins',
                                      //               fontSize: 20,
                                      //               fontWeight: FontWeight.w500,
                                      //               color: cBlack
                                      //             ),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),

                                      //     Padding(
                                      //       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                                      //       child: Row(
                                      //         children: [
                                      //           Icon(Icons.access_time_rounded,
                                      //           color: cGreen),
                                      //           SizedBox(width: 10,),
                                      //           Text(
                                      //             "Opening Times",
                                      //             style: TextStyle(
                                      //               fontFamily: 'Poppins',
                                      //               fontSize: 20,
                                      //               fontWeight: FontWeight.w500,
                                      //               color: cBlack
                                      //             ),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //   ],
                                      // )
                                      );
                                });
                          },
                          child: Text(
                            "View",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                color: cGreen,
                                fontWeight: FontWeight.normal),
                          )))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SectionTitle(title: "All Vegetable Products"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: cGreen,
                  ));
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                      products: state.products
                          .where((product) => product.ownerId == uid)
                          .toList());
                } else {
                  return Text("Sorry");
                }
              },
            ),

            SectionTitle(title: "Plant Vegetables"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: cGreen,
                  ));
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                      products: state.products
                          .where((product) =>
                              product.category == "Plant Vegetables")
                          .where((product) => product.ownerId == uid)
                          .toList());
                } else {
                  return Text("Sorry");
                }
              },
            ),

            SectionTitle(title: "Climbers and Creepers"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: cGreen,
                  ));
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                      products: state.products
                          .where((product) =>
                              product.category == "Climbers and Creepers")
                          .where((product) => product.ownerId == uid)
                          .toList());
                } else {
                  return Text("Sorry");
                }
              },
            ),

            SectionTitle(title: "Leafy Vegetables"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: cGreen,
                  ));
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                      products: state.products
                          .where((product) =>
                              product.category == "Leafy Vegetables")
                          .where((product) => product.ownerId == uid)
                          .toList());
                } else {
                  return Text("Sorry");
                }
              },
            ),

            SectionTitle(title: "Root Vegetables"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: cGreen,
                  ));
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                      products: state.products
                          .where((product) =>
                              product.category == "Root Vegetables")
                          .where((product) => product.ownerId == uid)
                          .toList());
                } else {
                  return Text("Sorry");
                }
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
