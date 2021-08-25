import 'package:flutter/material.dart';
import 'package:app_drawer/screens/home_users.dart';
import 'dart:developer';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AppUser extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}
//phan tren nut cong
class _AppState extends State<AppUser> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: Scaffold(
        // Phan duoi Nut Cong
        body: HomeUser(),

      ),
    );
  }
}
