import 'package:croptivate_app/pallete.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({ Key? key }) : super(key: key);

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
  static const String routeName = '/notifications';
  static Route route() {
  return MaterialPageRoute(
    settings: RouteSettings(name: routeName),
    builder: (_) => NotificationsPage());
  }
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        backgroundColor: cGreen,
      )
    );
  }
}