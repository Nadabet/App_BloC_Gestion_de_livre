import 'package:equatable/equatable.dart';
import '../../models/book.dart';

abstract class BookSearchState extends Equatable {
  const BookSearchState();

  @override
  List<Object?> get props => [];
}

class BookSearchInitial extends BookSearchState {
  const BookSearchInitial();
}

class BookSearchLoading extends BookSearchState {
  const BookSearchLoading();
}

class BookSearchSuccess extends BookSearchState {
  final List<Book> books;
  final String query;

  const BookSearchSuccess({
    required this.books,
    required this.query,
  });

  @override
  List<Object?> get props => [books, query];
}

class BookSearchError extends BookSearchState {
  final String message;

  const BookSearchError(this.message);

  @override
  List<Object?> get props => [message];
}
