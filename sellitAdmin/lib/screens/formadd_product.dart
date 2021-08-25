import 'package:flutter/material.dart';
import 'package:app_drawer/models/product.dart';
import 'package:app_drawer/services/product_api.dart';
import 'dart:developer';


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
// Phan nut cong
class FormAddProduct extends StatefulWidget {
  Product product;

  FormAddProduct({this.product});

  @override
  _FormAddProductState createState() => _FormAddProductState();
}

class _FormAddProductState extends State<FormAddProduct> {
  bool _isLoading = false;
  //lay data
  ApiProduct _apiService = ApiProduct();
  // kiem tra xem co trong hay khong?
  bool _isFieldNameValid;
  bool _isFieldPriceValid;
  bool _isFieldImageUrlValid;
  bool _isFieldCategoryValid;
  bool _isFieldDetailsValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();
  TextEditingController _controllerImageUrl = TextEditingController();
  TextEditingController _controllerCategory = TextEditingController();
  TextEditingController _controllerDetails = TextEditingController();
  @override
  void initState() {
    if (widget.product != null) {
      _isFieldNameValid = true;
      _controllerName.text = widget.product.name;
      _isFieldPriceValid = true;
      _controllerPrice.text = widget.product.price.toString();
      _isFieldImageUrlValid = true;
      _controllerImageUrl.text = widget.product.imageUrl;
      _isFieldCategoryValid = true;
      _controllerCategory.text = widget.product.category;
      _isFieldDetailsValid = true;
      _controllerDetails.text = widget.product.details;
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
          widget.product == null ? "Add Product" : "Update Product",
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
                _buildTextFieldName(),
                _buildTextFieldPrice(),
                _buildTextFieldImageUrl(),
                _buildTextFieldCategory(),
                _buildTextFieldDetails(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    child: Text(
                      widget.product == null
                          ? "Add Product".toUpperCase()
                          : "Update Product".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    //Nhan nut thay doi data
                    onPressed: () {
                      if (_isFieldNameValid == null ||
                          _isFieldPriceValid == null ||
                          _isFieldCategoryValid == null ||
                          _isFieldImageUrlValid == null ||
                          _isFieldDetailsValid == null ||
                          !_isFieldNameValid ||
                          !_isFieldPriceValid ||
                          !_isFieldImageUrlValid ||
                          !_isFieldCategoryValid ||
                          !_isFieldDetailsValid ) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Please fill all field"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String name = _controllerName.text.toString();
                      int price = int.parse(_controllerPrice.text.toString().toString());
                      String imageUrl = _controllerImageUrl.text.toString();
                      String category = _controllerCategory.text.toString();
                      String details = _controllerDetails.text.toString();

                      Product product_ob = Product(name: name,price: price,imageUrl: imageUrl,category: category,details: details);
                      //tao Category
                      if (widget.product == null) {
                        //create tai day
                        _apiService.createProduct(product_ob).then((isSuccess) {
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
                        product_ob.id = widget.product.id;
                        _apiService.updateProduct(product_ob).then((isSuccess) {
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
  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Name",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Name is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPrice() {
    return TextField(
      controller: _controllerPrice,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Price",
        errorText: _isFieldPriceValid == null || _isFieldPriceValid
            ? null
            : "Price is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPriceValid) {
          setState(() => _isFieldPriceValid = isFieldValid);
        }
      },
    );
  }
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
  Widget _buildTextFieldImageUrl() {
    return TextField(
      controller: _controllerImageUrl,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Image URL",
        errorText: _isFieldImageUrlValid == null || _isFieldImageUrlValid
            ? null
            : "Image URL is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldImageUrlValid) {
          setState(() => _isFieldImageUrlValid = isFieldValid);
        }
      },
    );
  }
  Widget _buildTextFieldDetails() {
    return TextField(
      controller: _controllerDetails,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Details",
        errorText: _isFieldDetailsValid == null || _isFieldDetailsValid
            ? null
            : "Details is required",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldDetailsValid) {
          setState(() => _isFieldDetailsValid = isFieldValid);
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
