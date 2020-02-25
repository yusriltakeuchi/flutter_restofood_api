
import 'package:restofood_api/core/config/endpoint.dart';
import 'package:restofood_api/core/models/city_model.dart';
import 'package:dio/dio.dart';

class CityServices {
  static Dio dio = new Dio();

  //Get foods data
  static Future<List<CityModel>> getAll() async {
    var response = await dio.get(
      Endpoint.baseCity,
      options: Options(
        headers: {
          "Accept": "application/json"
        }
      )
    );

    var _cityData = List<CityModel>();
    response.data["data"].forEach((value) {
      _cityData.add(CityModel.fromJson(value));
    });

    print(_cityData[0].name);
    return _cityData;
  }
}