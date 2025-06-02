import 'package:equatable/equatable.dart';

abstract class BookSearchEvent extends Equatable {
  const BookSearchEvent();

  @override
  List<Object?> get props => [];
}

class SearchBooks extends BookSearchEvent {
  final String query;

  const SearchBooks(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends BookSearchEvent {
  const ClearSearch();
}
