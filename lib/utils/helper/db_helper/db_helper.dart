import 'dart:io';

import 'package:finalexam/screen/cart/model/cart_model.dart';
import 'package:finalexam/screen/home/model/home_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static DBHelper helper = DBHelper._();

  DBHelper._();

  Database? database;

  Future<Database>? checkDb() async {
    if (database != null) {
      return database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationSupportDirectory();
    String path = join(dir.path, "rutvik.db");

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String productQuary =
            "CREATE TABLE products (id INTEGER PRIMARY KEY AUTOINCREMENT,product TEXT,price TEXT,qua TEXT,image TEXT)";
        String cartQuary =
            "CREATE TABLE cart (id INTEGER PRIMARY KEY AUTOINCREMENT,product TEXT,price TEXT,qua TEXT,image TEXT)";
        db.execute(productQuary);
        db.execute(cartQuary);
      },
    );
  }

  Future<void> insertQuery(dbModel model) async {
    database = await checkDb();
    database!.insert(
      "products",
      {
        "product": model.product,
        "price": model.price,
        "qua": model.qua,
        "image": model.image,
      },
    );
  }

  Future<List<dbModel>>? read() async {
    database = await checkDb();
    String quotes = "SELECT * FROM products";
    List<Map> list = await database!.rawQuery(quotes);
    List<dbModel> l1 = list.map((e) => dbModel.mapToModel(e)).toList();
    return l1;
  }

  Future<void> delete(int id) async {
    database = await checkDb();
    database!.delete("products", where: "id=?", whereArgs: [id]);
  }

  void update(dbModel model) async {
    database = await checkDb();
    database!.update(
        "products",
        {
          "product": model.product,
          "qua": model.qua,
          "price": model.price,
          "image": model.image
        },
        where: "id=?",
        whereArgs: [model.id]);
  }

  Future<void> insertCart(dbModel model) async {
    database = await checkDb();
    database!.insert(
      "cart",
      {
        "product": model.product,
        "price": model.price,
        "qua": model.qua,
        "image": model.image,
      },
    );
  }

  Future<List<cartModel>>? readCart() async {
    database = await checkDb();
    String data1 = "SELECT * FROM cart";
    List<Map> list = await database!.rawQuery(data1);
    List<cartModel> l1 = list.map((e) => cartModel.mapToModel(e)).toList();
    return l1;
  }

  Future<void> deleteCart(int id) async {
    database = await checkDb();
    database!.delete("cart", where: "id=?", whereArgs: [id]);
  }

  void updateCart(cartModel model) async {
    database = await checkDb();
    database!.update(
        "cart",
        {
          "product": model.product,
          "qua": model.qua,
          "price": model.price,
          "image": model.image
        },
        where: "id=?",
        whereArgs: [model.id]);
  }
}
