import 'package:flutter/material.dart';
import '../models/book.dart';
import 'book_card_widget.dart';

class BooksGridWidget extends StatelessWidget {
  final List<Book> books;
  final bool Function(String?) isFavorite;
  final void Function(Book) onFavoritePressed;
  final void Function(Book) onBookTap;
  final bool isGridView;

  const BooksGridWidget({
    super.key,
    required this.books,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onBookTap,
    this.isGridView = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isGridView) {
      return _buildGridView();
    } else {
      return _buildListView();
    }
  }

  Widget _buildGridView() {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCardWidget(
          book: book,
          isFavorite: isFavorite(book.id),
          onFavoritePressed: () => onFavoritePressed(book),
          onTap: () => onBookTap(book),
          isCompact: true,
        );
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookCardWidget(
          book: book,
          isFavorite: isFavorite(book.id),
          onFavoritePressed: () => onFavoritePressed(book),
          onTap: () => onBookTap(book),
          isCompact: false,
        );
      },
    );
  }
}
