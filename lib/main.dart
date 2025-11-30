import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:receive_intent/receive_intent.dart' as receive_intent;
import 'package:squillo/core/constants/app_theme.dart';
import 'package:squillo/core/network/api_client.dart';
import 'package:squillo/features/import/bloc/import_bloc.dart';
import 'package:squillo/features/import/data/datasources/import_remote_datasource.dart';
import 'package:squillo/features/import/data/repositories/import_repository.dart';
import 'package:squillo/features/import/presentation/screens/import_screen.dart';
import 'package:squillo/features/personal_recipes/bloc/personal_recipes_bloc.dart';
import 'package:squillo/features/personal_recipes/data/datasources/recipes_remote_datasource.dart';
import 'package:squillo/features/personal_recipes/data/repositories/recipes_repository.dart';
import 'package:squillo/features/personal_recipes/presentation/screens/personal_recipes_screen.dart';
import 'package:squillo/features/recipe_detail/bloc/recipe_detail_bloc.dart';
import 'package:squillo/features/techniques/data/datasources/techniques_remote_datasource.dart';
import 'package:squillo/features/techniques/data/repositories/techniques_repository.dart';

// Service locator instance
final getIt = GetIt.instance;

void main() {
  // Setup dependency injection
  setupDependencies();

  runApp(const MainApp());
}

/// Setup dependency injection with GetIt.
void setupDependencies() {
  // Core - API Client
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Data sources
  getIt.registerLazySingleton<RecipesRemoteDataSourceImpl>(
    () => RecipesRemoteDataSourceImpl(dio: getIt<ApiClient>().dio),
  );

  getIt.registerLazySingleton<TechniquesRemoteDataSourceImpl>(
    () => TechniquesRemoteDataSourceImpl(dio: getIt<ApiClient>().dio),
  );

  getIt.registerLazySingleton<ImportRemoteDataSourceImpl>(
    () => ImportRemoteDataSourceImpl(dio: getIt<ApiClient>().dio),
  );

  // Repositories
  getIt.registerLazySingleton<RecipesRepository>(
    () => RecipesRepository(
      remoteDataSource: getIt<RecipesRemoteDataSourceImpl>(),
    ),
  );

  getIt.registerLazySingleton<TechniquesRepository>(
    () => TechniquesRepository(
      remoteDataSource: getIt<TechniquesRemoteDataSourceImpl>(),
    ),
  );

  getIt.registerLazySingleton<ImportRepository>(
    () =>
        ImportRepository(remoteDataSource: getIt<ImportRemoteDataSourceImpl>()),
  );

  // Blocs
  getIt.registerFactory<PersonalRecipesBloc>(
    () => PersonalRecipesBloc(repository: getIt<RecipesRepository>()),
  );

  getIt.registerFactory<RecipeDetailBloc>(
    () => RecipeDetailBloc(
      repository: getIt<RecipesRepository>(),
      techniquesRepository: getIt<TechniquesRepository>(),
    ),
  );

  getIt.registerFactory<ImportBloc>(
    () => ImportBloc(repository: getIt<ImportRepository>()),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  StreamSubscription<receive_intent.Intent?>? _intentSubscription;

  @override
  void initState() {
    super.initState();
    _initShareIntentListener();
  }

  @override
  void dispose() {
    _intentSubscription?.cancel();
    super.dispose();
  }

  /// Initialize listener for share intents from other apps.
  Future<void> _initShareIntentListener() async {
    // Listen for share intents when app is already running
    _intentSubscription = receive_intent.ReceiveIntent.receivedIntentStream
        .listen((intent) {
          _handleShareIntent(intent);
        });

    // Check if app was opened with a share intent
    try {
      final intent = await receive_intent.ReceiveIntent.getInitialIntent();
      if (intent != null) {
        _handleShareIntent(intent);
      }
    } catch (e) {
      // Handle error
    }
  }

  /// Handles share intent from other apps.
  void _handleShareIntent(receive_intent.Intent? intent) {
    if (intent == null) return;

    // Extract shared text (URL) from the intent
    final sharedText = intent.extra?['android.intent.extra.TEXT'];
    if (sharedText == null || sharedText.toString().isEmpty) return;

    final url = sharedText.toString();

    // Navigate to import screen with the shared URL
    Future.delayed(const Duration(milliseconds: 500), () {
      navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<ImportBloc>(),
            child: ImportScreen(initialUrl: url),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'Squillo',
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => getIt<PersonalRecipesBloc>(),
        child: const PersonalRecipesScreen(),
      ),
    );
  }
}
