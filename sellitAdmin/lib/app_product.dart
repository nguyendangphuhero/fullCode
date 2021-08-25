import 'package:flutter/material.dart';
import 'package:app_drawer/screens/formadd_product.dart';
import 'package:app_drawer/screens/home_product.dart';
import 'dart:developer';

GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class AppProduct extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}
//phan tren nut cong
class _AppState extends State<AppProduct> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.orange,
        accentColor: Colors.orangeAccent,
      ),
      home: Scaffold(
        key: _scaffoldState,
        appBar: AppBar(
          title: Text(
            "Products",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              // Nut cong
              onTap: () async {
                var result = await Navigator.push(
                  _scaffoldState.currentContext,
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FormAddProduct();
                  }),
                );
                if (result != null) {
                  setState(() {});
                }
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        // Phan duoi Nut Cong
        body: HomeProduct(),

      ),
    );
  }
}
