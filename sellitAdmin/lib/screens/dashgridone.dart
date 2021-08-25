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

class PieChartSample2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart2State();
}
//Add Proper amounts and percentages for Pie Chart
class PieChart2State extends State {
  Client client = Client();
  //get data day ne
  // DashboardModel dashboardModel = DashboardModel();
  var length;
  var lengthCategory;
  var lengthUser;
  @override
  void initState() {
    //get data day ne
    getCategories().then((data) {
      setState(() {});
    });
    getUsers().then((data) {
      setState(() {});
    });
    getProducts().then((data) {
      setState(() {});
    });


    super.initState();
  }
//get data day ne
//   Future<void> dashboardGet() async {
//     dashboardModel = await DashboardService().getAllDashboardData();
//   }
  Future<void> getProducts() async {
    var response = await client.get("http://192.168.1.10:3000/api/v1/products");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["products"];
      length = data.length;
    } else {
      return null;
    }
  }
  Future<void> getCategories() async {
    var response = await client.get("http://192.168.1.10:3000/api/v1/categories");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["categories"];
      lengthCategory = data.length;
      log(lengthCategory);
    } else {
      return null;
    }
  }
  Future<void> getUsers() async {
    var response = await client.get("http://192.168.1.10:3000/api/v1/users/get");
    if (response.statusCode == 200) {
      var jsonBody = response.body;
      var output = json.decode(jsonBody);
      var data = output["data"]["users"];
      lengthUser = data.length;
      log(lengthUser);
    } else {
      return null;
    }
  }

  int touchedIndex;

  @override
  Widget build(BuildContext context) {
    //log(lengthUser.toString());
    var app = AspectRatio(
      aspectRatio: 1.3,
      child: ListView(

        scrollDirection: Axis.vertical,
        children: <Widget>[
          Column(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Container(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                        pieTouchData:
                        PieTouchData(touchCallback: (pieTouchResponse) {
                          setState(() {
                            if (pieTouchResponse.touchInput is FlLongPressEnd ||
                                pieTouchResponse.touchInput is FlPanEnd) {
                              touchedIndex = -1;
                            } else {
                              touchedIndex = pieTouchResponse.touchedSectionIndex;
                            }
                          });
                        }),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 0,
                        centerSpaceRadius: 60,
                        sections: showingSections()),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 18,
                    ),

                    //1
                    Row(
                      children: <Widget>[
                        Icon(Icons.devices_other, size: 30.0, color: Constants.card2),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Text(
                          'Total of Product',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    //2
                    Row(
                      children: <Widget>[
                        Icon(Icons.category,
                            size: 30.0, color: Constants.card3),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Text(
                          'Total of Category',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    //3
                    Row(
                      children: <Widget>[
                        Icon(Icons.people, size: 30.0, color: Constants.card4),
                        Padding(
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Text(
                          'Total of  Users',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    //4


                    SizedBox(
                      height: 4,
                    ),

                    SizedBox(
                      height: 18,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),],
      ),
    );
    Widget progress() {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return  app;
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 25 : 16;
      final double radius = isTouched ? 100 : 80;
      switch (i) {
        //vang
        case 0:
          // xanh
          return PieChartSectionData(
            color: Constants.card2,
            value: 25,
            title: length.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Constants.card3,
            value: 15,
            title: lengthCategory.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Constants.card4,
            value: 15,
            title: lengthUser.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}