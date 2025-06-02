# Architecture BLoC - Gestionnaire de Livres

## Vue d'ensemble

Cette application a été refactorisée pour utiliser le pattern BLoC (Business Logic Component), qui sépare clairement la logique métier de l'interface utilisateur.

## Structure du projet

```
lib/
├── bloc/                           # Couche BLoC
│   ├── book_search/               # BLoC pour la recherche de livres
│   │   ├── book_search_bloc.dart
│   │   ├── book_search_event.dart
│   │   └── book_search_state.dart
│   ├── favorites/                 # BLoC pour les favoris
│   │   ├── favorites_bloc.dart
│   │   ├── favorites_event.dart
│   │   └── favorites_state.dart
│   └── bloc_exports.dart          # Exports centralisés
├── models/                        # Modèles de données
│   └── book.dart
├── screens/                       # Interface utilisateur
│   ├── home_page_bloc.dart        # Page principale (BLoC)
│   ├── favorites_page_bloc.dart   # Page favoris (BLoC)
│   ├── home_page.dart            # Ancienne version (à supprimer)
│   └── favorites_page.dart       # Ancienne version (à supprimer)
├── services/                      # Services
│   ├── api_service.dart          # Service API Google Books
│   ├── database_service.dart     # Service base de données unifié
│   ├── db_service.dart          # Ancien service (à supprimer)
│   └── database_helper.dart     # Ancien helper (à supprimer)
└── main.dart                     # Point d'entrée avec BlocProviders
```

## Architecture BLoC

### 1. Events (Événements)

#### BookSearchEvent
- `SearchBooks(String query)` - Rechercher des livres
- `ClearSearch()` - Effacer la recherche

#### FavoritesEvent
- `LoadFavorites()` - Charger les favoris
- `AddToFavorites(Book book)` - Ajouter aux favoris
- `RemoveFromFavorites(String bookId)` - Supprimer des favoris
- `ToggleFavorite(Book book)` - Basculer le statut favori

### 2. States (États)

#### BookSearchState
- `BookSearchInitial` - État initial
- `BookSearchLoading` - Recherche en cours
- `BookSearchSuccess` - Recherche réussie avec résultats
- `BookSearchError` - Erreur de recherche

#### FavoritesState
- `FavoritesInitial` - État initial
- `FavoritesLoading` - Chargement en cours
- `FavoritesLoaded` - Favoris chargés
- `FavoriteOperationSuccess` - Opération réussie avec message
- `FavoritesError` - Erreur

### 3. BLoCs

#### BookSearchBloc
- Gère la recherche de livres via l'API Google Books
- Utilise `ApiService` pour les appels réseau
- Gère les états de chargement et d'erreur

#### FavoritesBloc
- Gère la liste des favoris
- Utilise `DatabaseService` pour la persistance
- Gère les opérations CRUD sur les favoris

## Services

### ApiService
- Service pour interagir avec l'API Google Books
- Méthodes non-statiques pour faciliter les tests
- Gestion d'erreurs améliorée

### DatabaseService
- Service unifié pour la base de données SQLite
- Pattern Singleton pour une seule instance
- Méthodes asynchrones avec gestion d'erreurs

## Avantages de l'architecture BLoC

1. **Séparation des responsabilités** : La logique métier est séparée de l'UI
2. **Testabilité** : Les BLoCs peuvent être testés indépendamment
3. **Réactivité** : L'UI réagit automatiquement aux changements d'état
4. **Maintenabilité** : Code plus organisé et facile à maintenir
5. **Réutilisabilité** : Les BLoCs peuvent être réutilisés dans différents widgets

## Utilisation

### Dans main.dart
```dart
MultiBlocProvider(
  providers: [
    BlocProvider<BookSearchBloc>(
      create: (context) => BookSearchBloc(apiService: ApiService()),
    ),
    BlocProvider<FavoritesBloc>(
      create: (context) => FavoritesBloc(databaseService: DatabaseService())
        ..add(const LoadFavorites()),
    ),
  ],
  child: MaterialApp(...),
)
```

### Dans les widgets
```dart
// Déclencher un événement
context.read<BookSearchBloc>().add(SearchBooks(query));

// Écouter les changements d'état
BlocBuilder<BookSearchBloc, BookSearchState>(
  builder: (context, state) {
    if (state is BookSearchLoading) {
      return CircularProgressIndicator();
    }
    // ...
  },
)

// Écouter pour les effets de bord
BlocListener<FavoritesBloc, FavoritesState>(
  listener: (context, state) {
    if (state is FavoriteOperationSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.message)),
      );
    }
  },
  child: ...,
)
```

## Migration depuis l'ancienne architecture

1. ✅ Ajout des dépendances BLoC
2. ✅ Création de la structure BLoC
3. ✅ Refactorisation des services
4. ✅ Création des nouveaux écrans avec BLoC
5. ✅ Configuration des BlocProviders
6. 🔄 Suppression des anciens fichiers (optionnel)
7. 🔄 Tests unitaires pour les BLoCs

## Commandes pour exécuter le projet

```bash
# Installer les dépendances
flutter pub get

# Exécuter l'application
flutter run

# Exécuter sur un appareil spécifique
flutter run -d windows
flutter run -d chrome
```
