
import 'package:restofood_sqlite/core/database/database.dart';
import 'package:restofood_sqlite/core/models/foods_mdl.dart';
import 'package:sqflite/sqflite.dart';

class FoodsDB {
  
  //Membuat instance database helper
  DatabaseHelper helper = new DatabaseHelper();

  //Fungsi mendapatkan makanan
  Future getAll() async {
    Database db = await helper.database;
    
    //Mengambil semua data dari table foods
    var result = await db.query("foods");
    return result;
  }

  Future<int> create(FoodModel foodModel) async {
    Database db = await helper.database;
    var result = db.insert("foods", foodModel.toMap());
    return result;
  }

  Future<int> update(FoodModel foodModel, int id) async {
    Database db = await helper.database;
    var result = db.update("foods", foodModel.toMap(), where: 'id = ?', whereArgs: [id]);
    return result;
  }

  Future delete(String id) async {
    Database db = await helper.database;
    var result = await db.rawDelete("DELETE FROM foods where id=$id");
    return result;
  }
}