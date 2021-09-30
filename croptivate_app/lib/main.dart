import 'package:croptivate_app/models/user.dart';
import 'package:croptivate_app/screens/authentication/account_categories.dart';
import 'package:croptivate_app/screens/authentication/register_buyer.dart';
import 'package:croptivate_app/screens/authentication/register_seller.dart';
import 'package:croptivate_app/screens/authentication/register_transporter.dart';
import 'package:croptivate_app/screens/home/forgot_password.dart';
import 'package:croptivate_app/screens/wrapper.dart';
import 'package:croptivate_app/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),

        routes: {
          'ForgotPassword' : (context) => ForgotPassword(),
          'AccountCategories' : (context) => AccountCategories(),
          'RegisterSeller' : (context) => RegisterSeller(),
          'RegisterBuyer' : (context) => RegisterBuyer(),
          'RegisterTransporter' : (context) => RegisterTransporter(),
        },
      ),
    );
  }
}

 