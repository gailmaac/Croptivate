import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/blocs/basketdata/basketdata_bloc.dart';
import 'package:croptivate_app/blocs/category/category_bloc.dart';
import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
import 'package:croptivate_app/blocs/product/product_bloc.dart';
import 'package:croptivate_app/config/app_router.dart';
import 'package:croptivate_app/models/user.dart';
import 'package:croptivate_app/repository/basket/basketdata_repository.dart';
import 'package:croptivate_app/repository/category/category_repository.dart';
import 'package:croptivate_app/repository/product/product_repository.dart';
import 'package:croptivate_app/screens/splashscreen.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp());
}

class SimpleBlocObserver extends BlocObserver {
  void onChange(BlocBase BasketBloc, Change BasketChange) {
    super.onChange(BasketBloc, BasketChange);
    if (BasketBloc is Cubit) print(BasketChange);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => FavoritesBloc()..add(StartFavorites())),
          BlocProvider(create: (_) => BasketBloc()..add(BasketStarted())),
          BlocProvider(
              create: (context) => BasketdataBloc(
                  basketBloc: context.read<BasketBloc>(),
                  basketDataRepository: BasketDataRepository())),
          BlocProvider(
            create: (_) => CategoryBloc(
              categoryRepository: CategoryRepository(),
            )..add(LoadCategories()),
          ),
          BlocProvider(
              create: (_) => ProductBloc(
                    productRepository: ProductRepository(),
                  )..add(LoadProducts())),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: Wrapper(),

          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
          // initialRoute: SplashScreen.routeName,

          // routes: {
          //   'ForgotPassword' : (context) => ForgotPassword(),
          //   'AccountCategories' : (context) => AccountCategories(),
          //   'RegisterSeller' : (context) => RegisterSeller(),
          //   'RegisterBuyer' : (context) => RegisterBuyer(),
          //   'RegisterTransporter' : (context) => RegisterTransporter(),
          //   UserProfile.route: (context) => UserProfile(),
          //   HomeSeller.route: (context) => HomeSeller(),
          //   // HomeBuyer.route: (context) => HomeBuyer(),
          // },
        ),
      ),
    );
  }
}
