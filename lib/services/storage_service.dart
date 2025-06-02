import 'package:flutter/foundation.dart';
import '../models/book.dart';
import 'database_service.dart';

abstract class StorageService {
  Future<List<Book>> getFavorites();
  Future<void> addToFavorites(Book book);
  Future<void> removeFromFavorites(String googleId);
  Future<bool> isFavorite(String googleId);
  Future<Set<String>> getFavoriteIds();
}

class InMemoryStorageService implements StorageService {
  static final InMemoryStorageService _instance = InMemoryStorageService._internal();
  final List<Book> _favorites = [];

  InMemoryStorageService._internal();

  factory InMemoryStorageService() => _instance;

  @override
  Future<List<Book>> getFavorites() async {
    return List.from(_favorites);
  }

  @override
  Future<void> addToFavorites(Book book) async {
    // Supprimer s'il existe déjà
    _favorites.removeWhere((b) => b.id == book.id);
    // Ajouter le nouveau
    _favorites.add(book);
  }

  @override
  Future<void> removeFromFavorites(String googleId) async {
    _favorites.removeWhere((book) => book.id == googleId);
  }

  @override
  Future<bool> isFavorite(String googleId) async {
    return _favorites.any((book) => book.id == googleId);
  }

  @override
  Future<Set<String>> getFavoriteIds() async {
    return _favorites.map((book) => book.id ?? '').where((id) => id.isNotEmpty).toSet();
  }
}

class StorageServiceFactory {
  static StorageService? _instance;

  static StorageService create() {
    if (_instance == null) {
      if (kIsWeb) {
        // Utiliser le stockage en mémoire pour le web
        _instance = InMemoryStorageService();
      } else {
        // Utiliser SQLite pour desktop/mobile
        _instance = DatabaseService();
      }
    }
    return _instance!;
  }
}
