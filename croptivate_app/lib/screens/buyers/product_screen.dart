import 'package:carousel_slider/carousel_slider.dart';
import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
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

                        final snackBar =
                            SnackBar(content: Text("Added to you Favorites!"));
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

                          
                          final snackBar =
                            SnackBar(content: Text("Added to your Basket!"));
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
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
          CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 1.5,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
            ),
            items: [
              HeroCarouselCard(
                product: product,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                              'Stocks: ${product.stockCount}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: cBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              product.location,
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  color: cBlack,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(width: 105),
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
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Turpis in eu mi bibendum neque. Risus at ultrices mi tempus imperdiet nulla malesuada pellentesque elit.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black38),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ExpansionTile(
              initiallyExpanded: false,
              collapsedIconColor: cGreen,
              iconColor: cGreen,
              title: Text(
                "Delivery Information",
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
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Turpis in eu mi bibendum neque. Risus at ultrices mi tempus imperdiet nulla malesuada pellentesque elit.",
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        color: Colors.black38),
                  ),
                )
              ],
            ),
          )
        ]));
  }
}
