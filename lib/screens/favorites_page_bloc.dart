import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/bloc_exports.dart';
import '../models/book.dart';
import '../widgets/widgets_exports.dart';

class FavoritesPageBloc extends StatefulWidget {
  const FavoritesPageBloc({super.key});

  @override
  State<FavoritesPageBloc> createState() => _FavoritesPageBlocState();
}

class _FavoritesPageBlocState extends State<FavoritesPageBloc> {
  bool _isGridView = true;

  void _showBookDetails(BuildContext context, Book book) {
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

  void _confirmRemoveFavorite(BuildContext context, Book book) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer des favoris'),
        content: Text('Voulez-vous vraiment supprimer "${book.title}" de vos favoris ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              if (book.id != null) {
                context.read<FavoritesBloc>().add(RemoveFromFavorites(book.id!));
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header avec toggle de vue
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.favorite,
                color: Colors.red[400],
                size: 24,
              ),
              const SizedBox(width: 8),
              Text(
                'Mes Favoris',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const Spacer(),
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
        ),
        // Contenu
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<FavoritesBloc>().add(const LoadFavorites());
            },
            child: BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, state) {
                if (state is FavoritesLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is FavoritesError) {
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
                          onPressed: () {
                            context.read<FavoritesBloc>().add(const LoadFavorites());
                          },
                          child: const Text('Réessayer'),
                        ),
                      ],
                    ),
                  );
                }

                if (state is FavoritesLoaded || state is FavoriteOperationSuccess) {
                  final favorites = state is FavoritesLoaded
                      ? state.favorites
                      : (state as FavoriteOperationSuccess).favorites;

                  if (favorites.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.favorite_border,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Aucun livre dans vos favoris',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Ajoutez des livres à vos favoris\ndepuis la recherche',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[500],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }

                  return BooksGridWidget(
                    books: favorites,
                    isGridView: _isGridView,
                    isFavorite: (bookId) => true, // Tous sont favoris ici
                    onFavoritePressed: (book) {
                      _confirmRemoveFavorite(context, book);
                    },
                    onBookTap: (book) => _showBookDetails(context, book),
                  );
                }

                return const Center(
                  child: Text(
                    'Chargement des favoris...',
                    style: TextStyle(fontSize: 16),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
