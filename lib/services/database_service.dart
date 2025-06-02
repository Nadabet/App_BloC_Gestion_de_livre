import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import '../models/book.dart';
import 'storage_service.dart';

class DatabaseService implements StorageService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  DatabaseService._internal();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'books.db');

    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _createDatabase,
      ),
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE favorites(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        google_id TEXT NOT NULL UNIQUE,
        title TEXT NOT NULL,
        author TEXT NOT NULL,
        image_url TEXT,
        description TEXT
      )
    ''');
  }

  @override
  Future<List<Book>> getFavorites() async {
    try {
      final db = await database;
      final List<Map<String, dynamic>> maps = await db.query('favorites');
      return maps.map((map) => Book.fromMap(map)).toList();
    } catch (e) {
      throw Exception('Erreur lors de la récupération des favoris: $e');
    }
  }

  @override
  Future<void> addToFavorites(Book book) async {
    try {
      final db = await database;
      await db.insert(
        'favorites',
        book.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw Exception('Erreur lors de l\'ajout aux favoris: $e');
    }
  }

  @override
  Future<void> removeFromFavorites(String googleId) async {
    try {
      final db = await database;
      final result = await db.delete(
        'favorites',
        where: 'google_id = ?',
        whereArgs: [googleId],
      );
      if (result == 0) {
        throw Exception('Livre non trouvé dans les favoris');
      }
    } catch (e) {
      throw Exception('Erreur lors de la suppression des favoris: $e');
    }
  }

  @override
  Future<bool> isFavorite(String googleId) async {
    try {
      final db = await database;
      final result = await db.query(
        'favorites',
        where: 'google_id = ?',
        whereArgs: [googleId],
        limit: 1,
      );
      return result.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Set<String>> getFavoriteIds() async {
    try {
      final favorites = await getFavorites();
      return favorites.map((book) => book.id ?? '').where((id) => id.isNotEmpty).toSet();
    } catch (e) {
      return <String>{};
    }
  }
}
