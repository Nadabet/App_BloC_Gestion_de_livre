import 'package:equatable/equatable.dart';
import '../../models/book.dart';

abstract class FavoritesEvent extends Equatable {
  const FavoritesEvent();

  @override
  List<Object?> get props => [];
}

class LoadFavorites extends FavoritesEvent {
  const LoadFavorites();
}

class AddToFavorites extends FavoritesEvent {
  final Book book;

  const AddToFavorites(this.book);

  @override
  List<Object?> get props => [book];
}

class RemoveFromFavorites extends FavoritesEvent {
  final String bookId;

  const RemoveFromFavorites(this.bookId);

  @override
  List<Object?> get props => [bookId];
}

class ToggleFavorite extends FavoritesEvent {
  final Book book;

  const ToggleFavorite(this.book);

  @override
  List<Object?> get props => [book];
}
