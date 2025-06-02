import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'screens/home_page_bloc.dart';
import 'services/api_service.dart';
import 'services/storage_service.dart';
import 'bloc/bloc_exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    // Configuration pour desktop/mobile seulement
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  // Pour le web, on utilise le stockage en mémoire

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<BookSearchBloc>(
          create: (context) => BookSearchBloc(apiService: ApiService()),
        ),
        BlocProvider<FavoritesBloc>(
          create: (context) => FavoritesBloc(
            storageService: StorageServiceFactory.create(),
          )..add(const LoadFavorites()),
        ),
      ],
      child: MaterialApp(
        title: 'Gestionnaire de Livres',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF2196F3),
            brightness: Brightness.light,
          ),
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 12,
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}



