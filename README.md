# Rapport de TP : Gestion des Données BLOC 
# Application de Gestion de Bibliothèque Personnelle
# Introduction

Dans le cadre du module de gestion des données et de l’architecture logicielle, ce travail pratique a pour objectif de reconstruire l'application BookApp en adoptant le modèle d’architecture BLoC (Business Logic Component). Cette approche permet de mieux séparer la logique métier de l’interface utilisateur, favorisant ainsi une application plus maintenable, évolutive et testable.

L’application vise toujours à permettre aux utilisateurs de rechercher des livres via l’API Google Books et de gérer leurs favoris localement à l’aide de la base de données SQLite. Cependant, l’accent est désormais mis sur l’implémentation rigoureuse du pattern BLoC pour gérer les états et les interactions avec les données, aussi bien distantes que locales.

Ce projet permet de mettre en pratique plusieurs compétences clés :

L’utilisation de l’architecture BLoC pour la gestion d’état

L’intégration d’une API REST externe (Google Books)

La persistance locale des données avec SQLite

La synchronisation entre les données distantes et locales de manière réactive

Grâce à cette refonte, les étudiants consolideront leurs connaissances sur l’architecture Flutter moderne et la gestion efficace des données dans une application mobile.
 # 📚 Book Manager App – Version BLoC
Une application mobile Flutter permettant de rechercher et de gérer vos livres préférés en s’appuyant sur l’API Google Books, tout en adoptant l’architecture BLoC pour une meilleure gestion de l’état et de la logique métier.
# 📄 Table des matières
Introduction
Aperçu de l'application
Fonctionnalités
Technologies utilisées
Architecture BLoC
Captures d’écran
API utilisée
# 🧩 Aperçu
Book Manager App est une application Flutter qui permet aux utilisateurs de :
Rechercher des livres en ligne via l’API Google Books
Consulter les informations détaillées sur chaque livre
Sauvegarder leurs livres favoris localement grâce à une base de données SQLite
Profiter d’une interface fluide et intuitive conforme aux principes du Material Design 3
Cette version a été entièrement reconstruite selon le modèle BLoC (Business Logic Component), ce qui permet une séparation claire entre la logique métier et l’interface utilisateur.
# ✨ Fonctionnalités
🔍 Recherche de livres en temps réel via l'API Google Books
📖 Affichage des détails d’un livre sélectionné
❤️ Ajout et suppression des livres dans la liste de favoris
💾 Persistance locale des favoris avec SQLite
🔄 Synchronisation entre les données distantes et locales
🎨 Interface moderne utilisant Material Design 3
# 🛠️ Technologies utilisées
Flutter & Dart
BLoC / flutter_bloc pour la gestion d’état
SQLite pour la base de données locale
Google Books API pour la recherche de livres
HTTP pour les appels réseau
# 🧱 Architecture – Pattern BLoC
L'application suit une architecture en couches basée sur le modèle BLoC :
Presentation Layer : UI & widgets réactifs
Business Logic Layer : blocs/cubits pour la gestion des événements et des états
Data Layer : accès à l’API Google Books et à la base de données SQLite
Cette séparation améliore la maintenabilité, les tests et la réutilisabilité du code.
# Captures d’écran
![Page d'accueil](img\screenshot\book_1.png)
Description : Interface principale de recherche de livres.

![Résultats de recherche](img\screenshot\book_2.png)
Description : Affichage des résultats de recherche avec images et informations de base.


![Détails du livre](img\screenshot\book_3.png)
Description : Vue détaillée d'un livre avec description complète.

![Page des favoris](img\screenshot\book_4.png)
![Page des favoris](img\screenshot\book_5.png)
![Page des favoris](img\screenshot\book_6.png)
Description : Liste des livres sauvegardés en favoris
 # 🗂️ Structure du projet
L’architecture du projet suit une organisation claire, facilitant la lisibilité, la maintenance et l’évolution du code. Voici un aperçu des principaux répertoires et de leur rôle dans l’application :
/lib
│
├── blocs/                 → Contient tous les blocs et cubits (gestion d'état)
│   ├── book_bloc.dart         → Bloc principal pour la gestion des livres
│   ├── favorites_cubit.dart   → Cubit pour la gestion des favoris
│   └── ...                   
│
├── models/                → Modèles de données (Book, etc.)
│   └── book_model.dart
│
├── repositories/          → Classes intermédiaires pour accéder aux données
│   ├── book_repository.dart   → Communication avec l’API Google Books
│   └── local_repository.dart → Accès à la base de données SQLite
│
├── services/              → Services d’abstraction pour SQLite ou l’API
│   ├── api_service.dart
│   └── database_service.dart
│
├── screens/               → Écrans principaux de l’application
│   ├── home_screen.dart
│   ├── details_screen.dart
│   └── favorites_screen.dart
│
├── widgets/               → Composants réutilisables (cards, loaders, etc.)
│   └── book_card.dart
│
├── utils/                 → Fichiers utilitaires (constants, helpers)
│   └── constants.dart
│
└── main.dart              → Point d’entrée de l’application
# 🔄 Fonctionnement global
UI (screens/widgets) interagit avec les blocs/cubits.
Blocs/Cubits gèrent les événements et mettent à jour l'état.
Repositories récupèrent les données depuis l’API ou SQLite.
Services encapsulent les appels bas niveau (HTTP, SQLite).
Models représentent les structures de données échangées.
L’application réagit automatiquement grâce à la gestion d’état BLoC.
<!-- Dernière modification : 3 juin 2025 -->

