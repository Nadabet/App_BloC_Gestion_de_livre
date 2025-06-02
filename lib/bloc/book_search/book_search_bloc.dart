import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/api_service.dart';
import 'book_search_event.dart';
import 'book_search_state.dart';

class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  final ApiService _apiService;

  BookSearchBloc({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(const BookSearchInitial()) {
    on<SearchBooks>(_onSearchBooks);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onSearchBooks(
    SearchBooks event,
    Emitter<BookSearchState> emit,
  ) async {
    if (event.query.trim().isEmpty) {
      emit(const BookSearchError('Veuillez entrer un terme de recherche'));
      return;
    }

    emit(const BookSearchLoading());

    try {
      final books = await _apiService.searchBooks(event.query);
      emit(BookSearchSuccess(
        books: books,
        query: event.query,
      ));
    } catch (e) {
      emit(BookSearchError('Erreur lors de la recherche: ${e.toString()}'));
    }
  }

  void _onClearSearch(
    ClearSearch event,
    Emitter<BookSearchState> emit,
  ) {
    emit(const BookSearchInitial());
  }
}
