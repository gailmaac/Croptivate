import 'package:croptivate_app/models/category.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/screens/buyers/user_profile.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/productcard.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';
  
  static Route route({required Category category}) {
    return MaterialPageRoute(
      settings: RouteSettings(name: routeName),
      builder: (_) => CatalogScreen(category: category));
  }

  final Category category;
  const CatalogScreen({ required this.category });

  @override
  Widget build(BuildContext context) {
    final List<Product> categoryProducts = Product.products.where((product) => product.category == category.name).toList();
    return Scaffold(
      backgroundColor: cWhite,
      appBar: AppBar(
              backgroundColor: cWhite,
              elevation: 0,
              title: Text(category.name,
                  style: TextStyle(
                    color: cGreen,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  ),
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
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0, 
          vertical: 16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.8), 
        itemCount: categoryProducts.length,
        itemBuilder: (BuildContext context, int index){
          return Center(
            child: ProductCard(
              product: categoryProducts[index],
            ),
          );
        })
      // ProductCard(product: Product.products[0],),
    );
  }
}