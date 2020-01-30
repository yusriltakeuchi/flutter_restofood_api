
class FoodModel {
  String id;
  String title;
  String description;
  String fullDescription;
  int price;
  String image;

  FoodModel({
    this.id, this.title, this.description,
    this.fullDescription, this.price, this.image
  });

  //Converter dari map ke object
  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id'].toString(),
      title: map['title'],
      description: map['description'],
      fullDescription: map['full_description'],
      price: int.parse(map['price'].toString()),
      image: map['image']
    );
  }

  //Converter dari object ke map
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = id;
		}
		map['title'] = title;
		map['description'] = description;
    map['full_description'] = fullDescription;
		map['price'] = price;
		map['image'] = image;
		
		return map;
  }
}