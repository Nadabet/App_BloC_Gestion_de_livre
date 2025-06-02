# 🤝 Guide de Contribution

Merci de votre intérêt pour contribuer au Gestionnaire de Livres ! Ce guide vous aidera à comprendre comment contribuer efficacement au projet.

## 📋 Table des Matières

- [🚀 Démarrage Rapide](#-démarrage-rapide)
- [🏗️ Architecture du Projet](#️-architecture-du-projet)
- [📝 Standards de Code](#-standards-de-code)
- [🔄 Processus de Contribution](#-processus-de-contribution)
- [🧪 Tests](#-tests)
- [📚 Documentation](#-documentation)
- [🐛 Signalement de Bugs](#-signalement-de-bugs)
- [💡 Suggestions de Fonctionnalités](#-suggestions-de-fonctionnalités)

## 🚀 Démarrage Rapide

### Prérequis
- Flutter SDK (≥ 3.7.2)
- Dart SDK
- Git
- IDE avec support Flutter (VS Code, Android Studio)

### Configuration de l'Environnement

```bash
# 1. Fork et cloner le repository
git clone https://github.com/VOTRE-USERNAME/gestionnaire-livres-bloc.git
cd gestionnaire-livres-bloc

# 2. Installer les dépendances
flutter pub get

# 3. Vérifier que tout fonctionne
flutter test
flutter run -d chrome
```

## 🏗️ Architecture du Projet

### Pattern BLoC
Ce projet utilise l'architecture BLoC. Familiarisez-vous avec :
- **Events** : Actions utilisateur ou système
- **States** : États de l'application
- **BLoCs** : Logique métier pure

### Structure des Dossiers
```
lib/
├── bloc/           # Logique métier BLoC
├── models/         # Modèles de données
├── screens/        # Écrans de l'application
├── services/       # Services (API, DB, Storage)
├── widgets/        # Composants UI réutilisables
└── main.dart       # Point d'entrée
```

## 📝 Standards de Code

### Conventions de Nommage
```dart
// Classes : PascalCase
class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {}

// Variables et fonctions : camelCase
final List<Book> searchResults = [];
void onSearchPressed() {}

// Constantes : SCREAMING_SNAKE_CASE
static const String API_BASE_URL = 'https://api.example.com';

// Fichiers : snake_case
book_search_bloc.dart
favorites_page.dart
```

### Structure des BLoCs
```dart
// 1. Events
abstract class BookSearchEvent extends Equatable {
  const BookSearchEvent();
  @override
  List<Object?> get props => [];
}

// 2. States
abstract class BookSearchState extends Equatable {
  const BookSearchState();
  @override
  List<Object?> get props => [];
}

// 3. BLoC
class BookSearchBloc extends Bloc<BookSearchEvent, BookSearchState> {
  BookSearchBloc() : super(const BookSearchInitial()) {
    on<SearchBooks>(_onSearchBooks);
  }
}
```

### Widgets Réutilisables
```dart
class CustomWidget extends StatelessWidget {
  const CustomWidget({
    super.key,
    required this.requiredParam,
    this.optionalParam,
  });

  final String requiredParam;
  final String? optionalParam;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Implementation
    );
  }
}
```

### Gestion d'Erreurs
```dart
try {
  final result = await apiService.fetchData();
  emit(SuccessState(result));
} catch (e) {
  emit(ErrorState('Erreur lors du chargement: ${e.toString()}'));
}
```

## 🔄 Processus de Contribution

### 1. Choisir une Tâche
- Consultez les [Issues](https://github.com/VOTRE-USERNAME/gestionnaire-livres-bloc/issues)
- Choisissez une issue avec le label `good first issue` pour commencer
- Commentez l'issue pour indiquer que vous travaillez dessus

### 2. Créer une Branche
```bash
# Créer une branche depuis main
git checkout main
git pull origin main
git checkout -b feature/nom-de-la-fonctionnalite

# Ou pour un bugfix
git checkout -b fix/description-du-bug
```

### 3. Développer
- Suivez les standards de code
- Ajoutez des tests si nécessaire
- Documentez les changements importants
- Committez régulièrement avec des messages clairs

### 4. Messages de Commit
Utilisez le format [Conventional Commits](https://www.conventionalcommits.org/) :

```bash
# Nouvelles fonctionnalités
git commit -m "feat: ajouter recherche vocale"

# Corrections de bugs
git commit -m "fix: corriger l'affichage des couvertures"

# Documentation
git commit -m "docs: mettre à jour le README"

# Refactoring
git commit -m "refactor: simplifier le BookSearchBloc"

# Tests
git commit -m "test: ajouter tests pour FavoritesBloc"
```

### 5. Pull Request
```bash
# Pousser la branche
git push origin feature/nom-de-la-fonctionnalite

# Créer une Pull Request sur GitHub
```

#### Template de Pull Request
```markdown
## 📝 Description
Brève description des changements

## 🎯 Type de Changement
- [ ] 🐛 Correction de bug
- [ ] ✨ Nouvelle fonctionnalité
- [ ] 🔧 Refactoring
- [ ] 📚 Documentation
- [ ] 🧪 Tests

## 🧪 Tests
- [ ] Tests unitaires ajoutés/mis à jour
- [ ] Tests d'intégration vérifiés
- [ ] Application testée manuellement

## 📱 Captures d'Écran
(Si applicable)

## ✅ Checklist
- [ ] Code suit les standards du projet
- [ ] Documentation mise à jour
- [ ] Tests passent
- [ ] Pas de warnings/erreurs
```

## 🧪 Tests

### Tests Unitaires
```dart
// test/bloc/book_search_bloc_test.dart
void main() {
  group('BookSearchBloc', () {
    late BookSearchBloc bloc;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      bloc = BookSearchBloc(apiService: mockApiService);
    });

    test('initial state is BookSearchInitial', () {
      expect(bloc.state, equals(const BookSearchInitial()));
    });

    blocTest<BookSearchBloc, BookSearchState>(
      'emits [BookSearchLoading, BookSearchSuccess] when search succeeds',
      build: () => bloc,
      act: (bloc) => bloc.add(const SearchBooks('flutter')),
      expect: () => [
        const BookSearchLoading(),
        isA<BookSearchSuccess>(),
      ],
    );
  });
}
```

### Lancer les Tests
```bash
# Tous les tests
flutter test

# Tests spécifiques
flutter test test/bloc/book_search_bloc_test.dart

# Tests avec couverture
flutter test --coverage
```

## 📚 Documentation

### Code Documentation
```dart
/// Service pour interagir avec l'API Google Books
/// 
/// Fournit des méthodes pour rechercher des livres et récupérer
/// leurs détails depuis l'API Google Books.
class ApiService {
  /// Recherche des livres basée sur une requête
  /// 
  /// [query] Le terme de recherche
  /// [maxResults] Nombre maximum de résultats (défaut: 40)
  /// 
  /// Retourne une liste de [Book] correspondant à la recherche
  /// Lance une [Exception] en cas d'erreur réseau
  Future<List<Book>> searchBooks(String query, {int maxResults = 40}) async {
    // Implementation
  }
}
```

### README et Documentation
- Mettez à jour le README si vous ajoutez des fonctionnalités
- Documentez les nouvelles APIs
- Ajoutez des exemples d'utilisation

## 🐛 Signalement de Bugs

### Template d'Issue Bug
```markdown
## 🐛 Description du Bug
Description claire et concise du problème

## 🔄 Étapes pour Reproduire
1. Aller à '...'
2. Cliquer sur '...'
3. Faire défiler jusqu'à '...'
4. Voir l'erreur

## ✅ Comportement Attendu
Description de ce qui devrait se passer

## 📱 Captures d'Écran
(Si applicable)

## 🖥️ Environnement
- OS: [ex: Windows 11]
- Flutter: [ex: 3.16.0]
- Navigateur: [ex: Chrome 120]

## 📝 Contexte Additionnel
Toute autre information utile
```

## 💡 Suggestions de Fonctionnalités

### Template d'Issue Feature
```markdown
## 🚀 Fonctionnalité Demandée
Description claire de la fonctionnalité souhaitée

## 🎯 Problème Résolu
Quel problème cette fonctionnalité résoudrait-elle ?

## 💡 Solution Proposée
Description de la solution que vous aimeriez voir

## 🔄 Alternatives Considérées
Autres solutions ou fonctionnalités considérées

## 📝 Contexte Additionnel
Toute autre information ou capture d'écran
```

## 🏷️ Labels GitHub

- `bug` : Problème confirmé
- `enhancement` : Nouvelle fonctionnalité
- `good first issue` : Bon pour les débutants
- `help wanted` : Aide externe souhaitée
- `documentation` : Améliorations de documentation
- `question` : Question ou discussion
- `wontfix` : Ne sera pas corrigé
- `duplicate` : Problème ou demande dupliquée

## 🎯 Priorités de Contribution

### 🔥 Haute Priorité
- Corrections de bugs critiques
- Améliorations de performance
- Problèmes de sécurité

### 🚀 Moyenne Priorité
- Nouvelles fonctionnalités
- Améliorations UX/UI
- Refactoring de code

### 📚 Basse Priorité
- Documentation
- Tests supplémentaires
- Optimisations mineures

## 🤝 Code de Conduite

- Soyez respectueux et inclusif
- Acceptez les critiques constructives
- Concentrez-vous sur ce qui est le mieux pour la communauté
- Montrez de l'empathie envers les autres membres

## 📞 Contact

- **Issues GitHub** : Pour bugs et fonctionnalités
- **Discussions** : Pour questions générales
- **Email** : votre.email@example.com

---

<div align="center">

**🙏 Merci de contribuer au Gestionnaire de Livres !**

Votre aide rend ce projet meilleur pour tout le monde.

</div>
