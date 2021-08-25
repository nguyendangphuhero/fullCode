import 'dart:developer';
import 'package:app_drawer/utilis/urllinks.dart';
import 'package:flutter/material.dart';
import 'package:app_drawer/models/product.dart';
import 'package:app_drawer/services/product_api.dart';
import 'package:app_drawer/screens/formadd_product.dart';
//phan duoi nut cong

class HomeProduct extends StatefulWidget {
  @override
  _HomeProductState createState() => _HomeProductState();

}
class _HomeProductState extends State<HomeProduct> {
  BuildContext context;
  ApiProduct apiService;
  @override
  void initState() {
    super.initState();
    apiService = ApiProduct();
  }
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SafeArea(
      child: FutureBuilder(
        //lay tat ca product, get duoc roi nek
        //tra ve 1 list product
        future: apiService.getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          //log('$snapshot');
          if (snapshot.hasError) {
            return Center(
              // dinh loi o day roi
              child: Text("Something wrong with message: ${snapshot.error.toString()}"),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            List<Product> products = snapshot.data;
            //log(products.toString());
            // xuong ham buiListView
            // Loi bi dinh profile
            //log(products.toString());
            return _buildListView(products);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
  //hien thi tat ca product va co them nut edit voi delete

  Widget _buildListView(List<Product> products) {

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Product product = products[index];
          //vi rang log o day k dc-> do han 2 thu vien
          //log(product.toString());
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    //hien thi product o duoi

                    Text(product.details),
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
                                    content: Text("Are you sure want to delete ${product.name}?"),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text("Yes"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          apiService.deleteProduct(product.id).then((isSuccess) {
                                            //log(product.id);
                                            //null
                                            //log(product.product.toString());
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
                              return FormAddProduct(product: product);
                            }));
                            if (result != null) {
                              setState(() {});
                            }
                          },
                          child: Text(
                            "Edit",
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
        itemCount: products.length,
      ),
    );
  }
}
