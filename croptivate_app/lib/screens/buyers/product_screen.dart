import 'package:carousel_slider/carousel_slider.dart';
import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
import 'package:croptivate_app/blocs/product/product_bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/herocarouselcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatelessWidget {
  static const String routeName = '/product';

  static Route route({required Product product}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => ProductScreen(product: product));
  }

  final Product product;
  const ProductScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cWhite,
        appBar: AppBar(
            backgroundColor: cWhite,
            elevation: 0,
            title: Text(
              product.name,
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
            actions: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/favorites');
                  },
                  icon: Icon(Icons.favorite_border_rounded),
                  color: cGreen)
            ]),
        bottomNavigationBar: Container(
            padding: EdgeInsets.only(
              left: 0,
              right: 0,
              bottom: 10,
              top: 10,
            ),
            height: 65,
            decoration: BoxDecoration(color: cWhite, boxShadow: [
              BoxShadow(
                offset: Offset(1, 10),
                blurRadius: 35,
                color: cGrey.withOpacity(0.40),
              )
            ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    print("Messaging is pressed");
                  },
                  icon: Icon(
                    Icons.chat_bubble_outline_rounded,
                  ),
                ),
                BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        context
                            .read<FavoritesBloc>()
                            .add(AddFavoritesProduct(product));

                        final snackBar = SnackBar(
                            content: Text("Added to your Favorites!"),
                            duration: Duration(seconds: 1, milliseconds: 100));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      icon: Icon(
                        Icons.favorite_rounded,
                        color: cGreen,
                      ),
                    );
                  },
                ),
                BlocBuilder<BasketBloc, BasketState>(
                  builder: (context, state) {
                    return ElevatedButton(
                        style: ElevatedButton.styleFrom(primary: cGreen),
                        onPressed: () {
                          context
                              .read<BasketBloc>()
                              .add(BasketProductAdded(product));

                          Navigator.pushNamed(context, '/basket');
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Text("ADD TO BASKET",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold)),
                        ));
                  },
                )
              ],
            )),
        body: ListView(children: [
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
                return CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 1.5,
                    viewportFraction: 0.9,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(product.imageUrlOne, fit: BoxFit.cover, width: 1000,),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.network(product.imageUrlTwo, fit: BoxFit.cover, width: 1000,),
                              Positioned(
                                bottom: 0.0,
                                left: 0.0,
                                right: 0.0,
                                child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(200, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0)
                                    ],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                  ),
                                ),
                              padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: Stack(
                          children: <Widget>[
                            Image.network(product.imageUrlThree, fit: BoxFit.cover, width: 1000,),
                            Positioned(
                              bottom: 0.0,
                              left: 0.0,
                              right: 0.0,
                              child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                            padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                            ),
                          )
                        ],
                      ),
                    ),
                    )
                  ]
                );
              }

              else  {
                return Text("Sorry");
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                    ),
                    child: Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.name,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 25,
                                  color: cBrown,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                            '${product.weightCount} ${product.weight}',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.black26,
                                fontSize: 13,
                                fontWeight: FontWeight.w700),
                            ),
                            Text(
                              'Stock: ${product.stockCount}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: cBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Loc:Makati City, Philippines",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: cBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 95),
                        Text(
                          '\₱${product.price}',
                          style: TextStyle(fontSize: 25, color: cBlack),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
            ),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: CircleAvatar(
                  backgroundColor: cGreen,
                ),
              ),
              Container(
                child: Text(
                  "Profile Name",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: cBlack
                  )
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(start: 125),
                child: Container(
                  height: 33,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: cGrey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(6)
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/shopprofile');
                    },
                    child: Text(
                      "View Shop",
                      style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      color: cGreen
                      )
                    ),
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              thickness: 1,
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpansionTile(
              initiallyExpanded: true,
              collapsedIconColor: cGreen,
              iconColor: cGreen,
              title: Text(
                "Product Information",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  color: cGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                ListTile(
                  title: Text(
                    product.description,
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black54),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 20),
          //   child: ExpansionTile(
          //     initiallyExpanded: false,
          //     collapsedIconColor: cGreen,
          //     iconColor: cGreen,
          //     title: Text(
          //       "Delivery Information",
          //       textAlign: TextAlign.justify,
          //       style: TextStyle(
          //         fontFamily: 'Poppins',
          //         fontSize: 20,
          //         color: cGreen,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //     children: [
          //       ListTile(
          //         title: Text(
          //           "These are the recommended delivery options suited for your purchase. Arrangement of delivery schedule can be done by either of the parties involved (seller/buyer), depending on what has been agreed on:\nGrab\nLalamove\nMr. Speedy\nToktok\n\nName: Camille Abi Enzo\nLocation: Cembo, Makati City\nContact Number: 0917xxx",
          //           style: TextStyle(
          //               fontFamily: 'Poppins',
          //               fontSize: 14,
          //               color: Colors.black54),
          //         ),
          //       )
          //     ],
          //   ),
          // )
        ]));
  }
}
