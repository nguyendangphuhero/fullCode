import 'dart:developer';
import 'package:app_drawer/utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:app_drawer/models/user.dart';
import 'package:app_drawer/services/user_api.dart';
//phan duoi nut cong

class HomeUser extends StatefulWidget {
  @override
  _HomeUserState createState() => _HomeUserState();

}
class _HomeUserState extends State<HomeUser> {
  BuildContext context;
  ApiUser apiService;
  @override
  void initState() {
    super.initState();
    apiService = ApiUser();
  }
  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "List Users",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body : FutureBuilder(
        //lay tat ca category, get duoc roi nek
        //tra ve 1 list category
        future: apiService.getUsers(),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
          //log('$snapshot');
          if (snapshot.hasError) {
            return Center(

              // dinh loi o day roi
              child: Text("Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<User> users = snapshot.data;
            //log(categories.toString());
            // xuong ham buiListView
            // Loi bi dinh profile
            //log(categories.toString());
            return _buildListView(users);
          } else {
            return Center(

              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  //hien thi tat ca category va co them nut edit voi delete

  Widget _buildListView(List<User> users) {

    return Padding(

      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),

      child: ListView.builder(

        itemBuilder: (context, index) {
          User user = users[index];
          //vi rang log o day k dc-> do han 2 thu vien
          //log(category.toString());

          return Padding(
            padding: const EdgeInsets.only(top: 8.0),

            child: Card(

              child: Padding(

                padding: const EdgeInsets.all(16.0),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(
                      "Email: "+user.email,
                      style: Theme.of(context).textTheme.title,
                    ),
                    //hien thi category o duoi

                    Text("Username: "+user.name),

                  ],
                ),
              ),
            ),
          );
        },
        itemCount: users.length,
      ),
    );
  }
}
