
class CartModel {
  String title;
  int quantity;
  int price;

  CartModel({
    this.title, this.quantity, this.price
  });


  static List<CartModel> dummyData() {
    var _cart = new List<CartModel>();
    _cart.add(CartModel(
      title: "Ayam Bakar Pedas",
      quantity: 1,
      price: 15000
    ));

    _cart.add(CartModel(
      title: "Sate Ayam Kecap",
      quantity: 1,
      price: 12000
    ));

    _cart.add(CartModel(
      title: "Nasi Uduk",
      quantity: 1,
      price: 8000
    ));

    return _cart;
  }
}