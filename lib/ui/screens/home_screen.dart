import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restofood_api/core/models/foods_mdl.dart';
import 'package:restofood_api/core/services/food_services.dart';
import 'package:restofood_api/ui/screens/add_screen.dart';
import 'package:restofood_api/ui/screens/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Restofood", style: TextStyle(color: Colors.white)),
        leading: Icon(Icons.fastfood, color: Colors.white,),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => AddScreen()
              )),
              child: Icon(Icons.add_circle, color: Colors.white,)
            ),
          )
        ],
      ),
      body: HomeBody(),
    );
  }
}



class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          //Bagian ini untuk itemnya
          Text(
            "Daftar Makanan & Minuman",
            style: TextStyle(
              fontSize: 18,
              color: Colors.black87,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(height: 20),
          //Widget daftar makanan
          ListFood()
        ],
      ),
    );
  }
}


class ListFood extends StatefulWidget {
  @override
  _ListFoodState createState() => _ListFoodState();
}

class _ListFoodState extends State<ListFood> {

  //Instance data foods
  List<FoodModel> foods;

  void loadData() async {
    var _foods = foods = await FoodServices.getAll();
    setState(() {
      foods = _foods;
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadData();
  }
  @override
  Widget build(BuildContext context) {

    if (foods == null) {
      return Center(
        child: CircularProgressIndicator(
        ),
      );
    }

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          
          //Menambahkan item list
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Card(
              elevation: 1,
              child: InkWell(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    foodModel: foods[index],
                  )
                )),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      //Bagian ini tambahkan image
                      Container(
                        width: 64,
                        height: 64,
                        child: Image.network(
                          foods[index].image,
                          fit: BoxFit.cover,
                        ),
                      ),
                      
                      //Memberi jarak
                      SizedBox(width: 10),

                      //Bagian untuk title dan description
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //Title
                          Text(
                            foods[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),

                          //Memberi jarak
                          SizedBox(height: 5,),

                          //Description
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Text(
                              foods[index].description,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          //Harga
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "Rp ${foods[index].price.toString()}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      )
    );
  }
}