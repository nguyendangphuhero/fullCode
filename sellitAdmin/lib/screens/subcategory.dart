import 'dart:math';

import 'package:app_drawer/models/categorymodel.dart';
import 'package:app_drawer/screens/add_sub.dart';
import 'package:flutter/material.dart';
import 'package:app_drawer/utilis/constants.dart' as Constants;

class SubCategory extends StatefulWidget{
  final List<CategoryModel> subcategoryModel; 
  final int categoryid;
  SubCategory({this.subcategoryModel, this.categoryid});
  @override
  State<StatefulWidget> createState() {
    return SubCategoryState();
  }
}

class SubCategoryState extends State<SubCategory>{

  List<CategoryModel> subcategoryModel = List<CategoryModel>();

  @override
  void initState() {
    subcategoryModel = widget.subcategoryModel;
    super.initState();
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
        title: Text('SubCategories',style: TextStyle(color: textColor),),
        iconTheme: IconThemeData(color: mainColor),
        backgroundColor: secColor,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white,size: 30.0),
        tooltip: 'Add new SubCategory',
        onPressed: (){
          debugPrint(widget.categoryid.toString());
          //Navigator.of(context).pushNamed('/addSubCat');
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddSubCategory(parentid: widget.categoryid,);
          }));
        },
      ),
      //drawer: MyDrawer(),
      body: getSubCategoryList(),
    );
    return app;
  }

  ListView getSubCategoryList(){
    
    var app = ListView.builder(
      itemCount: subcategoryModel.length == null ? 0 : subcategoryModel.length, 
      itemBuilder: (BuildContext context, int index){
        return Container(
          height: 70.0,
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Constants.btnColor,
              radius: 22.0,
              child: Text(getTitle(subcategoryModel[index].name), style: TextStyle(color: Colors.white),)
            ),
            title: Text(subcategoryModel[index].name),
            subtitle: Text(subcategoryModel[index].description),
          ),
        ); 
      },

    );
    return app;
  }

  String getTitle(String title){
    var result= "";
    return result = title.substring(0,2);
  }

}