import 'package:flutter/material.dart';
import 'package:restofood_api/core/models/cart_model.dart';
import 'package:restofood_api/ui/widgets/primary_button.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Cart", style: TextStyle(color: Colors.white)),
        leading: Icon(Icons.shopping_cart, color: Colors.white,),
      ),
      body: CartBody(),
    );
  }
}

class CartBody extends StatefulWidget {
  
  @override
  _CartBodyState createState() => _CartBodyState();
}

class _CartBodyState extends State<CartBody> {

  //Instance variable
  List<CartModel> cartList;
  List<TextEditingController> controllers;
  int totalPrice = 0;

  //Function menghitung total harga
  void calculateTotal() {
    setState(() {
      totalPrice = 0;
    });
    for(int i=0; i<cartList.length; i++) {
      int quantity = int.parse(controllers[i].text);
      setState(() {
        totalPrice += cartList[i].price * quantity;
      });
    }
  }

  //Function menambah quantity
  void increaseQuantity(int index) {
    int oldValue = int.parse(controllers[index].text);
    setState(() {
      controllers[index].text = (oldValue + 1).toString();
      cartList[index].quantity += 1;
    });
    calculateTotal();
  }

  //Function mengurangi quantity
  void decreaseQuantity(int index) {
    int oldValue = int.parse(controllers[index].text);

    //Jika jumlah quantity 0 tidak bisa dikurangi
    if (oldValue > 0) {
      setState(() {
        controllers[index].text = (oldValue - 1).toString();
        cartList[index].quantity -= 1;
      });
    }
    calculateTotal();
  }

  //Function inisialisasi controller list
  void initController() {
    controllers = new List<TextEditingController>();
    for(int i=0; i<cartList.length; i++) {
      controllers.add(TextEditingController());
      controllers[i].text = cartList[i].quantity.toString();
    }
  }

  //Function inisialisasi data list
  void initData() {
    cartList = CartModel.dummyData();
  }

  @override
  void initState() {
    super.initState();
    this.initData();
    this.initController();
    this.calculateTotal();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Total Harga",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              Text(
                "Rp ${totalPrice.toString()}",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          SizedBox(height: 10),

          _itemList()
        ],
      ),
    );
  }

  Widget _itemList() {
    return //Items Chart
      ListView.builder(
        itemCount: cartList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {

          var cart = cartList[index];
          return Card(
            elevation: 2,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[

                    //Bagian image, title, quantity
                    Row(
                      children: <Widget>[
                        Icon(Icons.fastfood, size: 30),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              cart.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${cart.quantity.toString()} x Rp ${cart.price.toString()}",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54
                              ),
                            ),
                          ],
                        )
                      ],
                    ),

                    //Bagian total harga dan item plus minus
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 45),
                        Text(
                          "Rp ${(cart.price * cart.quantity).toString()}",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54
                          ),
                        ),
                        SizedBox(height: 5),
                        
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 32,
                              height: 20,
                              child: RaisedButton(
                                color: Colors.red,
                                onPressed: () => decreaseQuantity(index),
                                padding: EdgeInsets.all(0),
                                child: Icon(Icons.minimize, color: Colors.white, size: 20),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 32,
                              height: 20,
                              child: TextField(
                                readOnly: true,
                                controller: controllers[index],
                                textInputAction: TextInputAction.go,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "0",
                                  contentPadding: EdgeInsets.only(bottom: 10)
                                ),
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              width: 32,
                              height: 20,
                              child: RaisedButton(
                                color: Colors.green,
                                onPressed: () => increaseQuantity(index),
                                padding: EdgeInsets.all(0),
                                child: Icon(Icons.add, color: Colors.white, size: 20),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
  }
}