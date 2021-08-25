import 'dart:math';

import 'package:app_drawer/models/categorymodel.dart';
import 'package:app_drawer/screens/drawer.dart';
import 'package:app_drawer/screens/subcategory.dart';
import 'package:app_drawer/services/categoryrepo.dart';
import 'package:flutter/material.dart';
import 'package:app_drawer/utilis/constants.dart' as Constants;
import 'dart:developer';

class Category extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CategoryState();
  }
}

class CategoryState extends State<Category> {
  List<CategoryModel> categoryModel = List<CategoryModel>();

  @override
  void initState() {

    categoryGet().then((data) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> categoryGet() async {
    categoryModel = await CategoryService().getAllCategoryData();
  }

  Color mainColor = Constants.mainColor;
  Color secColor = Constants.secTextColor;
  Color textColor = Constants.textColor;
  Color btnColor = Constants.btnColor;
  @override
  Widget build(BuildContext context) {
    var app = Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Categories',
          style: TextStyle(color: textColor),
        ),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: secColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: secColor, size: 30.0),
        onPressed: () {
          Navigator.of(context).pushNamed('/addCat');
        },
        tooltip: 'Add new Category',

      ),
      drawer: MyDrawer(),
      body: getCategoryList(),
    );
    return app;
  }

  ListView getCategoryList() {

    var app = ListView.builder(
        itemCount: categoryModel.length == null ? 0 : 1,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 70.0,
            margin: EdgeInsets.all(10.0),
            child: InkWell(
              onTap: () {
                debugPrint(categoryModel[index].sub_category.length.toString());
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SubCategory(subcategoryModel:categoryModel[index].sub_category, categoryid: categoryModel[index].category_id,);
                }));
              },
              child: ListTile(
                contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                leading: CircleAvatar(
                    backgroundColor: Constants.btnColor,
                    radius: 23.0,
                    child: Text(getTitle(categoryModel[2].name), style: TextStyle(color: Colors.white))),
                title: Text(categoryModel[2].name),
                subtitle: Text(categoryModel[2].description),
                trailing: Icon(Icons.arrow_forward_ios),
              ),
            ),
          );
        });
    return app;
  }

  String getTitle(String title) {
    var result = "";
    return result = title.substring(0, 2);
  }
}
