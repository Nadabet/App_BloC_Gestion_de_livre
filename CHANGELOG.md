# 📝 Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2024-01-XX - 🚀 **Refactorisation BLoC Majeure**

### ✨ Ajouté
- **Architecture BLoC complète** avec séparation des responsabilités
- **Nouveaux widgets personnalisés** pour l'affichage des livres
- **Système de vue dynamique** (Liste/Grille) avec basculement fluide
- **Design Material 3** avec thème personnalisé
- **Couvertures de livres optimisées** avec fallback élégant
- **Dialog de détails amélioré** avec design immersif
- **Gestion d'états robuste** avec BlocBuilder et BlocListener
- **Service de stockage abstrait** pour multi-plateforme
- **Support web** avec stockage en mémoire
- **Animations et transitions** fluides
- **Feedback visuel** pour toutes les interactions

### 🎨 Design
- **AppBar avec gradient** et icône personnalisée
- **Barre de recherche moderne** avec ombres et bordures arrondies
- **Cartes de livres redesignées** avec deux modes d'affichage
- **Boutons favoris** avec états visuels améliorés
- **Placeholder pour couvertures** avec dégradé bleu
- **États vides** avec illustrations et messages explicites
- **Toggle buttons** pour basculer entre les vues
- **Indicateur de résultats** de recherche

### 🏗️ Architecture
- **BookSearchBloc** pour la gestion de la recherche
- **FavoritesBloc** pour la gestion des favoris
- **Events et States** bien définis pour chaque BLoC
- **Services refactorisés** avec interfaces claires
- **Widgets réutilisables** dans le dossier widgets/
- **Exports centralisés** pour une meilleure organisation

### 🔧 Technique
- **flutter_bloc: ^8.1.3** pour la gestion d'état
- **equatable: ^2.0.5** pour la comparaison d'objets
- **Stockage multi-plateforme** (SQLite + mémoire)
- **Gestion d'erreurs améliorée** avec try-catch robustes
- **Performance optimisée** avec rebuilds ciblés

### 📱 UX/UI
- **Navigation intuitive** avec onglets en bas
- **Recherche en temps réel** avec debouncing
- **Confirmation de suppression** pour éviter les erreurs
- **Pull-to-refresh** sur la page favoris
- **Loading states** avec indicateurs visuels
- **Messages d'erreur** contextuels et utiles

### 🐛 Corrigé
- **Problèmes de synchronisation** entre recherche et favoris
- **Gestion des erreurs API** améliorée
- **Performance** lors du basculement entre vues
- **États incohérents** lors des opérations favoris
- **Affichage des couvertures** avec fallback approprié

### 📚 Documentation
- **README complet** avec architecture et utilisation
- **Documentation BLoC** avec diagrammes de flux
- **Guide de contribution** et standards de code
- **Changelog détaillé** pour suivre les évolutions

---

## [1.0.0] - 2024-01-XX - 🎯 **Version Initiale**

### ✨ Ajouté
- **Recherche de livres** via l'API Google Books
- **Affichage des résultats** avec informations de base
- **Gestion des favoris** avec stockage SQLite
- **Interface Material Design** basique
- **Navigation** entre recherche et favoris
- **Détails des livres** dans un dialog simple

### 🏗️ Architecture Initiale
- **StatefulWidget** pour la gestion d'état
- **Services séparés** pour API et base de données
- **Modèle Book** pour les données
- **Structure MVC** basique

### 📱 Fonctionnalités de Base
- Recherche de livres par titre/auteur
- Ajout/suppression de favoris
- Affichage des couvertures de livres
- Stockage local avec SQLite
- Interface responsive basique

### 🎨 Design Initial
- Material Design 2
- AppBar simple
- ListTile pour l'affichage des livres
- Dialog basique pour les détails
- Couleurs par défaut Flutter

---

## 🔮 **Versions Futures Prévues**

### [2.1.0] - **Améliorations UX**
- Mode sombre/clair
- Recherche vocale
- Filtres avancés
- Tri des résultats

### [2.2.0] - **Fonctionnalités Sociales**
- Partage de favoris
- Recommandations
- Notes et commentaires
- Synchronisation cloud

### [2.3.0] - **Performance et Accessibilité**
- Optimisations performance
- Support accessibilité
- Localisation multilingue
- Tests automatisés

---

## 📊 **Métriques par Version**

| Version | Lignes de Code | Widgets | BLoCs | Tests | Performance |
|---------|----------------|---------|-------|-------|-------------|
| 1.0.0   | ~800          | 2       | 0     | 0     | Basique     |
| 2.0.0   | ~2000         | 8       | 2     | 0     | Optimisée   |

---

## 🏷️ **Types de Changements**

- `✨ Ajouté` pour les nouvelles fonctionnalités
- `🔧 Modifié` pour les changements dans les fonctionnalités existantes
- `🐛 Corrigé` pour les corrections de bugs
- `🗑️ Supprimé` pour les fonctionnalités supprimées
- `🔒 Sécurité` pour les corrections de vulnérabilités
- `🎨 Design` pour les améliorations visuelles
- `⚡ Performance` pour les optimisations
- `📚 Documentation` pour les améliorations de documentation

---

<div align="center">

**📝 Ce changelog est maintenu manuellement et suit les standards de l'industrie**

</div>
