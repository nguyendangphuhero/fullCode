import 'package:flutter/material.dart';
import 'package:app_drawer/screens/dashboard.dart';
import 'package:app_drawer/screens/drawer.dart';
import 'package:app_drawer/utilis/constants.dart' as Constants;

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}
// sau khi dang nhap ok thi vo day
class HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  HomeScreenState({this.tabController});

  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  @override
  Widget build(BuildContext context) {
    var app = Scaffold(
      appBar: AppBar(
        title: Text('Dashboard',style: TextStyle(color: textColor),),
        backgroundColor: secColor,
        iconTheme: IconThemeData(color: mainColor),
        bottom: TabBar(
          controller: tabController,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.dashboard,color: Colors.black54,),),
            Tab(icon: Icon(Icons.assessment, color: Colors.black54,), text: 'Amount Product',)
          ],
        ),
      ),
      drawer: MyDrawer(),
      // Dash board
      body: Dashboard(tabController),
    );
    return app;
  }
}