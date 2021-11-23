import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/screens/buyers/home_buyer.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/productcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Favorites extends StatefulWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  _FavoritesState createState() => _FavoritesState();

  static const String routeName = '/favorites';
  static Route route() {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName), builder: (_) => Favorites());
  }
}

class _FavoritesState extends State<Favorites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
        backgroundColor: cWhite,
        elevation: 0,
        title: Text(
          "Favorites",
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
      bottomNavigationBar: BottomNavBar(),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          print("State: $state");
          if (state is FavoritesLoading) {
            return Center(
              child: CircularProgressIndicator(color: cGreen,),
            );
          }
          if (state is FavoritesLoaded) {
            return GridView.builder(
              padding: const EdgeInsets.symmetric(
                  horizontal: 0.95, vertical: 16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1, childAspectRatio: 2.4),
              itemCount: state.favorites.products.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ProductCard(
                      product: state.favorites.products[index],
                      widthFactor: 1.1,
                      leftPosition: 150,
                      topPosition: 60,
                      heightofBox: 75,
                      widthValue: 200,
                      isFavorite: true,
                    ),
                  ),
                );
              },
            );
          }
          else {return Text("Something went wrong.");}
        },
      )
    );
  }
}

// body: BlocBuilder<FavoritesBloc, FavoritesState>(
//           builder: (context, state) {
//             if (state is FavoritesLoading) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }

//             if (state is FavoritesLoaded) {
//               return GridView.builder(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 0.95, 
//                   vertical: 16.0),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, childAspectRatio: 2.4), 
//                 itemCount: state.favorites.products.length,
//                 itemBuilder: (BuildContext context, int index){
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Center(
//                       child: ProductCard(
//                         product: state.favorites.products[index],
//                         widthFactor: 1.1,
//                         isFavorite: true,
//                         leftPosition: 150,
//                         topPosition: 75,
//                         heightofBox: 60,
//                         widthValue: 200,
//                       ),
//                     ),
//                   );
//                 }
//               );
//               }
//               else {
//                 return Text("Something went wrong.");
//               }
//           }  
//         )