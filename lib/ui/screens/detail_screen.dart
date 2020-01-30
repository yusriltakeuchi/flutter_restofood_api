import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:restofood_sqlite/core/models/foods_mdl.dart';
import 'package:restofood_sqlite/core/services/foods_services.dart';
import 'package:restofood_sqlite/ui/screens/update_screen.dart';

class DetailScreen extends StatelessWidget {
  FoodModel foodModel;
  DetailScreen({this.foodModel});

  void deleteFood(BuildContext context) async {
    await FoodsServices.delete(foodModel);
    Fluttertoast.showToast(
      msg: "Berhasil menghapus makanan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIos: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0
    );

    Future.delayed(Duration(
      seconds: 1
    ), () {
      Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> routes) => false);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(foodModel.title),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => UpdateScreen(
                  foodModel: foodModel,
                )
              )),
              child: Icon(Icons.edit, color: Colors.white,)
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () => deleteFood(context),
              child: Icon(Icons.delete, color: Colors.white,)
            ),
          ),
        ],
      ),
      body: DetailBody(
        foodModel: foodModel,
      ),
    );
  }
}

class DetailBody extends StatelessWidget {
  FoodModel foodModel;
  DetailBody({this.foodModel});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          //bagian untuk meload gambar
          new Stack(
            children: <Widget>[
              new ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0)),
                child: Image.memory(
                base64Decode(foodModel.image),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover,
                ),
              ),
              new Positioned(
                bottom: 20,
                right: 15,
                child: Container(
                  width: 300,
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        foodModel.title,
                        style: TextStyle(fontSize: 26, color: Colors.white),
                      ),
                      Text(
                        "Harga: Rp ${foodModel.price}", style: TextStyle(fontSize: 15, color: Colors.grey),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          new SizedBox(height: 4,),
          new Card(
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Row(
                    children: <Widget>[
                      new Icon(Icons.assignment, size: 20),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: new Text(
                          "Description", style: TextStyle(fontSize: 20, ),
                        ),
                      ),
                    
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: new Text(foodModel.fullDescription, style: TextStyle(fontSize: 15,),),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}