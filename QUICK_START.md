# ⚡ Guide de Démarrage Rapide

Ce guide vous permettra de faire fonctionner l'application en moins de 5 minutes !

## 🚀 Installation Express

### 1️⃣ Prérequis (2 min)
```bash
# Vérifiez que Flutter est installé
flutter --version

# Si pas installé, suivez : https://flutter.dev/docs/get-started/install
```

### 2️⃣ Clonage et Setup (1 min)
```bash
# Cloner le repository
git clone https://github.com/votre-username/gestionnaire-livres-bloc.git
cd gestionnaire-livres-bloc

# Installer les dépendances
flutter pub get
```

### 3️⃣ Lancement (30 sec)
```bash
# Lancer sur le web (recommandé pour tester)
flutter run -d chrome

# Ou sur votre plateforme préférée
flutter run -d windows  # Windows
flutter run -d macos    # macOS
flutter run -d linux    # Linux
```

## 🎯 Première Utilisation

### ✅ Test de l'Application
1. **Recherche** : Tapez "flutter" dans la barre de recherche
2. **Vue** : Basculez entre liste et grille avec les boutons toggle
3. **Favoris** : Cliquez sur le cœur pour ajouter un livre aux favoris
4. **Détails** : Cliquez sur un livre pour voir ses détails
5. **Navigation** : Utilisez les onglets en bas pour naviguer

### 🔧 Commandes Utiles

```bash
# Hot reload (pendant le développement)
r

# Hot restart (redémarrage complet)
R

# Quitter l'application
q

# Analyser le code
flutter analyze

# Formater le code
dart format .

# Lancer les tests
flutter test
```

## 🏗️ Structure Rapide

```
lib/
├── 📁 bloc/                    # 🧠 Logique métier
│   ├── book_search/           # Recherche de livres
│   └── favorites/             # Gestion des favoris
├── 📁 models/                 # 📊 Modèles de données
├── 📁 screens/                # 📱 Écrans principaux
├── 📁 services/               # 🔧 Services (API, DB)
├── 📁 widgets/                # 🎨 Composants UI
└── main.dart                  # 🚀 Point d'entrée
```

## 🎨 Fonctionnalités Clés

### 🔍 Recherche
- Tapez dans la barre de recherche
- Résultats en temps réel
- 40 livres par recherche

### 📚 Affichage
- **Liste** : Vue détaillée avec descriptions
- **Grille** : Vue visuelle avec couvertures
- **Basculement** : Toggle en haut à droite

### ❤️ Favoris
- **Ajouter** : Cliquez sur le cœur vide
- **Supprimer** : Cliquez sur le cœur rouge
- **Gérer** : Onglet "Favoris" en bas

### 🎯 Détails
- **Ouvrir** : Cliquez sur n'importe quel livre
- **Informations** : Titre, auteur, description
- **Actions** : Ajouter/retirer des favoris

## 🐛 Résolution de Problèmes

### ❌ Erreurs Communes

#### "Flutter not found"
```bash
# Ajoutez Flutter au PATH
export PATH="$PATH:/path/to/flutter/bin"
```

#### "No devices found"
```bash
# Vérifiez les appareils disponibles
flutter devices

# Activez le web
flutter config --enable-web
```

#### "Pub get failed"
```bash
# Nettoyez et réinstallez
flutter clean
flutter pub get
```

#### "Build failed"
```bash
# Vérifiez la version de Flutter
flutter --version

# Mettez à jour si nécessaire
flutter upgrade
```

### 🌐 Problèmes Web Spécifiques

#### CORS Errors
- Normal en développement
- L'API Google Books fonctionne correctement

#### SQLite Web
- Utilise le stockage en mémoire
- Les favoris ne persistent pas entre les sessions
- Normal et attendu

## 📱 Plateformes Testées

| Plateforme | Status | Notes |
|------------|--------|-------|
| 🌐 Web | ✅ | Recommandé pour tester |
| 🪟 Windows | ✅ | Nécessite mode développeur |
| 🐧 Linux | ✅ | Fonctionne parfaitement |
| 🍎 macOS | ✅ | Support natif |
| 🤖 Android | ✅ | APK ~15MB |
| 📱 iOS | ✅ | Nécessite Xcode |

## 🎯 Prochaines Étapes

### 🔰 Débutant
1. Explorez l'interface utilisateur
2. Testez toutes les fonctionnalités
3. Regardez le code dans `lib/screens/`

### 🚀 Développeur
1. Étudiez l'architecture BLoC dans `lib/bloc/`
2. Examinez les widgets personnalisés dans `lib/widgets/`
3. Consultez les services dans `lib/services/`

### 🏗️ Contributeur
1. Lisez [CONTRIBUTING.md](CONTRIBUTING.md)
2. Consultez les [Issues GitHub](https://github.com/votre-username/gestionnaire-livres-bloc/issues)
3. Choisissez une tâche `good first issue`

## 📚 Documentation Complète

- 📖 [README.md](README.md) - Documentation principale
- 🏗️ [ARCHITECTURE_BLOC.md](ARCHITECTURE_BLOC.md) - Architecture BLoC
- 🎨 [DESIGN_IMPROVEMENTS.md](DESIGN_IMPROVEMENTS.md) - Améliorations design
- 📝 [CHANGELOG.md](CHANGELOG.md) - Historique des versions
- 🤝 [CONTRIBUTING.md](CONTRIBUTING.md) - Guide de contribution

## 🆘 Besoin d'Aide ?

### 💬 Support
- **Issues GitHub** : [Créer une issue](https://github.com/votre-username/gestionnaire-livres-bloc/issues/new)
- **Discussions** : [GitHub Discussions](https://github.com/votre-username/gestionnaire-livres-bloc/discussions)
- **Email** : votre.email@example.com

### 📖 Ressources
- [Documentation Flutter](https://flutter.dev/docs)
- [BLoC Library](https://bloclibrary.dev/)
- [Material Design 3](https://m3.material.io/)
- [Google Books API](https://developers.google.com/books)

---

<div align="center">

**🎉 Félicitations ! Vous êtes prêt à utiliser l'application !**

**⭐ N'oubliez pas de donner une étoile au projet si vous l'aimez !**

</div>
