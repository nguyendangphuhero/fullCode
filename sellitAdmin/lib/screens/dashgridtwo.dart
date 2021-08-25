// import 'package:app_drawer/models/dashboardmodel.dart';
// import 'package:app_drawer/services/dashboardrepo.dart';
import 'package:flutter/material.dart';
import 'package:app_drawer/utilis/constants.dart' as Constants;
import 'package:http/http.dart' show Client;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:app_drawer/models/dashboardmodel.dart';
import 'package:app_drawer/models/product.dart';
// import 'package:app_drawer/services/dashboardrepo.dart';
import 'package:app_drawer/services/product_api.dart';
import 'package:app_drawer/utilis/constants.dart' as Constants;
import 'package:app_drawer/models/category.dart';
import 'package:app_drawer/models/product.dart';
import 'package:http/http.dart' show Client;
import 'dart:developer';
import 'dart:convert';
import 'package:app_drawer/screens/login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// Phan Status
class Gridtwo extends StatefulWidget {
  TabController controller;
  Gridtwo({this.controller});
  //Gridone({Key key}) : super(key: key);
  @override
  _GridtwoState createState() => _GridtwoState();
}

class _GridtwoState extends State<Gridtwo> {
  Color textColor = Constants.textColor;
  Color card1 = Constants.card1;
  Color card2 = Constants.card2;
  Color card3 = Constants.card3;
  Color card4 = Constants.card4;
  Client client = Client();
  var lengthTables;
  var lengthDesk;
  var lengthBooksheft;
  var lengthBed;

  //DashboardModel dashboardModel = DashboardModel();

  @override
  void initState() {
    getLengthTables().then((data) {
      setState(() {});
    });
    getLengthDesk().then((data) {
      setState(() {});
    });
    getLengthBookShelf().then((data) {
      setState(() {});
    });
    getLengthBed().then((data) {
      setState(() {});
    });

    super.initState();
  }

  // Future<void> dashboardGet() async {
  //   dashboardModel = await DashboardService().getAllDashboardData();
  // }
  Future<void> getLengthTables() async {
    var response = await client.get("http://192.168.1.10:3000/api/v1/products/search/tables");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["result"];
      lengthTables = data.length;
    } else {
      return null;
    }
  }
  Future<void> getLengthDesk() async {
    var response = await client.get("http://192.168.1.10:3000/api/v1/products/search/desk");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["result"];
      lengthDesk = data.length;
    } else {
      return null;
    }
  }
  Future<void> getLengthBookShelf() async {
    var response = await client.get("http://192.168.1.10:3000/api/v1/products/search/BookShelf");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["result"];
      lengthBooksheft = data.length;
    } else {
      return null;
    }
  }
  Future<void> getLengthBed() async {
    var response = await client.get("http://192.168.1.10:3000/api/v1/products/search/Bed");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["result"];
      lengthBed = data.length;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var app = Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      children: <Widget>[
        //Card 1
        Card(
            color: Constants.card1,
            margin: EdgeInsets.only(
                left: 10.0, right: 5.0, top: 20.0, bottom: 20.0),
            elevation: 10.0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Align(
              alignment: Alignment.center,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      // child: Icon(Icons.add_shopping_cart,
                      //     size: 30.0, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Tables: ' + lengthTables.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )),
        // Card 2
        Card(
          color: Constants.card2,
          margin:
              EdgeInsets.only(left: 5.0, right: 10.0, top: 20.0, bottom: 20.0),
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Align(
              alignment: Alignment.center,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        // child: Icon(Icons.devices,
                        //     size: 30.0, color: Colors.white),
                      )),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Desk: ' + lengthDesk.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
        ),
        //Card 3
        Card(
          //margin: EdgeInsets.only(left: 40.0, top: 40.0, right: 40.0, bottom: 20.0),
          color: Constants.card3,
          margin:
              EdgeInsets.only(left: 10.0, right: 5.0, top: 10.0, bottom: 20.0),
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      // child: Icon(Icons.check_circle,
                      //     size: 30.0, color: Colors.white),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'BookSheft: ' +
                          lengthBooksheft.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
        ),
        //Card 4
        Card(
          //   margin: EdgeInsets.only(left: 40.0, top: 40.0, right: 40.0, bottom: 10.0),
          margin:
              EdgeInsets.only(left: 5.0, right: 10.0, top: 10.0, bottom: 20.0),
          color: card4,
          elevation: 10.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: Align(
              alignment: Alignment.center,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        // child: Icon(Icons.warning,
                        //     size: 30.0, color: Colors.white),
                      )),
                  Expanded(
                    flex: 5,
                    child: Text(
                      'Bed: ' +
                          lengthBed.toString(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              )),
        ),
      ],
    ));
    Widget progress() {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return app;
  }
}
