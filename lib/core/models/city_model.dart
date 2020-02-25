
class CityModel {
  int id;
  String name;

  CityModel({this.id, this.name});

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: json['id'] != null ? int.parse(json['id'].toString()) : 0,
      name: json['name'] != null ? json['name'] : ""
    );
  }
}