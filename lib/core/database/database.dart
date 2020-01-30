import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  //Instance database
  Database _database;
  //Nama database
  String _dbName = "restofood.db";

  //Membuat getter database
  Future<Database> get database async {
    //Jika database masih kosong
    //maka akan init database baru
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  //Inisialisasi database
  Future<Database> initializeDatabase() async {
    //Mengambil lokasi database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = "${directory.path}/${_dbName}";

    //Membuka database
    var database = await openDatabase(path, version: 1, onCreate: _createDB);
    return database;
  }

  //Function membuat database baru
  void _createDB(Database db, int newVersion) async {
    await db.execute('''CREATE TABLE foods (id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT, description TEXT, full_description TEXT, price INTEGER, image TEXT)''');
  } 
}