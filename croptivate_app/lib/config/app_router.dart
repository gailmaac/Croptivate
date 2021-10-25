import 'package:croptivate_app/models/category.dart';
import 'package:croptivate_app/models/product_model.dart';
import 'package:croptivate_app/screens/authentication/account_categories.dart';
import 'package:croptivate_app/screens/authentication/forgot_password.dart';
import 'package:croptivate_app/screens/authentication/register_buyer.dart';
import 'package:croptivate_app/screens/authentication/register_seller.dart';
import 'package:croptivate_app/screens/authentication/sign_in.dart';
import 'package:croptivate_app/screens/buyers/basket.dart';
import 'package:croptivate_app/screens/buyers/catalog.dart';
import 'package:croptivate_app/screens/buyers/favorites.dart';
import 'package:croptivate_app/screens/buyers/home_buyer.dart';
import 'package:croptivate_app/screens/buyers/product_screen.dart';
import 'package:croptivate_app/screens/sellers/notifications.dart';
import 'package:croptivate_app/screens/sellers/product_listings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('This is route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return SignIn.route();
      case HomeBuyer.routeName:
        return HomeBuyer.route();
      case RegisterBuyer.routeName:
        return RegisterBuyer.route();
      case RegisterSeller.routeName:
        return RegisterSeller.route();
      case BasketScreen.routeName:
        return BasketScreen.route();
      case AccountCategories.routeName:
        return AccountCategories.route();
      case ForgotPassword.routeName:
        return ForgotPassword.route();
      case Favorites.routeName:
        return Favorites.route();
      case ProductPage.routeName:
        return ProductPage.route();
      case NotificationsPage.routeName:
        return NotificationsPage.route();
      case CatalogScreen.routeName:
        return CatalogScreen.route(category: settings.arguments as Category);
      case ProductScreen.routeName:
        return ProductScreen.route(product: settings.arguments as Product);

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: Text("Error")
        )
      )
    );
  }
}