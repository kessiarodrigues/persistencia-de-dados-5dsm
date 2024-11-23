import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._privateConstructor();
  static final AppDatabase instance = AppDatabase._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'movies.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE movies(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, director TEXT, year INTEGER, description TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertMovie(Map<String, dynamic> movie) async {
    Database db = await instance.database;
    await db.insert(
      'movies',
      movie,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getMovies() async {
    Database db = await instance.database;
    return await db.query('movies');
  }
}
