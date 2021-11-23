import 'package:croptivate_app/blocs/product/product_bloc.dart';
import 'package:croptivate_app/models/category.dart';
import 'package:croptivate_app/pallete.dart';
import 'package:croptivate_app/widgets/bottomnavbar.dart';
import 'package:croptivate_app/widgets/productwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogScreen extends StatelessWidget {
  static const String routeName = '/catalog';

  static Route route({required Category category}) {
    return MaterialPageRoute(
        settings: RouteSettings(name: routeName),
        builder: (_) => CatalogScreen(category: category));
  }

  final Category category;
  const CatalogScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: cWhite,
        appBar: AppBar(
          backgroundColor: cWhite,
          elevation: 0,
          title: Text(
            category.name,
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
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: cGreen,
                )
              );
            }

            if (state is ProductLoaded) {
              return ProductWidget(
                products: state.products
                  .where((product) => product.category == category.name)
                  .toList());
            }

            else {
              return Text("Sorry");
            }
          },
        )
        );
  }
}

