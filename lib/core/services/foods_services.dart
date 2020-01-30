
import 'package:restofood_sqlite/core/database/foods_db.dart';
import 'package:restofood_sqlite/core/models/foods_mdl.dart';

class FoodsServices {

  //Instance foodDatabase
  static FoodsDB _foodsDB;

  //Fungsi mendapatkan semua makanan
  static Future<List<FoodModel>> getAll() async {
    _foodsDB = new FoodsDB();

    var _result = await _foodsDB.getAll();
    var data = new List<FoodModel>();
    _result.forEach((foods) {
      data.add(FoodModel.fromMap(foods));
    });

    return data;
  }

  static Future<bool> create(FoodModel foodModel) async {
    _foodsDB = new FoodsDB();
    
    var _result = await _foodsDB.create(foodModel);
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> update(FoodModel foodModel, String id) async {
    _foodsDB = new FoodsDB();

    var _result = await _foodsDB.update(foodModel, int.parse(id));
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> delete(FoodModel foodModel) async {
    _foodsDB = new FoodsDB();

    var _result = await _foodsDB.delete(foodModel.id);
    if (_result != null) {
      return true;
    } else {
      return false;
    }
  }
}