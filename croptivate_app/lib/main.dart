import 'package:croptivate_app/blocs/basket/basket_bloc.dart';
import 'package:croptivate_app/blocs/favorites/favorites_bloc.dart';
import 'package:croptivate_app/config/app_router.dart';
import 'package:croptivate_app/models/user.dart';
import 'package:croptivate_app/screens/authentication/sign_in.dart';
import 'package:croptivate_app/screens/wrapper.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          // home: Wrapper(),

          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SignIn.routeName,

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
