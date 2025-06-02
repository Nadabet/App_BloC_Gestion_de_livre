import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/storage_service.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final StorageService _storageService;

  FavoritesBloc({StorageService? storageService})
      : _storageService = storageService ?? StorageServiceFactory.create(),
        super(const FavoritesInitial()) {
    on<LoadFavorites>(_onLoadFavorites);
    on<AddToFavorites>(_onAddToFavorites);
    on<RemoveFromFavorites>(_onRemoveFromFavorites);
    on<ToggleFavorite>(_onToggleFavorite);
  }

  Future<void> _onLoadFavorites(
    LoadFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    emit(const FavoritesLoading());

    try {
      final favorites = await _storageService.getFavorites();
      final favoriteIds = await _storageService.getFavoriteIds();
      
      emit(FavoritesLoaded(
        favorites: favorites,
        favoriteIds: favoriteIds,
      ));
    } catch (e) {
      emit(FavoritesError('Erreur lors du chargement des favoris: ${e.toString()}'));
    }
  }

  Future<void> _onAddToFavorites(
    AddToFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _storageService.addToFavorites(event.book);

      // Recharger les favoris
      final favorites = await _storageService.getFavorites();
      final favoriteIds = await _storageService.getFavoriteIds();
      
      emit(FavoriteOperationSuccess(
        favorites: favorites,
        favoriteIds: favoriteIds,
        message: 'Livre ajouté aux favoris',
      ));
    } catch (e) {
      emit(FavoritesError('Erreur lors de l\'ajout aux favoris: ${e.toString()}'));
    }
  }

  Future<void> _onRemoveFromFavorites(
    RemoveFromFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    try {
      await _storageService.removeFromFavorites(event.bookId);

      // Recharger les favoris
      final favorites = await _storageService.getFavorites();
      final favoriteIds = await _storageService.getFavoriteIds();
      
      emit(FavoriteOperationSuccess(
        favorites: favorites,
        favoriteIds: favoriteIds,
        message: 'Livre retiré des favoris',
      ));
    } catch (e) {
      emit(FavoritesError('Erreur lors de la suppression des favoris: ${e.toString()}'));
    }
  }

  Future<void> _onToggleFavorite(
    ToggleFavorite event,
    Emitter<FavoritesState> emit,
  ) async {
    if (event.book.id == null) {
      emit(const FavoritesError('ID du livre manquant'));
      return;
    }

    try {
      final isFavorite = await _storageService.isFavorite(event.book.id!);

      if (isFavorite) {
        // Supprimer des favoris
        await _storageService.removeFromFavorites(event.book.id!);

        // Recharger les favoris
        final favorites = await _storageService.getFavorites();
        final favoriteIds = await _storageService.getFavoriteIds();

        emit(FavoriteOperationSuccess(
          favorites: favorites,
          favoriteIds: favoriteIds,
          message: 'Livre retiré des favoris',
        ));
      } else {
        // Ajouter aux favoris
        await _storageService.addToFavorites(event.book);

        // Recharger les favoris
        final favorites = await _storageService.getFavorites();
        final favoriteIds = await _storageService.getFavoriteIds();

        emit(FavoriteOperationSuccess(
          favorites: favorites,
          favoriteIds: favoriteIds,
          message: 'Livre ajouté aux favoris',
        ));
      }
    } catch (e) {
      emit(FavoritesError('Erreur lors de la modification des favoris: ${e.toString()}'));
    }
  }
}
