import 'package:croptivate_app/blocs/product/product_bloc.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/productcarousel.dart';
import 'package:croptivate_app/widgets/sectiontitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SellerShop extends StatelessWidget {
  

  static const String routeName = '/shopprofile';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => SellerShop());
  }


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
              child: Stack(
                children: [
                  Container(
                  height: size.height * 0.2 - 27,
                    decoration: BoxDecoration(
                      color: cGreen,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(36),
                        bottomRight: Radius.circular(36),
                      )
                    ) ,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: CircleAvatar(
                            backgroundColor: cWhite
                          ),
                        ),
                        Text("Hi, I'm \$Seller's Name!",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 26,
                            color: cWhite,
                            fontWeight: FontWeight.w800
                          ),
                        )
                      ],
                    )       
                  ),
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
                                color: cGrey.withOpacity(0.23)
                              )
                            ]
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                            child: TextField(
                            decoration: InputDecoration(
                              hintText: "What are you looking for?",
                              hintStyle: hintBodyText.copyWith(fontSize: 12),
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                suffixIcon: Icon(Icons.search_rounded, color: cGreen,)
                            )
                          ),
                        ),
                      ],
                    )
                  )
                ] 
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                child: Text(
                  "Welcome to \$ShopName!",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 22,
                    color: cDGreen,
                    fontWeight: FontWeight.w800
                  ),
                )
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.info_outline_rounded, 
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
                        fontWeight: FontWeight.normal
                      ),
                    )
                  ),
                  SizedBox(width: 160),
                  Container(
                    child: TextButton(
                      onPressed: () {}, 
                      child: Text(
                        "View",
                          style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: cGreen,
                          fontWeight: FontWeight.normal
                        ),
                      )
                    )
                  )
                ],
              ),
            ),
            SizedBox(height: 10,),
            SectionTitle(title: "Deals of the Day"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: cGreen,
                    )
                  );
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products: state.products
                        .where((product) => product.isDeals)
                        .toList());
                }
                
                else {
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
                    )
                  );
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products: state.products
                        .where((product) => product.category == "Plant Vegetables")
                        .toList());
                }
                
                else {
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
                    )
                  );
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products: state.products
                        .where((product) => product.category == "Climbers and Creepers")
                        .toList());
                }
                
                else {
                  return Text("Sorry");
                }
              },
            ),

            SectionTitle(title: "Leaf Vegetables"),
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: cGreen,
                    )
                  );
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products: state.products
                        .where((product) => product.category == "Leaf Vegetables")
                        .toList());
                }
                
                else {
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
                    )
                  );
                }

                if (state is ProductLoaded) {
                  return ProductCarousel(
                    products: state.products
                        .where((product) => product.category == "Root Vegetables")
                        .toList());
                }
                
                else {
                  return Text("Sorry");
                }
              },
            ),
          ],
        ),
      )
    );
  }
}