import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tech_dome_assignment/database/db_constant.dart';
import 'package:tech_dome_assignment/module/home/model/movie_response.dart';

class DatabaseHelper {
  // make this a singleton class
  DatabaseHelper.internal();

  static final DatabaseHelper db = DatabaseHelper.internal();

  factory DatabaseHelper() {
    return db;
  }

  // only have a single app-wide reference to the database
  static Database? database;

  static Future<Database> getDatabase() async {
    if (database != null) return database!;
    database = await initDb();
    return database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  static initDb() async {
    String path = join(await getDatabasesPath(), DBConstant.databaseName);
    return await openDatabase(path, version: DBConstant.databaseVersion,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE ${DBConstant.table} (
            ${DBConstant.columnId} INTEGER PRIMARY KEY,
            ${DBConstant.id} INTEGER NOT NULL,
            ${DBConstant.title} TEXT NOT NULL,
            ${DBConstant.posterUrl} TEXT NOT NULL,
            ${DBConstant.imdbId} TEXT NOT NULL
          )
          ''');

      await db.execute('''
          CREATE TABLE ${DBConstant.favouriteTable} (
            ${DBConstant.columnId} INTEGER PRIMARY KEY,
            ${DBConstant.id} INTEGER NOT NULL,
            ${DBConstant.title} TEXT NOT NULL,
            ${DBConstant.posterUrl} TEXT NOT NULL,
            ${DBConstant.imdbId} TEXT NOT NULL
          )
          ''');
    });
  }

  Future<void> saveAllMovie(List<MovieResponse> movieResponse) async {
    await deleteAllMovies();
    final dbClient = await getDatabase();
    try {
      for (var ele in movieResponse) {
        await dbClient.insert(DBConstant.table, ele.toJson());
      }
      debugPrint("save-movie-called-->");
    } catch (e) {
      debugPrint("on-catch-error-->$e");
    }
  }

  // Delete all employees
  Future<void> deleteAllMovies() async {
    final db = await getDatabase();
    try {
      await db.rawDelete('DELETE FROM ${DBConstant.table}');
      debugPrint("delete-movie-called--->>>");
    } catch (e) {
      debugPrint("on-catch-delete-error-->$e");
    }
  }

  Future<bool> checkExistingUser(name) async {
    final dbClient = await getDatabase();
    final List<Map<String, dynamic>> list = await dbClient.query(
      '${DBConstant.table}',
      where: 'userName = ?',
      whereArgs: [name],
    );
    debugPrint("list----->${list}");
    return list.isNotEmpty;
  }

  Future<List<MovieResponse>> getAllMovie() async {
    final dbClient = await getDatabase();
    final List<Map<String, dynamic>> queryResult =
        await dbClient.query(DBConstant.table);
    return List.generate(queryResult.length, (i) {
      return MovieResponse.fromJson(queryResult[i]);
    });
  }

  Future<void> saveFavourite(MovieResponse movieResponse) async {
    var result = await checkFavourite(movieResponse.title);
    if (result) {
      await deleteFavorite(movieResponse);
      Fluttertoast.showToast(msg: "Deleted");
      debugPrint("manage-update---");
    } else {
      final dbClient = await getDatabase();
      try {
        await dbClient.insert(
            DBConstant.favouriteTable, movieResponse.toJson());
        Fluttertoast.showToast(msg: "Save To Favourite");
        debugPrint("save-favourite-called-->");
      } catch (e) {
        debugPrint("on-catch-error-->$e");
      }
    }
  }

  Future<void> deleteFavorite(MovieResponse response) async {
    final db = await getDatabase();
    await db.delete(
      DBConstant.favouriteTable,
      where: 'title = ?',
      whereArgs: [response.title],
    );
  }

  Future<bool> checkFavourite(var title) async {
    final dbClient = await getDatabase();
    final List<Map<String, dynamic>> result = await dbClient.query(
        DBConstant.favouriteTable,
        where: 'title = ?',
        whereArgs: [title]);
    return result.isNotEmpty;
  }

  Future<List<MovieResponse>> getFavoriteMovies() async {
    final db = await getDatabase();
    final List<Map<String, dynamic>> maps =
        await db.query(DBConstant.favouriteTable);

    return List.generate(maps.length, (i) {
      return MovieResponse.fromJson(maps[i]);
    });
  }
}
