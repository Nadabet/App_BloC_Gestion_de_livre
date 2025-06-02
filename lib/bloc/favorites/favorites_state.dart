import 'package:equatable/equatable.dart';
import '../../models/book.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState();

  @override
  List<Object?> get props => [];
}

class FavoritesInitial extends FavoritesState {
  const FavoritesInitial();
}

class FavoritesLoading extends FavoritesState {
  const FavoritesLoading();
}

class FavoritesLoaded extends FavoritesState {
  final List<Book> favorites;
  final Set<String> favoriteIds;

  const FavoritesLoaded({
    required this.favorites,
    required this.favoriteIds,
  });

  @override
  List<Object?> get props => [favorites, favoriteIds];

  bool isFavorite(String? bookId) {
    return bookId != null && favoriteIds.contains(bookId);
  }
}

class FavoritesError extends FavoritesState {
  final String message;

  const FavoritesError(this.message);

  @override
  List<Object?> get props => [message];
}

class FavoriteOperationSuccess extends FavoritesState {
  final List<Book> favorites;
  final Set<String> favoriteIds;
  final String message;

  const FavoriteOperationSuccess({
    required this.favorites,
    required this.favoriteIds,
    required this.message,
  });

  @override
  List<Object?> get props => [favorites, favoriteIds, message];

  bool isFavorite(String? bookId) {
    return bookId != null && favoriteIds.contains(bookId);
  }
}
