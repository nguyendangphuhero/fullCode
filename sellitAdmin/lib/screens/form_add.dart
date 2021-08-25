import 'package:flutter/material.dart';
import 'package:app_drawer/models/category.dart';
import 'package:app_drawer/services/category_api.dart';
import 'dart:developer';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
// Phan nut cong
class FormAddCategory extends StatefulWidget {
  Category category;

  FormAddCategory({this.category});

  @override
  _FormAddCategoryState createState() => _FormAddCategoryState();
}

class _FormAddCategoryState extends State<FormAddCategory> {
  bool _isLoading = false;
  //lay data
  ApiCategory _apiService = ApiCategory();
  // kiem tra xem co trong hay khong?
  bool _isFieldCategoryValid;
  TextEditingController _controllerCategory = TextEditingController();
  @override
  void initState() {
    if (widget.category != null) {
      _isFieldCategoryValid = true;
      _controllerCategory.text = widget.category.category;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      //phan tren form add
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          widget.category == null ? "Add category" : "Update Category",
          style: TextStyle(color: Colors.white),
        ),
      ),
      //phan duoi form add
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldCategory(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.category == null
                          ? "Add Category".toUpperCase()
                          : "Update Category".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    //Nhan nut thay doi data
                    onPressed: () {
                      if (_isFieldCategoryValid == null ||
                          !_isFieldCategoryValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String category = _controllerCategory.text.toString();
                      Category category_ob = Category(category: category);
                      //tao Category
                      if (widget.category == null) {
                        //create tai day
                        _apiService.createCategory(category_ob).then((isSuccess) {
                          setState(() => _isLoading = false);
                          //log(isSuccess.toString());
                          //false
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            // tai sao lai vo day-> tai vi isSuccess = false
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Submit data failed"),
                            ));
                          }
                        });
                      } else {
                        //cap nhat category
                        category_ob.id = widget.category.id;
                        _apiService.updateCategory(category_ob).then((isSuccess) {
                          //log(category_ob.toString());
                          setState(() => _isLoading = false);
                          if (isSuccess) {
                            Navigator.pop(_scaffoldState.currentState.context, true);
                          } else {
                            _scaffoldState.currentState.showSnackBar(SnackBar(
                              content: Text("Update data failed"),
                            ));
                          }
                        });
                      }
                    },
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
            children: <Widget>[
              Opacity(
                opacity: 0.3,
                child: ModalBarrier(
                  dismissible: false,
                  color: Colors.grey,
                ),
              ),
              Center(
                child: CircularProgressIndicator(),
              ),
            ],
          )
              : Container(),
        ],
      ),
    );
  }
  // kiem tra xem da nhap ten hay chua?
  Widget _buildTextFieldCategory() {
    return TextField(
      controller: _controllerCategory,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Category",
        errorText: _isFieldCategoryValid == null || _isFieldCategoryValid
            ? null
            : "Category is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldCategoryValid) {
          setState(() => _isFieldCategoryValid = isFieldValid);
        }
      },
    );
  }
//kiem tra da nhap email hay chua
//   Widget _buildTextFieldEmail() {
//     return TextField(
//       controller: _controllerEmail,
//       keyboardType: TextInputType.emailAddress,
//       decoration: InputDecoration(
//         labelText: "Email",
//         errorText: _isFieldEmailValid == null || _isFieldEmailValid
//             ? null
//             : "Email is required",
//       ),
//       onChanged: (value) {
//         bool isFieldValid = value.trim().isNotEmpty;
//         if (isFieldValid != _isFieldEmailValid) {
//           setState(() => _isFieldEmailValid = isFieldValid);
//         }
//       },
//     );
//   }
// //kiem tra da nhap tuoi hay chua
//   Widget _buildTextFieldAge() {
//     return TextField(
//       controller: _controllerAge,
//       keyboardType: TextInputType.number,
//       decoration: InputDecoration(
//         labelText: "Age",
//         errorText: _isFieldAgeValid == null || _isFieldAgeValid
//             ? null
//             : "Age is required",
//       ),
//       onChanged: (value) {
//         bool isFieldValid = value.trim().isNotEmpty;
//         if (isFieldValid != _isFieldAgeValid) {
//           setState(() => _isFieldAgeValid = isFieldValid);
//         }
//       },
//     );
//   }
}
