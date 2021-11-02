import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final bool isFavorite;
  final double leftPosition;
  final double topPosition;
  final double heightofBox;
  final double widthValue;

  const ProductCard(
      {Key? key,
      required this.product,
      this.widthFactor = 2.5,
      this.isFavorite = false,
      this.leftPosition = 5,
      this.topPosition = 120,
      this.heightofBox = 80,
      this.widthValue = 157})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/product', arguments: product);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Container(
              decoration: BoxDecoration(),
              width: MediaQuery.of(context).size.width / widthFactor,
              height: 200,
              child: Image.network(product.imageUrlOne, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: topPosition,
            left: leftPosition - 5,
            child: Container(
              width: widthValue,
              height: heightofBox,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(1, 1),
                        blurRadius: 10,
                        color: cBlack.withOpacity(0.10)),
                  ],
                  color: cWhite),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: TextStyle(
                                color: cGreen,
                                fontSize: 15,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '\₱${product.price}',
                            style: TextStyle(
                                color: Colors.black26,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if(state is BasketLoading) {
                          return Center(child: Text("sshh"));
                        }
                        if(state is BasketLoaded) {
                          return Expanded(
                          child: IconButton(
                              onPressed: () {
                                context
                                    .read<BasketBloc>()
                                    .add(BasketProductAdded(product));

                                    final snackBar = SnackBar(
                                          content: Text(
                                              "Item was added to your Basket!"));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(snackBar);
                              },
                              icon: Icon(Icons.add_circle_outline_rounded,
                                  color: cGreen)),
                        );
                        } else{return Text("soreh");}
                      },
                    ),
                    isFavorite
                        ? BlocBuilder<FavoritesBloc, FavoritesState>(
                            builder: (context, state) {
                              return Expanded(
                                child: IconButton(
                                    onPressed: () {
                                      context
                                          .read<FavoritesBloc>()
                                          .add(RemoveFavoritesProduct(product));

                                      final snackBar = SnackBar(
                                          content: Text(
                                              "Item was removed to your Favorites!"));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    icon: Icon(Icons.delete_outline_rounded,
                                        color: cGreen)),
                              );
                            },
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
