import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_exports.dart';
import '../models/book.dart';
import '../widgets/widgets_exports.dart';
import 'favorites_page_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  bool _isGridView = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchPressed() {
    final query = _searchController.text.trim();
    if (query.isNotEmpty) {
      context.read<BookSearchBloc>().add(SearchBooks(query));
    }
  }

  void _onClearPressed() {
    _searchController.clear();
    context.read<BookSearchBloc>().add(const ClearSearch());
  }

  void _onBottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getSelectedPage() {
    switch (_selectedIndex) {
      case 0:
        return _buildSearchPage();
      case 1:
        return const FavoritesPageBloc();
      default:
        return _buildSearchPage();
    }
  }

  Widget _buildSearchPage() {
    return Column(
      children: [
        _buildSearchBar(),
        Expanded(child: _buildSearchResults()),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      hintText: 'Rechercher des livres...',
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    onSubmitted: (_) => _onSearchPressed(),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  onPressed: _onSearchPressed,
                  icon: const Icon(Icons.search, color: Colors.white),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: IconButton(
                  onPressed: _onClearPressed,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Vue: ',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              ToggleButtons(
                isSelected: [!_isGridView, _isGridView],
                onPressed: (index) {
                  setState(() {
                    _isGridView = index == 1;
                  });
                },
                borderRadius: BorderRadius.circular(20),
                selectedColor: Colors.white,
                fillColor: Theme.of(context).primaryColor,
                color: Colors.grey[600],
                constraints: const BoxConstraints(
                  minHeight: 36,
                  minWidth: 36,
                ),
                children: const [
                  Icon(Icons.view_list, size: 20),
                  Icon(Icons.grid_view, size: 20),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return BlocBuilder<BookSearchBloc, BookSearchState>(
      builder: (context, state) {
        if (state is BookSearchInitial) {
          return const Center(
            child: Text(
              'Recherchez des livres en utilisant la barre de recherche',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          );
        }

        if (state is BookSearchLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is BookSearchError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 64, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _onSearchPressed,
                  child: const Text('Réessayer'),
                ),
              ],
            ),
          );
        }

        if (state is BookSearchSuccess) {
          if (state.books.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Aucun livre trouvé',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Essayez avec d\'autres mots-clés',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Indicateur de résultats
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  '${state.books.length} livre(s) trouvé(s) pour "${state.query}"',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Liste des livres
              Expanded(
                child: BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, favoritesState) {
                    return BooksGridWidget(
                      books: state.books,
                      isGridView: _isGridView,
                      isFavorite: (bookId) {
                        if (favoritesState is FavoritesLoaded) {
                          return favoritesState.isFavorite(bookId);
                        } else if (favoritesState is FavoriteOperationSuccess) {
                          return favoritesState.isFavorite(bookId);
                        }
                        return false;
                      },
                      onFavoritePressed: (book) {
                        context.read<FavoritesBloc>().add(ToggleFavorite(book));
                      },
                      onBookTap: (book) => _showBookDetails(book),
                    );
                  },
                ),
              ),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }



  void _showBookDetails(Book book) {
    showDialog(
      context: context,
      builder: (context) => BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, favoritesState) {
          bool isFavorite = false;
          if (favoritesState is FavoritesLoaded) {
            isFavorite = favoritesState.isFavorite(book.id);
          } else if (favoritesState is FavoriteOperationSuccess) {
            isFavorite = favoritesState.isFavorite(book.id);
          }

          return BookDetailsDialog(
            book: book,
            isFavorite: isFavorite,
            onFavoritePressed: () {
              context.read<FavoritesBloc>().add(ToggleFavorite(book));
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.library_books,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Gestionnaire de Livres',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor.withValues(alpha: 0.8),
              ],
            ),
          ),
        ),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<FavoritesBloc, FavoritesState>(
            listener: (context, state) {
              if (state is FavoriteOperationSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
              } else if (state is FavoritesError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
          ),
        ],
        child: _getSelectedPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Recherche',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoris',
          ),
        ],
      ),
    );
  }
}
