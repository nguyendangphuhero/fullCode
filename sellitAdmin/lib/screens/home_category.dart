import 'dart:developer';
import 'package:app_drawer/utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:app_drawer/models/category.dart';
import 'package:app_drawer/services/category_api.dart';
import 'package:app_drawer/screens/form_add.dart';
//phan duoi nut cong

class HomeCategory extends StatefulWidget {
  @override
  _HomeCategoryState createState() => _HomeCategoryState();

}
class _HomeCategoryState extends State<HomeCategory> {
  BuildContext context;
  ApiCategory apiService;
  @override
  void initState() {
    super.initState();
    apiService = ApiCategory();
  }
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        //lay tat ca category, get duoc roi nek
        //tra ve 1 list category
        future: apiService.getCategories(),
        builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          //log('$snapshot');
          if (snapshot.hasError) {
            return Center(
              // dinh loi o day roi
              child: Text("Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Category> categories = snapshot.data;
            //log(categories.toString());
            // xuong ham buiListView
            // Loi bi dinh profile
            //log(categories.toString());
            return _buildListView(categories);
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

  Widget _buildListView(List<Category> categories) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Category category = categories[index];
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
                      category.category,
                      style: Theme.of(context).textTheme.title,
                    ),
                    //hien thi category o duoi

                    //Text(category.category),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Warning"),
                                    content: Text("Are you sure want to delete ${category.category}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService.deleteCategory(category.id).then((isSuccess) {
                                            //log(category.id);
                                            //null
                                            //log(category.category.toString());
                                            // Tables
                                            //log(isSuccess.toString());
                                            if (isSuccess) {
                                              setState(() {});
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(content: Text("Delete data success")));
                                            } else {
                                              Scaffold.of(this.context)
                                                  .showSnackBar(SnackBar(content: Text("Delete data failed")));
                                            }
                                          });
                                        },
                                      ),
                                      FlatButton(
                                        child: Text("No"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                        FlatButton(
                          onPressed: () async {
                            var result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return FormAddCategory(category: category);
                            }));
                            if (result != null) {
                              setState(() {});
                            }
                          },
                          child: Text(
                            "Edit ",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: categories.length,
      ),
    );
  }
}
