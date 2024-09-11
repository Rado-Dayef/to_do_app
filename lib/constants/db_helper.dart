// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:to_do_app/constants/strings.dart';
//
// class DBHelper {
//   Database? _db;
//
//   Future<Database?> get db async {
//     if (_db != null) {
//       return _db;
//     } else {
//       _db = await initDB();
//       return _db;
//     }
//   }
//
//   /// To Initialize the database.
//   Future<Database?> initDB() async {
//     String path = await getDatabasesPath();
//     String fullPath = join(path, AppStrings.dataBaseName);
//     return openDatabase(fullPath, onCreate: _onCreate, version: 1);
//   }
//
//   /// To create table in database.
//   void _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE "To_Do" (
//         "title" TEXT NOT NULL,
//         "subtitle" TEXT NOT NULL,
//         "isDone" INTEGER NOT NULL,
//         "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
//       );
//     ''');
//   }
//
//   /// To get data from database.
//   Future<List<Map<String, dynamic>>> getData(String sql) async {
//     Database? myDB = await db;
//     List<Map<String, dynamic>> response = await myDB!.rawQuery(sql);
//     return response;
//   }
//
//   /// To insert data in database.
//   Future<int> insertData(String sql) async {
//     Database? myDB = await db;
//     int id = await myDB!.rawInsert(sql);
//     return id;
//   }
//
//   /// To update data from database.
//   Future<bool> updateData(String sql) async {
//     Database? myDB = await db;
//     bool isSuccess = await myDB!.rawUpdate(sql) == 1 ? true : false;
//     return isSuccess;
//   }
//
//   /// To delete data from database.
//   Future<bool> deleteData(String sql) async {
//     Database? myDB = await db;
//     bool isSuccess = await myDB!.rawDelete(sql) == 1 ? true : false;
//     return isSuccess;
//   }
//
//   /// To delete the database.
//   void dropDB() async {
//     String path = await getDatabasesPath();
//     String fullPath = join(path, AppStrings.dataBaseName);
//     await deleteDatabase(fullPath);
//   }
// }

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/constants/extensions.dart';
import 'package:to_do_app/constants/strings.dart';

class DBHelper {
  Database? _db;

  /// Lazy loading of the database instance.
  Future<Database?> get db async {
    _db ??= await initDB();
    return _db;
  }

  /// Initializes the database and creates the necessary tables.
  Future<Database?> initDB() async {
    try {
      String path = await getDatabasesPath();
      String fullPath = join(path, AppStrings.dataBaseName);
      return openDatabase(fullPath, version: 1, onCreate: _onCreate);
    } catch (error) {
      "Error initializing DB: $error".showToast;
      return null;
    }
  }

  /// Creates the 'To_Do' table when the database is first created.
  void _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE "To_Do" (
          "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
          "title" TEXT NOT NULL,
          "subtitle" TEXT NOT NULL,
          "isDone" INTEGER NOT NULL
        );
      ''');
    } catch (error) {
      "Error creating table: $error".showToast;
    }
  }

  /// Executes a SELECT query and returns the result as a list of maps.
  Future<List<Map<String, dynamic>>> getData(String sql) async {
    try {
      Database? myDB = await db;
      List<Map<String, dynamic>> response = await myDB!.rawQuery(sql);
      return response;
    } catch (error) {
      "Error getting data: $error".showToast;
      return [];
    }
  }

  /// Executes an INSERT query and returns the ID of the inserted row.
  Future<int> insertData(String sql) async {
    try {
      Database? myDB = await db;
      int id = await myDB!.rawInsert(sql);
      return id;
    } catch (error) {
      "Error inserting data: $error".showToast;
      return -1;
    }
  }

  /// Executes an UPDATE query and returns the number of affected rows.
  Future<bool> updateData(String sql) async {
    try {
      Database? myDB = await db;
      bool isSuccess = await myDB!.rawUpdate(sql) == 0 ? false : true;
      return isSuccess;
    } catch (error) {
      "Error updating data: $error".showToast;
      return false;
    }
  }

  /// Executes a DELETE query and returns the number of affected rows.
  Future<bool> deleteData(String sql) async {
    try {
      Database? myDB = await db;
      bool affectedRows = await myDB!.rawDelete(sql) == 0 ? false : true;
      return affectedRows;
    } catch (error) {
      "Error deleting data: $error".showToast;
      return false;
    }
  }

  /// Deletes the entire database file from the device.
  Future<void> dropDB() async {
    try {
      String path = await getDatabasesPath();
      String fullPath = join(path, AppStrings.dataBaseName);
      await deleteDatabase(fullPath);
    } catch (error) {
      "Error deleting database: $error".showToast;
    }
  }
}
